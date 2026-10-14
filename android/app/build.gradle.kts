
import org.jetbrains.kotlin.gradle.dsl.JvmTarget

plugins {
    id("com.android.application")
    id("kotlin-android")
    id("com.google.gms.google-services")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.sale_pipeline_business"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        isCoreLibraryDesugaringEnabled = true
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    defaultConfig {
        applicationId = "com.moc.salepipeline"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // Existing debug signing configuration.
            // Configure release signing before publishing.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

// Kotlin compiler configuration
kotlin {
    compilerOptions {
        jvmTarget.set(JvmTarget.JVM_11)
    }
}

dependencies {
    // Required by flutter_local_notifications
    coreLibraryDesugaring(
        "com.android.tools:desugar_jdk_libs:2.1.4"
    )

    implementation("androidx.multidex:multidex:2.0.1")
}

flutter {
    source = "../.."
}
