FLUTTER := flutter
FLUTTER_BUILD := $(FLUTTER) build
DEFINE_FILE := env.json

ANDROID_OUTPUT := build/app/outputs/flutter-apk/app-release.apk
DROPBOX_FOLDER := ~/Dropbox/Development/Build

ios-clean:
	flutter clean && flutter pub get && rm -rf ios/Pods && rm -f ios/Podfile.lock && (cd ios && pod install)

ios-release:
	$(FLUTTER_BUILD) ipa --export-method=ad-hoc --dart-define-from-file=$(DEFINE_FILE)

ios-production:
	$(FLUTTER_BUILD) ipa --export-method=app-store --dart-define-from-file=$(DEFINE_FILE)

android-release:
	$(FLUTTER_BUILD) apk --dart-define-from-file=$(DEFINE_FILE)
	cp $(ANDROID_OUTPUT) $(DROPBOX_FOLDER)

android-production:
	$(FLUTTER_BUILD) appbundle --dart-define-from-file=$(DEFINE_FILE)