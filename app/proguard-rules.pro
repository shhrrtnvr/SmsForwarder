#========================================= Basic Obfuscation Configuration =========================================##
# Specify the compression level of the code
-optimizationpasses 5
# Package names do not mix uppercase and lowercase
-dontusemixedcaseclassnames
# Do not ignore non-public library classes
#-dontskipnonpubliclibraryclasses
# Specify not to ignore members of non-public library classes
#-dontskipnonpubliclibraryclassmembers
# Optimization - Do not optimize input class files
-dontoptimize
# Pre-validation
#-dontpreverify
# Whether to log during obfuscation
-verbose
# Algorithm used during obfuscation
-optimizations !code/simplification/arithmetic,!field/*,!class/merging/*
# Protect annotations
-keepattributes *Annotation*
# Ignore warnings
-ignorewarnings

## Record generated log data, output to the root directory of this project during gradle build ##
# Internal structure of all classes in the apk package
#-dump class_files.txt
# Unobfuscated classes and members
-printseeds seeds.txt
# List code removed from apk
-printusage unused.txt
# Mapping before and after obfuscation
-printmapping mapping.txt
# And keep the source file name as "Proguard" string instead of the original class name and keep the line number
-keepattributes SourceFile,LineNumberTable
######## Record generated log data, output to the root directory of this project during gradle build - end #####

# Things to keep
# Keep which classes from being obfuscated
-keep public class * extends android.app.Fragment
-keep public class * extends android.app.Activity
-keep public class * extends android.app.Application
-keep public class * extends android.app.Service
-keep public class * extends android.content.BroadcastReceiver
-keep public class * extends android.content.ContentProvider
-keep public class * extends android.app.backup.BackupAgentHelper
-keep public class * extends android.preference.Preference
-keep public class * extends android.support.v4.**
#-keep public class com.android.vending.licensing.ILicensingService

# If you reference the v4 package, you can add the following line
#-keep public class * extends android.support.v4.app.Fragment

########## JS interface classes are not obfuscated, otherwise they cannot be executed
-dontwarn com.android.JsInterface.**
-keep class com.android.JsInterface.** {*; }

# Problem with JPUSH and Baidu LBS Android SDK used together with proguard obfuscation # After the http class is obfuscated, the apk positioning fails. Just keep the apache http class from being obfuscated
-dontwarn org.apache.**
-keep class org.apache.**{ *; }

-keep public class * extends android.view.View {
  public <init>(android.content.Context);
  public <init>(android.content.Context, android.util.AttributeSet);
  public <init>(android.content.Context, android.util.AttributeSet, int);
  public void set*(...);
 }

# Keep native methods from being obfuscated
-keepclasseswithmembernames class * {
  native <methods>;
}

# Keep custom control classes from being obfuscated
-keepclasseswithmembers class * {
  public <init>(android.content.Context, android.util.AttributeSet);
}

# Keep custom control classes from being obfuscated
-keepclassmembers class * extends android.app.Activity {
  public void *(android.view.View);
}

# Keep Parcelable from being obfuscated
-keep class * implements android.os.Parcelable {
  public static final android.os.Parcelable$Creator *;
}

# Keep Serializable from being obfuscated
-keepnames class * implements java.io.Serializable

# Keep Serializable from being obfuscated and enum classes from being obfuscated
-keepclassmembers class * implements java.io.Serializable {
    static final long serialVersionUID;
    private static final java.io.ObjectStreamField[] serialPersistentFields;
    !static !transient <fields>;
    !private <fields>;
    !private <methods>;
    private void writeObject(java.io.ObjectOutputStream);
    private void readObject(java.io.ObjectInputStream);
    java.lang.Object writeReplace();
    java.lang.Object readResolve();
}

# Keep enum classes from being obfuscated. If obfuscation reports an error, it is recommended to directly use the above -keepclassmembers class * implements java.io.Serializable
-keepclassmembers enum * {
      public static **[] values();
      public static ** valueOf(java.lang.String);
}

-keepclassmembers class * {
      public void *ButtonClicked(android.view.View);
}

# Do not obfuscate resource classes
-keep class **.R$* {*;}

#=================================== Obfuscate and protect some project code and referenced third-party jar library =============================#######
# If v4 or v7 package is referenced
-dontwarn android.support.**


# AndroidX prevent obfuscation
-dontwarn com.google.android.material.**
-dontnote com.google.android.material.**
-dontwarn androidx.**
-keep class com.google.android.material.** {*;}
-keep class androidx.** {*;}
-keep public class * extends androidx.**
-keep interface androidx.** {*;}
-keepclassmembers class * {
    @androidx.annotation.Keep *;
}

# zxing
-dontwarn com.google.zxing.**
-keep class com.google.zxing.**{*;}

# SignalR push
-keep class microsoft.aspnet.signalr.** { *; }

# JPush obfuscation
#-dontoptimize
#-dontpreverify
#-dontwarn cn.jpush.**
#-keep class cn.jpush.** { *; }
#-dontwarn cn.jiguang.**
#-keep class cn.jiguang.** { *; }

# Database framework OrmLite
-keepattributes *DatabaseField*
-keepattributes *DatabaseTable*
-keepattributes *SerializedName*
-keep class com.j256.**
-keepclassmembers class com.j256.** { *; }
-keep enum com.j256.**
-keepclassmembers enum com.j256.** { *; }
-keep interface com.j256.**
-keepclassmembers interface com.j256.** { *; }

#XHttp2
-keep class com.xuexiang.xhttp2.model.** { *; }
-keep class com.xuexiang.xhttp2.cache.model.** { *; }
-keep class com.xuexiang.xhttp2.cache.stategy.**{*;}
-keep class com.xuexiang.xhttp2.annotation.** { *; }

#okhttp
-dontwarn com.squareup.okhttp3.**
-keep class com.squareup.okhttp3.** { *;}
-dontwarn okio.**
-dontwarn javax.annotation.**

#如果用到Gson解析包的，直接添加下面这几行就能成功混淆，不然会报错
-keepattributes Signature
-keep class com.google.gson.stream.** { *; }
-keepattributes EnclosingMethod
-keep class org.xz_sale.entity.**{*;}
-keep class com.google.gson.** {*;}
-keep class com.google.**{*;}
#-keep class sun.misc.Unsafe { *; }
-keep class com.google.gson.stream.** { *; }
-keep class com.google.gson.examples.android.model.** { *; }

# Glide
-keep public class * implements com.bumptech.glide.module.GlideModule
-keep public class * extends com.bumptech.glide.module.AppGlideModule
-keep public enum com.bumptech.glide.load.ImageHeaderParser$** {
  **[] $VALUES;
  public *;
}

# Retrofit
-dontwarn retrofit2.**
-keep class retrofit2.** { *; }
-keepattributes Exceptions

# RxJava RxAndroid
-dontwarn sun.misc.**
-keepclassmembers class rx.internal.util.unsafe.*ArrayQueue*Field* {
    long producerIndex;
    long consumerIndex;
}
#-keepclassmembers class rx.internal.util.unsafe.BaseLinkedQueueProducerNodeRef {
#    rx.internal.util.atomic.LinkedQueueNode producerNode;
#}
#-keepclassmembers class rx.internal.util.unsafe.BaseLinkedQueueConsumerNodeRef {
#    rx.internal.util.atomic.LinkedQueueNode consumerNode;
#}

-dontwarn okio.**
-dontwarn javax.annotation.**

# fastjson
-dontwarn com.alibaba.fastjson.**
-keep class com.alibaba.fastjson.** { *; }
-keepattributes Signature

# xpage
-keep class com.xuexiang.xpage.annotation.** { *; }
-keep class com.xuexiang.xpage.config.** { *; }

# xaop
-keep @com.xuexiang.xaop.annotation.* class * {*;}
-keep @org.aspectj.lang.annotation.* class * {*;}
-keep class * {
    @com.xuexiang.xaop.annotation.* <fields>;
    @org.aspectj.lang.annotation.* <fields>;
}
-keepclassmembers class * {
    @com.xuexiang.xaop.annotation.* <methods>;
    @org.aspectj.lang.annotation.* <methods>;
}

# xrouter
-keep public class com.xuexiang.xrouter.routes.**{*;}
-keep class * implements com.xuexiang.xrouter.facade.template.ISyringe{*;}
# If the byType method is used to obtain the Service, the following rules must be added to protect the interface
-keep interface * implements com.xuexiang.xrouter.facade.template.IProvider
# If single class injection is used, that is, the interface implementation IProvider is not defined, the following rules must be added to protect the implementation
-keep class * implements com.xuexiang.xrouter.facade.template.IProvider

# xupdate
-keep class com.xuexiang.xupdate.entity.** { *; }

# xvideo
-keep class com.xuexiang.xvideo.jniinterface.** { *; }

# xipc
-keep @com.xuexiang.xipc.annotation.* class * {*;}
-keep class * {
    @com.xuexiang.xipc.annotation.* <fields>;
}
-keepclassmembers class * {
    @com.xuexiang.xipc.annotation.* <methods>;
}

# umeng statistics
-keep class com.umeng.** {*;}
-keepclassmembers class * {
   public <init> (org.json.JSONObject);
}
-keepclassmembers enum * {
    public static **[] values();
    public static ** valueOf(java.lang.String);
}

-keep class com.xuexiang.xui.widget.edittext.materialedittext.** { *; }

# Android Keep Alive, Cactus integrated dual-process foreground service, JobScheduler, onePix, WorkManager, silent music
-keep class com.gyf.cactus.entity.* {*;}

# Exclude entity classes
-keep class com.idormy.sms.forwarder.core.http.entity.** {*;}
-keep class com.idormy.sms.forwarder.database.entity.** {*;}
-keep class com.idormy.sms.forwarder.entity.** {*;}
-keep class com.idormy.sms.forwarder.server.model.** {*;}

# javax.mail
-dontwarn com.sun.**
-dontwarn javax.mail.**
-dontwarn javax.activation.**
-keep class com.sun.** { *;}
-keep class javax.mail.** { *;}
-keep class javax.activation.** { *;}
-keep class com.smailnet.emailkit.** { *;}
-keep class com.idormy.sms.forwarder.utils.mail.** {*;}
-keep class com.gitee.xuankaicat.kmnkt.** {*;}
-keep class org.eclipse.paho.client.** {*;}

-keep public class com.xuexiang.xrouter.routes.**{*;}
-keep class * implements com.xuexiang.xrouter.facade.template.ISyringe{*;}
# If the byType method is used to obtain the Service, the following rules must be added to protect the interface
-keep interface * implements com.xuexiang.xrouter.facade.template.IProvider
# If single class injection is used, that is, the interface implementation IProvider is not defined, the following rules must be added to protect the implementation
-keep class * implements com.xuexiang.xrouter.facade.template.IProvider

-dontwarn com.alipay.sdk.**
-dontwarn com.android.org.conscrypt.**
-dontwarn java.awt.image.**
-dontwarn javax.lang.model.**
-dontwarn javax.naming.**
-dontwarn javax.naming.directory.**

# This is generated automatically by the Android Gradle plugin.
-dontwarn org.joda.convert.**
-dontwarn org.slf4j.impl.**

# MultiLanguages
-keep class com.hjq.language.** {*;}

# crontab parsing
-keep class gatewayapps.crondroid.** { *; }
-keep class net.redhogs.cronparser.** { *; }
