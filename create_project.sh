#!/bin/bash

# Create project structure
mkdir -p WhiteNoise.xcodeproj
mkdir -p WhiteNoise/Audio
mkdir -p WhiteNoise/Views/Components

# Create project.pbxproj (simplified)
cat > WhiteNoise.xcodeproj/project.pbxproj << 'PBXPROJ'
// !$*UTF8*$!
{
	archiveVersion = 1;
	classes = {
	};
	objectVersion = 56;
	objects = {
		A0000001 /* WhiteNoiseApp.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = WhiteNoiseApp.swift; sourceTree = "<group>"; };
		A0000002 /* ContentView.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = ContentView.swift; sourceTree = "<group>"; };
		A0000003 /* WhiteNoiseEngine.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = WhiteNoiseEngine.swift; sourceTree = "<group>"; };
		A0000004 /* AudioSessionManager.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = AudioSessionManager.swift; sourceTree = "<group>"; };
		A0000005 /* PlayPauseButton.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = PlayPauseButton.swift; sourceTree = "<group>"; };
		A0000006 /* Assets.xcassets */ = {isa = PBXFileReference; lastKnownFileType = folder.assetcatalog; path = Assets.xcassets; sourceTree = "<group>"; };
		A0000007 /* Info.plist */ = {isa = PBXFileReference; lastKnownFileType = text.plist.xml; path = Info.plist; sourceTree = "<group>"; };
		A0000008 /* WhiteNoise.app */ = {isa = PBXFileReference; explicitFileType = wrapper.application; includeInIndex = 0; path = WhiteNoise.app; sourceTree = BUILT_PRODUCTS_DIR; };
		A0000009 /* WhiteNoise */ = {
			isa = PBXGroup;
			children = (
				A0000001 /* WhiteNoiseApp.swift */,
				A000000A /* Views */,
				A000000B /* Audio */,
				A0000006 /* Assets.xcassets */,
				A0000007 /* Info.plist */,
			);
			path = WhiteNoise;
			sourceTree = "<group>";
		};
		A000000A /* Views */ = {
			isa = PBXGroup;
			children = (
				A0000002 /* ContentView.swift */,
				A000000C /* Components */,
			);
			path = Views;
			sourceTree = "<group>";
		};
		A000000B /* Audio */ = {
			isa = PBXGroup;
			children = (
				A0000003 /* WhiteNoiseEngine.swift */,
				A0000004 /* AudioSessionManager.swift */,
			);
			path = Audio;
			sourceTree = "<group>";
		};
		A000000C /* Components */ = {
			isa = PBXGroup;
			children = (
				A0000005 /* PlayPauseButton.swift */,
			);
			path = Components;
			sourceTree = "<group>";
		};
		A000000D = {
			isa = PBXGroup;
			children = (
				A0000009 /* WhiteNoise */,
				A000000E /* Products */,
			);
			sourceTree = "<group>";
		};
		A000000E /* Products */ = {
			isa = PBXGroup;
			children = (
				A0000008 /* WhiteNoise.app */,
			);
			name = Products;
			sourceTree = "<group>";
		};
		A000000F /* Frameworks */ = {
			isa = PBXFrameworksBuildPhase;
			buildActionMask = 2147483647;
			files = (
			);
			runOnlyForDeploymentPostprocessing = 0;
		};
		A0000010 /* Resources */ = {
			isa = PBXResourcesBuildPhase;
			buildActionMask = 2147483647;
			files = (
				A0000016 /* Assets.xcassets in Resources */,
			);
			runOnlyForDeploymentPostprocessing = 0;
		};
		A0000011 /* Sources */ = {
			isa = PBXSourcesBuildPhase;
			buildActionMask = 2147483647;
			files = (
				A0000012 /* WhiteNoiseApp.swift in Sources */,
				A0000013 /* ContentView.swift in Sources */,
				A0000014 /* WhiteNoiseEngine.swift in Sources */,
				A0000015 /* AudioSessionManager.swift in Sources */,
				A0000017 /* PlayPauseButton.swift in Sources */,
			);
			runOnlyForDeploymentPostprocessing = 0;
		};
		A0000012 /* WhiteNoiseApp.swift in Sources */ = {isa = PBXBuildFile; fileRef = A0000001 /* WhiteNoiseApp.swift */; };
		A0000013 /* ContentView.swift in Sources */ = {isa = PBXBuildFile; fileRef = A0000002 /* ContentView.swift */; };
		A0000014 /* WhiteNoiseEngine.swift in Sources */ = {isa = PBXBuildFile; fileRef = A0000003 /* WhiteNoiseEngine.swift */; };
		A0000015 /* AudioSessionManager.swift in Sources */ = {isa = PBXBuildFile; fileRef = A0000004 /* AudioSessionManager.swift */; };
		A0000016 /* Assets.xcassets in Resources */ = {isa = PBXBuildFile; fileRef = A0000006 /* Assets.xcassets */; };
		A0000017 /* PlayPauseButton.swift in Sources */ = {isa = PBXBuildFile; fileRef = A0000005 /* PlayPauseButton.swift */; };
		A0000018 /* WhiteNoise */ = {
			isa = PBXNativeTarget;
			buildConfigurationList = A0000019 /* Build configuration list for PBXNativeTarget "WhiteNoise" */;
			buildPhases = (
				A0000011 /* Sources */,
				A000000F /* Frameworks */,
				A0000010 /* Resources */,
			);
			buildRules = (
			);
			dependencies = (
			);
			name = WhiteNoise;
			productName = WhiteNoise;
			productReference = A0000008 /* WhiteNoise.app */;
			productType = "com.apple.product-type.application";
		};
		A0000019 /* Build configuration list for PBXNativeTarget "WhiteNoise" */ = {
			isa = XCConfigurationList;
			buildConfigurations = (
				A000001A /* Debug */,
				A000001B /* Release */,
			);
			defaultConfigurationIsVisible = 0;
			defaultConfigurationName = Release;
		};
		A000001A /* Debug */ = {
			isa = XCBuildConfiguration;
			buildSettings = {
				ASSETCATALOG_COMPILER_APPICON_NAME = AppIcon;
				CODE_SIGN_STYLE = Automatic;
				CURRENT_PROJECT_VERSION = 1;
				DEVELOPMENT_TEAM = DNG38QP97S;
				ENABLE_PREVIEWS = YES;
				INFOPLIST_FILE = WhiteNoise/Info.plist;
				IPHONEOS_DEPLOYMENT_TARGET = 15.0;
				LD_RUNPATH_SEARCH_PATHS = (
					"$(inherited)",
					"@executable_path/Frameworks",
				);
				MARKETING_VERSION = 1.0;
				PRODUCT_BUNDLE_IDENTIFIER = com.tmanyanov.whitenoise;
				PRODUCT_NAME = "$(TARGET_NAME)";
				SDKROOT = iphoneos;
				SWIFT_VERSION = 5.0;
				TARGETED_DEVICE_FAMILY = "1,2";
			};
			name = Debug;
		};
		A000001B /* Release */ = {
			isa = XCBuildConfiguration;
			buildSettings = {
				ASSETCATALOG_COMPILER_APPICON_NAME = AppIcon;
				CODE_SIGN_STYLE = Automatic;
				CURRENT_PROJECT_VERSION = 1;
				DEVELOPMENT_TEAM = DNG38QP97S;
				ENABLE_PREVIEWS = YES;
				INFOPLIST_FILE = WhiteNoise/Info.plist;
				IPHONEOS_DEPLOYMENT_TARGET = 15.0;
				LD_RUNPATH_SEARCH_PATHS = (
					"$(inherited)",
					"@executable_path/Frameworks",
				);
				MARKETING_VERSION = 1.0;
				PRODUCT_BUNDLE_IDENTIFIER = com.tmanyanov.whitenoise;
				PRODUCT_NAME = "$(TARGET_NAME)";
				SDKROOT = iphoneos;
				SWIFT_VERSION = 5.0;
				TARGETED_DEVICE_FAMILY = "1,2";
			};
			name = Release;
		};
		A000001C /* Build configuration list for PBXProject "WhiteNoise" */ = {
			isa = XCConfigurationList;
			buildConfigurations = (
				A000001D /* Debug */,
				A000001E /* Release */,
			);
			defaultConfigurationIsVisible = 0;
			defaultConfigurationName = Release;
		};
		A000001D /* Debug */ = {
			isa = XCBuildConfiguration;
			buildSettings = {
				ALWAYS_SEARCH_USER_PATHS = NO;
				CLANG_ENABLE_MODULES = YES;
				CLANG_ENABLE_OBJC_ARC = YES;
				COPY_PHASE_STRIP = NO;
				DEBUG_INFORMATION_FORMAT = dwarf;
				ENABLE_STRICT_OBJC_MSGSEND = YES;
				ENABLE_TESTABILITY = YES;
				GCC_C_LANGUAGE_STANDARD = gnu17;
				GCC_DYNAMIC_NO_PIC = NO;
				GCC_NO_COMMON_BLOCKS = YES;
				GCC_OPTIMIZATION_LEVEL = 0;
				GCC_PREPROCESSOR_DEFINITIONS = (
					"DEBUG=1",
					"$(inherited)",
				);
				IPHONEOS_DEPLOYMENT_TARGET = 15.0;
				MTL_ENABLE_DEBUG_INFO = INCLUDE_SOURCE;
				MTL_FAST_MATH = YES;
				ONLY_ACTIVE_ARCH = YES;
				SDKROOT = iphoneos;
				SWIFT_ACTIVE_COMPILATION_CONDITIONS = DEBUG;
				SWIFT_OPTIMIZATION_LEVEL = "-Onone";
			};
			name = Debug;
		};
		A000001E /* Release */ = {
			isa = XCBuildConfiguration;
			buildSettings = {
				ALWAYS_SEARCH_USER_PATHS = NO;
				CLANG_ENABLE_MODULES = YES;
				CLANG_ENABLE_OBJC_ARC = YES;
				COPY_PHASE_STRIP = NO;
				DEBUG_INFORMATION_FORMAT = "dwarf-with-dsym";
				ENABLE_NS_ASSERTIONS = NO;
				ENABLE_STRICT_OBJC_MSGSEND = YES;
				GCC_C_LANGUAGE_STANDARD = gnu17;
				GCC_NO_COMMON_BLOCKS = YES;
				IPHONEOS_DEPLOYMENT_TARGET = 15.0;
				MTL_ENABLE_DEBUG_INFO = NO;
				MTL_FAST_MATH = YES;
				SDKROOT = iphoneos;
				SWIFT_COMPILATION_MODE = wholemodule;
				VALIDATE_PRODUCT = YES;
			};
			name = Release;
		};
		A000001F /* Project object */ = {
			isa = PBXProject;
			attributes = {
				BuildIndependentTargetsInParallel = 1;
				LastSwiftUpdateCheck = 1500;
				LastUpgradeCheck = 1500;
			};
			buildConfigurationList = A000001C /* Build configuration list for PBXProject "WhiteNoise" */;
			compatibilityVersion = "Xcode 14.0";
			developmentRegion = en;
			hasScannedForEncodings = 0;
			knownRegions = (
				en,
				Base,
			);
			mainGroup = A000000D;
			productRefGroup = A000000E /* Products */;
			projectDirPath = "";
			projectRoot = "";
			targets = (
				A0000018 /* WhiteNoise */,
			);
		};
	};
	rootObject = A000001F /* Project object */;
}
PBXPROJ

chmod +x create_project.sh
