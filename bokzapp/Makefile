.PHONY: bootstrap dev test e2e build

bootstrap:
	flutter pub get
	flutter pub run build_runner build --delete-conflicting-outputs
	@if [ "$(USE_FIREBASE)" = "true" ]; then \
		echo "Configuring Firebase..."; \
		flutterfire configure; \
	fi

dev:
	flutter run --dart-define=USE_FIREBASE=${USE_FIREBASE:-false} \
				--dart-define=USE_SYNC=${USE_SYNC:-true} \
				--dart-define=USE_AI=${USE_AI:-false}

test:
	flutter test

e2e:
	flutter test integration_test

build.web:
	flutter build web --release \
		--dart-define=USE_FIREBASE=${USE_FIREBASE:-false} \
		--dart-define=USE_SYNC=${USE_SYNC:-true} \
		--dart-define=USE_AI=${USE_AI:-false}

build.android:
	flutter build apk --release \
		--dart-define=USE_FIREBASE=${USE_FIREBASE:-false} \
		--dart-define=USE_SYNC=${USE_SYNC:-true} \
		--dart-define=USE_AI=${USE_AI:-false}

build.ios:
	flutter build ios --release \
		--dart-define=USE_FIREBASE=${USE_FIREBASE:-false} \
		--dart-define=USE_SYNC=${USE_SYNC:-true} \
		--dart-define=USE_AI=${USE_AI:-false}

build.macos:
	flutter build macos --release \
		--dart-define=USE_FIREBASE=${USE_FIREBASE:-false} \
		--dart-define=USE_SYNC=${USE_SYNC:-true} \
		--dart-define=USE_AI=${USE_AI:-false}

build.windows:
	flutter build windows --release \
		--dart-define=USE_FIREBASE=${USE_FIREBASE:-false} \
		--dart-define=USE_SYNC=${USE_SYNC:-true} \
		--dart-define=USE_AI=${USE_AI:-false}