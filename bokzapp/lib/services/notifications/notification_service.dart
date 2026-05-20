import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tzdata;
import 'package:flutter/widgets.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._();
  factory NotificationService() => _instance;

  final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  NotificationService._() {
    _init();
  }

  Future<void> _init() async {
    tzdata.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('UTC'));

    final androidSettings =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    final iosSettings = const DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    final settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notifications.initialize(
      settings,
      onDidReceiveNotificationResponse: _handleNotificationTap,
    );
  }

  void _handleNotificationTap(NotificationResponse details) {
    // Handle notification tap - can be used to navigate to specific screen
    debugPrint('Notification tapped: ${details.payload}');
  }

  Future<bool> _requestPermissions() async {
    if (defaultTargetPlatform != TargetPlatform.iOS) {
      return true;
    }

    final settings = await _notifications
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );

    return settings ?? false;
  }

  Future<void> scheduleReminder(DateTime time) async {
    if (!await _requestPermissions()) {
      return;
    }

    const details = NotificationDetails(
      android: AndroidNotificationDetails(
        'reading_reminder',
        'Reading Reminders',
        channelDescription: 'Daily reading reminder notifications',
        importance: Importance.high,
        priority: Priority.high,
        enableVibration: true,
      ),
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
    );

    final scheduledTime = tz.TZDateTime.from(time, tz.local);
    if (scheduledTime.isBefore(tz.TZDateTime.now(tz.local))) {
      return;
    }

    await _notifications.zonedSchedule(
      0,
      'Time to Read',
      'Keep up your daily reading habit!',
      scheduledTime,
      details,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future<void> cancelReminders() async {
    await _notifications.cancelAll();
  }
}
