# Dynamic compiler detection
XCODE_PATH := $(shell xcode-select -p)
XCODE_TOOLCHAIN := $(XCODE_PATH)/Toolchains/XcodeDefault.xctoolchain
CC := $(shell xcrun -find clang)
CXX := $(shell xcrun -find clang++)

# SDK paths
SDKROOT ?= $(shell xcrun --show-sdk-path)
ISYSROOT := $(shell xcrun -sdk macosx --show-sdk-path)
INCLUDE_PATH := $(shell xcrun -sdk macosx --show-sdk-platform-path)/Developer/SDKs/MacOSX.sdk/usr/include

# Compiler and flags
CFLAGS = -Wall -Wextra -O2 \
    -fobjc-arc \
    -isysroot $(SDKROOT) \
    -iframework $(SDKROOT)/System/Library/Frameworks \
    -F/System/Library/PrivateFrameworks
ARCHS = -arch x86_64 -arch arm64 -arch arm64e
FRAMEWORK_PATH = $(SDKROOT)/System/Library/Frameworks
PRIVATE_FRAMEWORK_PATH = $(SDKROOT)/System/Library/PrivateFrameworks
PUBLIC_FRAMEWORKS = -framework Foundation -framework AppKit -framework QuartzCore -framework Cocoa \
    -framework CoreFoundation

# Project name and paths
PROJECT = everest
DYLIB_NAME = lib$(PROJECT).dylib
BUILD_DIR = build
SOURCE_DIR = tweak
INSTALL_DIR = /var/ammonia/core/tweaks

# Source files
DYLIB_SOURCES = $(SOURCE_DIR)/tweak.m
DYLIB_OBJECTS = $(DYLIB_SOURCES:%.m=$(BUILD_DIR)/%.o)


# Installation targets
INSTALL_PATH = $(INSTALL_DIR)/$(DYLIB_NAME)
WHITELIST_SOURCE = lib$(PROJECT).dylib.whitelist
WHITELIST_DEST = $(INSTALL_DIR)/lib$(PROJECT).dylib.whitelist

# Dylib settings
DYLIB_FLAGS = -dynamiclib \
              -install_name @rpath/$(DYLIB_NAME) \
              -compatibility_version 1.0.0 \
              -current_version 1.0.0

# Default target
all: clean $(BUILD_DIR)/$(DYLIB_NAME)

# Create build directory and subdirectories
$(BUILD_DIR):
	@rm -rf $(BUILD_DIR)
	@mkdir -p $(BUILD_DIR)
	@mkdir -p $(BUILD_DIR)/tweak

# Compile source files
$(BUILD_DIR)/%.o: %.m | $(BUILD_DIR)
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) $(ARCHS) -c $< -o $@

# Link dylib
$(BUILD_DIR)/$(DYLIB_NAME): $(DYLIB_OBJECTS)
	$(CC) $(DYLIB_FLAGS) $(ARCHS) $(DYLIB_OBJECTS) -o $@ \
	-F$(FRAMEWORK_PATH) \
	-F$(PRIVATE_FRAMEWORK_PATH) \
	$(PUBLIC_FRAMEWORKS) \
	-L$(SDKROOT)/usr/lib

# Install dylib
install: $(BUILD_DIR)/$(DYLIB_NAME)
	@echo "Installing dylib to $(INSTALL_DIR)"
	# Create the target directory.
	sudo mkdir -p $(INSTALL_DIR)
	# Install the tweak's dylib where injection takes place.
	sudo install -m 755 $(BUILD_DIR)/$(DYLIB_NAME) $(INSTALL_DIR)
	@if [ -f $(WHITELIST_SOURCE) ]; then \
		sudo cp $(WHITELIST_SOURCE) $(WHITELIST_DEST); \
		sudo chmod 644 $(WHITELIST_DEST); \
		echo "Installed $(DYLIB_NAME) and whitelist"; \
	else \
		echo "Warning: $(WHITELIST_SOURCE) not found"; \
		echo "Installed $(DYLIB_NAME)"; \
	fi
	@killall Dock

# Clean build files
clean:
	@rm -rf $(BUILD_DIR)
	@echo "Cleaned build directory"

# Uninstall
uninstall:
	@sudo rm -f $(INSTALL_PATH)
	@sudo rm -f $(WHITELIST_DEST)
	@echo "Uninstalled $(DYLIB_NAME) and whitelist"
	@sudo rm -rf ~/Library/Application\ Support/EverestSettings

app:
	@mkdir -p app/dist
	@clang++ app/src/*.mm -framework Cocoa -o app/dist/main
	@clear

test:
	@make package
	@open app/dist/Everest.app

package:
	@rm -rf app/dist
	@make app
	@mkdir -p app/dist/Everest.app/Contents/MacOS
	@mkdir -p app/dist/Everest.app/Contents/Resources
	@cp app/dist/main app/dist/Everest.app/Contents/MacOS/Everest
	@chmod +x app/dist/Everest.app/Contents/MacOS/Everest
	@cp app/Info.plist app/dist/Everest.app/Contents/
	@cp app/AppIcon.icns app/dist/Everest.app/Contents/Resources/
	@cp app/header.png app/dist/Everest.app/Contents/Resources/

.PHONY: all clean install uninstall app test package
