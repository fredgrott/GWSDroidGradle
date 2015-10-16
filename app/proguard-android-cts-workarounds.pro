# These work-around are due to OEMs trying to save ROM space by
# putting a common support lib package in the classpath rather than
# the default best mobile embedded practices of including the suport lib with
# every defautl app on the device.
#
# This causesclass collide conflicts when we attempt to include new support lib
# versions in our app as the common supoprt lib old version on ROM gets loaded first
# as part of the framework bootup.
#
# This was working as of version 22.x.x mid 2015
#-keepattributes Exceptions,InnerClasses,Signature,Deprecated,SourceFile,LineNumberTable,*Annotation*,EnclosingMethod
#-dontobfuscate
#-dontoptimize
#
#-keep class !android.support.v7.internal.view.menu.**, ** { *; }
#
# noted problems
# setOptionalIconsVisible not obfuscated
#
# Thus for 23.0.0 its:

-keep class !android.support.v7.internal.view.menu.*MenuBuilder*,android.support.v7.** { *; }
-keep class android.support.design.widget.** { *; }
-keep interface android.support.design.widget.** { *; }
