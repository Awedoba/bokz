# AI Coding Assistant Instructions for ReadEase

## Project Overview
ReadEase is a cross-platform reading application built with Flutter, supporting PDF, EPUB, and audiobook formats with offline-first sync and AI features. The app follows a feature-first architecture with clean separation of concerns.

## Key Architecture Components

### Core Structure
```
lib/
  main.dart              # App entry point
  app_router.dart        # GoRouter configuration
  theme/                 # App theming and styling
  core/                  # Core utilities (errors, result, logging)
  data/                 
    db/                 # Drift tables + DAOs
    repositories/       # Data access layer
    models/            # Core entity models
    sync/              # Sync infrastructure
  services/            # Cross-cutting concerns
    notifications/     # Local notifications
    tts/              # Text-to-speech
    ai/               # AI features (gated)
    file_import/      # File handling
  features/           # Feature modules
    library/         
    explore/
    reader_epub/
    reader_pdf/
    player_audio/
    notes/
    stats/
    auth/
    settings/
    ai/
```

### Key Entities
- `Book`: Core content model with metadata
- `ReadingPosition`: Progress tracking
- `Bookmark/Highlight`: User annotations
- `DailyStat`: Reading statistics
- `Settings`: User preferences
- `User`: Authentication state (optional)

## Development Workflows

### Environment Setup
```bash
make bootstrap        # Install dependencies and configure Firebase (if enabled)
make dev             # Run with development flags
make test           # Run unit and widget tests
make e2e            # Run integration tests
```

### Build Commands
```bash
make build:web      # Build web (PWA)
make build:android  # Build Android app
make build:ios      # Build iOS app
make build:macos    # Build macOS app
make build:windows  # Build Windows app
```

### Feature Flags
Configure behavior with `--dart-define`:
- `USE_FIREBASE=false` # Enable Firebase/Firestore backend
- `USE_SYNC=true`     # Enable sync functionality
- `USE_AI=false`      # Enable AI features

### Testing
Widget tests are in `test/widget_test.dart`. Use `WidgetTester` for interaction testing:
```dart
testWidgets('test name', (WidgetTester tester) async {
  await tester.pumpWidget(const MyApp());
  // Interact and verify
});
```

## Core Dependencies and Patterns

### State Management
- Riverpod + hooks_riverpod for app-wide state
- Local persistence with Drift (SQLite)
- Feature flags control Firebase/AI integration

### UI/UX Patterns
- Material Design 3 with custom theme (green accent)
- Offline-first with optimistic updates
- Error boundaries and empty states
- Accessibility support (44px tap targets, screen reader)

### Key Packages
- Routing: `go_router`
- Content: `pdfx`, `epub_view`, `just_audio`
- Storage: `drift`, `file_picker`, `path_provider`
- Features: `flutter_tts`, `flutter_local_notifications`
- Auth: `firebase_auth`, `google_sign_in` (optional)
- Utils: `dio`, `workmanager`, `flutter_secure_storage`

### Testing Approach
- Unit tests for business logic and repositories
- Widget tests for UI components
- Integration tests for core user flows
- Golden tests for visual regression

## Platform-Specific Considerations

### Platform Support
- Android: Full support with background audio, notifications
- iOS: Full support with background audio, notifications
- Web: PWA with offline support, limited background features
- Desktop (macOS/Windows): File associations, drag-drop support

### Platform-Specific Code
- Audio playback: Platform-specific services via `audio_service`
- File handling: Platform-specific pickers and permissions
- Background tasks: `workmanager` on mobile, timers on web
- Authentication: Platform-specific OAuth flows
- Storage: Platform-specific paths via `path_provider`

### Performance Guidelines
- Lazy loading for large documents
- Debounced search and UI updates
- Efficient image caching and loading
- Background processing for heavy operations

## Implementation Patterns

### Repository Pattern
```dart
// Core repository interface
abstract class BookRepository {
  Future<Result<Book>> getBook(String id);
  Future<Result<List<Book>>> searchBooks(String query);
  Future<Result<void>> saveBook(Book book);
}

// Concrete implementation
class DriftBookRepository implements BookRepository {
  final BookDao _bookDao;
  
  @override
  Future<Result<Book>> getBook(String id) async {
    try {
      final book = await _bookDao.getBook(id);
      return Success(book);
    } catch (e) {
      return Failure(BookError(e.toString()));
    }
  }
}
```

### Service Pattern
```dart
// Service class with dependency injection
class NotificationService {
  final FlutterLocalNotificationsPlugin _notifications;
  final Settings _settings;

  Future<void> scheduleReminder() async {
    if (!_settings.remindersEnabled) return;
    
    await _notifications.zonedSchedule(
      0,
      'Reading Reminder',
      'Time for your daily reading!',
      _nextNotificationTime(),
      NotificationDetails(/*...*/),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}
```

### State Management with Riverpod
```dart
// Provider definitions
final bookRepositoryProvider = Provider<BookRepository>((ref) {
  return DriftBookRepository(ref.watch(bookDaoProvider));
});

final currentBookProvider = StateNotifierProvider<CurrentBookNotifier, AsyncValue<Book>>((ref) {
  return CurrentBookNotifier(ref.watch(bookRepositoryProvider));
});

// StateNotifier implementation
class CurrentBookNotifier extends StateNotifier<AsyncValue<Book>> {
  final BookRepository _repository;
  
  Future<void> loadBook(String id) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final result = await _repository.getBook(id);
      return result.getOrThrow();
    });
  }
}
```

## AI Infrastructure

### AI Provider Interface
```dart
abstract class AiProvider {
  Future<String> summarizeBook(Book book);
  Future<String> summarizeChapter(Book book, String chapterId);
  Future<QaResponse> askQuestion(Book book, String question);
}

// OpenAI implementation example
class OpenAiProvider implements AiProvider {
  final OpenAI _client;
  final EmbeddingRepository _embeddings;
  
  @override
  Future<QaResponse> askQuestion(Book book, String question) async {
    // 1. Get relevant passages using embeddings
    final context = await _embeddings.findRelevantPassages(book.id, question);
    
    // 2. Construct prompt with context
    final prompt = _buildQaPrompt(question, context);
    
    // 3. Get completion from OpenAI
    final completion = await _client.complete(prompt);
    
    return QaResponse(
      answer: completion.text,
      citations: _extractCitations(context, completion.text),
    );
  }
}
```

## Sync Infrastructure

### Sync Service
```dart
class SyncService {
  final CloudApi _api;
  final LocalDatabase _db;
  final ConnectivityService _connectivity;
  
  // Background sync with retry
  Future<void> sync() async {
    if (!await _connectivity.isOnline) {
      return;
    }
    
    try {
      // 1. Get local changes
      final changes = await _db.getDirtyRecords();
      
      // 2. Push to server with retry
      await _retryWithBackoff(() => _api.push(changes));
      
      // 3. Pull remote changes
      final timestamp = await _db.getLastSyncTimestamp();
      final remoteChanges = await _api.pullSince(timestamp);
      
      // 4. Apply remote changes with conflict resolution
      await _db.transaction(() async {
        for (final change in remoteChanges) {
          await _applyChange(change);
        }
        await _db.setLastSyncTimestamp(DateTime.now());
      });
    } catch (e) {
      // Queue for retry later
      await _enqueueForRetry();
    }
  }
}
```

## Troubleshooting Guide

### Common Issues

1. **File Import Issues**
```dart
// Check file permissions
final status = await Permission.storage.status;
if (!status.isGranted) {
  await Permission.storage.request();
}

// Handle large files
if (file.lengthSync() > maxSize) {
  throw FileTooLargeException();
}
```

2. **Audio Playback**
```dart
// Background playback setup
await AudioService.init(
  builder: () => AudioPlayerTask(),
  config: AudioServiceConfig(
    androidNotificationChannelName: 'ReadEase Audio',
    androidNotificationOngoing: true,
  ),
);
```

3. **Cross-Platform File Paths**
```dart
Future<String> getStoragePath() async {
  if (Platform.isAndroid) {
    return (await getExternalStorageDirectory())?.path ?? '';
  } else if (Platform.isIOS) {
    return (await getApplicationDocumentsDirectory()).path;
  } else {
    return (await getDownloadsDirectory())?.path ?? '';
  }
}
```

### Debug Checklist

1. **Sync Issues**
- Check network connectivity
- Verify Firebase configuration (if enabled)
- Check local dirty flags in database
- Inspect sync queue in WorkManager

2. **Performance Issues**
- Enable performance overlay (`showPerformanceOverlay`)
- Check widget rebuilds with `debugPrintRebuildDirtyWidgets`
- Monitor memory usage with DevTools
- Verify image caching and preloading

3. **Platform-Specific Issues**
- iOS: Check background modes in Info.plist
- Android: Verify permissions in AndroidManifest.xml
- Web: Check service worker registration
- Desktop: Verify file associations

## Error Handling

```dart
// Result type for operation outcomes
sealed class Result<T> {
  const Result();
  
  R fold<R>(
    R Function(T) onSuccess,
    R Function(AppError) onFailure,
  );
}

// Error boundaries for UI
class ErrorBoundary extends StatelessWidget {
  final Widget child;
  
  @override
  Widget build(BuildContext context) {
    return ErrorWidget.builder = (FlutterErrorDetails details) {
      return Scaffold(
        body: Center(
          child: ErrorView(
            message: 'Something went wrong',
            onRetry: () => Navigator.of(context).pop(),
          ),
        ),
      );
    };
  }
}