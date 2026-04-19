# Suppress warnings for missing Google Auth classes referenced by smart_auth plugin
-dontwarn com.google.android.gms.auth.api.credentials.**
-keep class com.google.android.gms.auth.api.credentials.** { *; }

# General Flutter/R8 rules (often helpful to prevent similar issues)
-dontwarn io.flutter.plugin.**
