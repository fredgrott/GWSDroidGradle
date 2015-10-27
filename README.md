GWSDroidGradle
==============

My set of gradle build scripts for Android Native java Application Development. These build scripts
specifically do not use product flavors. thus, if you copy them keep that in mind as you might have
to modify them if you use product flavors.

Note: This repo is dynamic in that it changes over time as the development environment changes. And
      it will not hurt if some android developers were to read up on gradle.


Implementation
==============

Root Build Script Implementation
--------------------------------

classpath dependency in build script is first set to the version of the android tools plugin which is
kept in-line with the stable version of the plugin rather than living on the edge with the beta-version
as the stable version api i snot changing and thus results in a stable build system that is very dependable.

So now let me describe the gradle plugin dependencies that are set up in classpath and why I sue these
gradle plugins.

godot, is a plugin that that collects build timing stats about the build so that you can fine tune performances
 wise a build. We can produce a report with the command of:



`./gradlew generateGodotReport``



and the logfile is by default kept at '~/.gradle' under a godot subfolder.

Next up is the hugo gradle plugin for application modules which trigges annotation '@DeubgLog' to provide debug logging while
stripping it out of production builds. It does the method calls, their arguments, their retrun values,
and the time it took to execute.

Next up is the spoon gradle for application modules which enables one to use the spoon libraries in
application modules to collect test results for every emulator and device that runs the tests for every
test variant. Since we are talking about emulators and devices that means the instrumented tests as
opposed to the functional testing which is just plain junit on a vanilla jvm and mocking.

Next up is the apt plugin. When certain libs are used such as dagger I have to use the apt plugin to route
certain things correctly involving the provided item in gradle and this does that.

Next up is the genymotion gradle plugin which if you are using the paid version of genymotion emulators
adds advance functionality that can be changed via the gradle build scripts.

Next up is the gradle-advance-build-version plugin that allows me to version lib modules ap modules
correctly.

The android maven gradle plugin allows me to generate a maven POM for library modules so that I can either
add the jforg bin tray gradle plugin to do uploads to jcenter or do library module deploys to jitpack.

The gradle viewinspector plugin allows me to debug application module builds using both scalpel and probe
without having to go into both debug and release src in the application itself and hard wire those two debug tools
and so everything sets up in a nice floating tool menu that only appears in the debug version of application.


The allprojects block is used to reduce boiler plate in my module build scripts. The first part makes sure
that no lib author has set a '+' dependency wild-card as those are bad for having a stable build system
that you can rely upon.

The second part of the allprojects block is to fine tune some dependency resolution as we have Google
not fully keeping libs in synch ith support libs when they update espresso testing libs and we have certain
3rd-party libs for testing with the same problem. My solution is to force resolution to highest version I
am using as it usually has no bad effects and is better than rolling back as usually Google when updating support libs
rarely, if ever produces a version of those libraries with any errors other than extremely minor ones that do not affect
the other testing libs that synch with those support libraries.

The repositories part of the allprojects block is set to use jcenter and the maven
jitpack url as that is where I get most of my 3rd-party libs from. As I do not use the OSS snapshots to
avoid killing puppies and kittens.

Next up in the allprojects block is my javadoc settings that have to be tweeked. The first block sets
up the functional testing jvm settings so that focus will not be stolen by the test runs.
the second block sets up any javadoc test to ignore R class javadoc errors that seem to be generated
by the java8 machinery.

The final piece of the root build script is the ext block which allows me to set up the global variables
for the module build scripts to use when I set the module dependencies and that allows me to control
which library versions get used in easy way as I just update the ext block when I want to change
library versions.

That concludes the root build script implementation.

App Module Build Script Implementation
--------------------------------------

First the gradle plugins of godot, spoon, advance build version, and view-inspector get applied to the
app module build script.

IN advanceVersioning block is set up to only rename the output on the release task and the two local vars
are set so that he app version name and code values used in the android block are set by this plugin block.

IN the android block of course we have all those ext block variable replacements from the root build script
ext block. Of special note for the app module build script the build types are set with
suffixes and functional testing options are set to log tests and the app signing upon release is set to
use a specially prepared demokey put in the app module so that jitpack can correctly build the release
to allow 3rd party developers to be able to load the library module artifact as jitpack requires an app
build to get to building the library module.

Proguard is set to optimize execute on the release build with a specialized extra optimize proguard
settings file that is fine tuned with android environment specifics.

Than we have a gradle spoon plugin block to set spoon up to run debug and we set it up so that we can
specify a classname and method on the command line if we want to run a specific test.

Next up, we have our dependencies block.

The last block we uncomment when we have androidTests to execute as it enables a task that completes
the stuff done in the SystemAnimations class to turn off systems animations during instrumented testing
and to turn them back on after testing is competed.

That concludes the app module build script implementation.

Library Module Build Script Implementation
------------------------------------------

So starting from the top we have the godot and the android maven gradle plugin
applied to library module build script.

Than we have a maven header block that sets up the android maven gradle variables we will than
use in the in the install block at the very end. There is also include some variable definitions that
the plugin itself uses to generate the maven POM.

Same stuff in the android block and dependencies block as with the app module build script but tuned
as we do not use every setting for our library module build script.

Than we have the maven install task and its related tasks to generate a javadoc jar, sources jar, etc.


Implementation Summary
----------------------

We set the build up to use instrumented and function testing on both the app module and library module
and set the library module to be deployable to jitpack. What is not shown yet is that we use monkeyrunner
with a jython set-up to act as are UIAutomator as UIAutomator cannot be run until 18 and higher apis.

At sometime later this block will contain a reference to the other gradle set-up I use which sets the
app module to use retro-lambda and lombok as I do not use those for the libraries that I create as its
not widely used yet enough for me to code my released libraries that way.



What is Included
================

The Gradle build files

The proguard module files

The travis ci build template file

The readme template

the license template

Edit Text workarounds:

     res/values/dimens.xml
     res/values-21/dimens.xml
     res/values-22/dimens.xml






Usage
=====

I use jitpack to upload my libraries so you put this in your root buildscript:

```groovy
allprojects {
        repositories {
            jcenter()
            maven { url "https://jitpack.io" }
        }
   }
```
Than in the module buildscript:


```groovy
compile 'com.github.shareme:GWSDroidGradle:{latest-release-number}@aar'
```

that is if there is a release 1.0.0.0, which there isn't(its there for template reasons, for all my projects).





Obviously copy the root, library, and app build scripts and make the changes you need.



Target Android API Range
========================

Api 16 to api 23.

Credits
========

Fred Grott(aka shareme  GrottWorkShop)

Former JavaME and JavaEE developer that made the transition to Android Native java Application Development.
Multi-computer-language polyglot that can jump into anything and I do not play follow-the-leader but
often follow my own unique way.(No recruiters, please for any reason)

[Github profile](https://github.com/shareme)
[Bitbucket profile](https://bitbucket.org/fredgrott)
[G+ profile](https://plus.google.com/u/0/+FredGrott/about)
[Twitter profile](https://twitter.com/fredgrott)
[Facebook profile](http://www.facebook.com/fredgrott)
[DeviantArt profile](http://shareme.deviantart.com)
[BeHance profile](https://www.behance.net/gwsfredgrott)
[Dribbble profile](https://dribbble.com/FredGrott)
[AngelList profile](https://angel.co/fred-grott)
[BuiltINChicago profile](http://www.builtinchicago.org/member/fred-grott)
[HackerNews profile](https://news.ycombinator.com/user?id=fredgrott)
[Geeklist profile](https://geekli.st/fredgrott)
[Medium profile](https://medium.com/@fredgrott)
[StackOverflow profile](http://stackoverflow.com/users/237740/fred-grott)
[Blogger blog](http://grottworkshop.blogspot.com)
[Reddit profile](http://www.reddit.com./user/fredgrott/)
[Quora profile](http://www.quora.com/Fred-Grott)
[YouTube channel](https://www.youtube.com/c/FredGrott?gvnc=1)
[AboutMe profile](https://about.me/fredgrott)
[LinkedIN profile](http://www.linkedin.com/in/shareme/en)
[Xing profile](https://www.xing.com/profile/Fred_Grott?sc_o=mxb_p)
[SlideShare profile](http://www.slideshare.net/shareme)
[SpeakerDeck profile](https://speakerdeck.com/fredgrott)
[Android Hacker Tumbler](https://www.tumblr.com/blog/androidhacker)
[Ustream](https://www.ustream.tv/manage-show/12940149)
[AboutMe](https://about.me/fredgrott)



License
=======

[Apache 2.0 License](http://www.apache.org/licenses/LICENSE-2.0.txt)

Resources
=========

[Google Android Developer Site](http://developer.android.com)

[Google Android Developer Tool Site](http://tools.android.com)

[Google Android Developer Blog](http://android-developers.blogspot.com/)


[StackOverflow Android Questions](http://stackoverflow.com/questions/tagged/android)

[Gradle](http://gradle.org)

[Reddit-androidev](http://reddit.com/r/androdev/)

[AndroidChat at Slack](https://androidchat.slack.com/messages/development/)

[Amazon Android Dev Site](https://developer.amazon.com/public)

[JavaRanch Android Forum](http://www.coderanch.com/forums/f-93/Android)

[Android Development Tools G+ community](https://plus.google.com/communities/114791428968349268860)

[Android Development G+ Community](https://plus.google.com/communities/105153134372062985968)

[Android Developers G+ Community](https://plus.google.com/+AndroidDevelopers/posts)

[Android Design G+ Community](https://plus.google.com/communities/113499773637471211070)

[UX Design for Developers](https://plus.google.com/communities/103651070366324568638)

[Android MVP G+ Community](https://plus.google.com/communities/114285790907815804707)
