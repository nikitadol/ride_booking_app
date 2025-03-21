import java.util.Base64

plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "dev.dauhashei.ride_booking_app"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "dev.dauhashei.ride_booking_app"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName

        val dartEnvironmentVariables = mutableMapOf<String, String>()

        if (project.hasProperty("dart-defines")) {
            val dartDefines = project.property("dart-defines") as String
            dartDefines.split(",").forEach { entry ->
                val decoded = String(Base64.getDecoder().decode(entry), Charsets.UTF_8)
                val pair = decoded.split("=")
                if (pair.size == 2) {
                    dartEnvironmentVariables[pair[0]] = pair[1]
                }
            }
        }

        manifestPlaceholders.putAll(dartEnvironmentVariables)
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}
