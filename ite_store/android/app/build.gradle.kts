plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.ite_store"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        // This is your base ID. We will add suffixes to this below!
        applicationId = "com.example.ite_store"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    // --- NEW FLAVORS SECTION ---
    flavorDimensions += "environment"

    productFlavors {
        create("dev") {
            dimension = "environment"
            applicationIdSuffix = ".dev"
            manifestPlaceholders["appName"] = "ITE Store Dev"
        }
        create("uat") {
            dimension = "environment"
            applicationIdSuffix = ".uat"
            manifestPlaceholders["appName"] = "ITE Store Test"
        }
        create("demo") {
            dimension = "environment"
            applicationIdSuffix = ".demo"
            manifestPlaceholders["appName"] = "ITE Store Demo"
        }
        create("prod") {
            dimension = "environment"
            manifestPlaceholders["appName"] = "ITE Store"
        }
    }
    // --- END OF NEW SECTION ---

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}