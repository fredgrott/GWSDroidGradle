# Add project specific ProGuard rules here.
# By default, the flags in this file are appended to flags specified
# in D:\myandroid\sdk/tools/proguard/proguard-android.txt
# You can edit the include path and order by changing the proguardFiles
# directive in build.gradle.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# Add any project specific keep options here:

# If your project uses WebView with JS, uncomment the following
# and specify the fully qualified class name to the JavaScript interface
# class:
#-keepclassmembers class fqcn.of.javascript.interface.for.webview {
#   public *;
#}
# copied from ioschedule app as that has some proguard android
# best practices in it
-dontusemixedcaseclassnames
-dontskipnonpubliclibraryclasses
-dontskipnonpubliclibraryclassmembers
-repackageclasses 'android.support.v7'
-verbose
# optimization is turned on
-dontpreverify
# If you want to enable optimization, you should include the
# following:
-optimizations !code/simplification/arithmetic,!code/simplification/cast,!field/*,!class/merging/*
-optimizationpasses 5
-allowaccessmodification
-keepattributes Exceptions,InnerClasses,Signature,Deprecated,SourceFile,LineNumberTable,*Annotation*,EnclosingMethod
-keep public class * extends android.app.Activity
-keep public class * extends android.app.Application
-keep public class * extends android.app.Service
-keep public class * extends android.content.BroadcastReceiver
-keep public class * extends android.content.ContentProvider
-keep public class * extends android.app.backup.BackupAgent
-keep public class * extends android.preference.Preference
-keep public class * extends android.support.v4.app.Fragment
-keep public class * extends android.app.Fragment
# For native methods, see http://proguard.sourceforge.net/manual/examples.html#native
-keepclasseswithmembernames class * {
    native <methods>;
}
-keep public class * extends android.view.View {
    public <init>(android.content.Context);
    public <init>(android.content.Context, android.util.AttributeSet);
    public <init>(android.content.Context, android.util.AttributeSet, int);
    public void set*(...);
    public void get*(...);
}
-keepclasseswithmembers class * {
    public <init>(android.content.Context, android.util.AttributeSet);
}
-keepclasseswithmembers class * {
    public <init>(android.content.Context, android.util.AttributeSet, int);
}
-keepclassmembers class * extends android.app.Activity {
   public void *(android.view.View);
}
# For enumeration classes, see http://proguard.sourceforge.net/manual/examples.html#enumerations
-keepclassmembers enum * {
    public static **[] values();
    public static ** valueOf(java.lang.String);
}
-keep class * implements android.os.Parcelable {
  public static final android.os.Parcelable$Creator *;
}
-keepclassmembers class **.R$* {
    public static <fields>;
}
# The support library contains references to newer platform versions.
# Don't warn about those in case this app is linking against an older
# platform version.  We know about them, and they are safe.
-dontwarn android.support.**
# Needed by google-http-client to keep generic types and @Key annotations accessed via reflection
-keepclassmembers class * {
  @com.google.api.client.util.Key <fields>;
}
# Needed just to be safe in terms of keeping Google API service model classes
-keep class com.google.api.services.*.model.*
-keep class com.google.api.client.**
-keepattributes Signature,RuntimeVisibleAnnotations,AnnotationDefault
# See https://groups.google.com/forum/#!topic/guava-discuss/YCZzeCiIVoI
-dontwarn com.google.common.collect.MinMaxPriorityQueue
# Assume dependency libraries Just Work(TM)
-dontwarn com.google.android.youtube.**
-dontwarn com.google.android.analytics.**
-dontwarn com.google.common.**
# Don't discard Guava classes that raise warnings
-keep class com.google.common.collect.MapMakerInternalMap$ReferenceEntry
-keep class com.google.common.cache.LocalCache$ReferenceEntry
# Make sure that Google Analytics doesn't get removed
-keep class com.google.analytics.tracking.android.CampaignTrackingReceiver


# Other settings
-keep class com.android.**
-keep class com.google.android.**
-keep class com.google.android.gms.**
-keep class com.google.android.gms.location.**
-keep class com.google.api.client.**
-keep class com.google.maps.android.**
-keep class libcore.**


-dontwarn org.junit.**
-dontwarn org.mockito.**
-dontwarn org.robolectric.**
-dontwarn com.bumptech.glide.GlideTest
-dontwarn com.google.common.cache.**
-dontwarn com.google.common.primitives.**
-dontwarn com.google.api.client.googleapis.**
-dontwarn com.sothree.slidinguppanel.**
-dontwarn sun.misc.Unsafe
-dontwarn com.google.common.util.concurrent.RateLimiter
-dontwarn javax.annotation.**

-keep class android.support.v8.renderscript.** { *; }
-keep public class * extends android.app,backup.BackupAgent
-keep class android.support.v4.app.** { *; }
-keep interface android.support.v4.app.** { *; }

-keep class !android.support.v7.internal.view.menu.*MenuBuilder*,android.support.v7.** { *; }
-keep interface android.support.v7.app.** { *; }

-keep class android.support.v13.app.** { *; }
-keep interface android.support.v13.app.** { *; }
-keep class android.support.design.widget.** { *; }
-keep interface android.support.design.widget.** { *; }