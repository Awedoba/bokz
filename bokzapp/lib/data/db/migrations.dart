import 'package:drift/drift.dart';

/// Migration helper to upgrade Drift database schemas.
/// Usage: Add new migrations as static methods, then call them
/// in the AppDatabase.migration getter.
class DbMigrations {
  /// V1 -> V2: Add highlights table
  static Future<void> addHighlightsTable(Migrator m) async {
    // Legacy helper kept for reference. In the current migration strategy
    // we perform upgrades via Drift's migration APIs in AppDatabase.
    // This helper is intentionally a no-op to avoid circular imports.
    return;
  }

  /// Instance method used by AppDatabase migration runner.
  /// Kept as no-ops for now to avoid import cycles with generated table classes.
  Future<void> v1tov2(Migrator m) async {
    // No-op migration placeholder.
    return;
  }

  Future<void> v2tov3(Migrator m) async {
    // No-op migration placeholder.
    return;
  }
}
