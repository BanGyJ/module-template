/*依赖及编辑的版本管理*/

ext {
    dependencies = ["support-v7"      : "com.android.support:appcompat-v7:$ANDROID_SUPPORT",
                    "design"          : "com.android.support:design:$ANDROID_SUPPORT",
                    "percent"         : "com.android.support:percent:$ANDROID_SUPPORT",
                    "support-v4"      : "com.android.support:support-v4:$ANDROID_SUPPORT",
                    "recyclerview"    : "com.android.support:recyclerview-v7:$ANDROID_SUPPORT",
                    "butterknife"     : "com.jakewharton:butterknife:8.5.1",
                    "butterknife_atp" : 'com.jakewharton:butterknife-compiler:8.5.1',
                    "constraint"      : 'com.android.support.constraint:constraint-layout:1.0.2',
                    "arouter"         : "com.alibaba:arouter-compiler:$ROUTER",
                    "arouterApi"       : "com.alibaba:arouter-api:$ROUTERAPI"

    ]

}

/*
*
*  android = [compileSdkVersion: 26,
               buildToolsVersion: "26.0.1",
               minSdkVersion    : 21,
               targetSdkVersion : 25,
               versionCode      : 0,
               versionName      : "0.0.1",
               support          : "26+",
               router           : "1.1.3",
               routerApi        : "1.2.2",

    ]
*
* */