FLUTTER := flutter
FLUTTER_BUILD := $(FLUTTER) build
DEFINE_FILE := env.json

ios-release:
	$(FLUTTER_BUILD) ipa --export-method=ad-hoc --dart-define-from-file=$(DEFINE_FILE)

ios-production:
	$(FLUTTER_BUILD) ipa --export-method=app-store --dart-define-from-file=$(DEFINE_FILE)

android-release:
	$(FLUTTER_BUILD) apk --dart-define-from-file=$(DEFINE_FILE)

android-production:
	$(FLUTTER_BUILD) appbundle --dart-define-from-file=$(DEFINE_FILE)