/*统一公共依赖管理*/

dependencies {
    compile fileTree(dir: 'libs', include: ['*.jar'])
    androidTestCompile('com.android.support.test.espresso:espresso-core:2.2.2', {
        exclude group: 'com.android.support', module: 'support-annotations'
    })
    compile "org.jetbrains.kotlin:kotlin-stdlib-jre7:$KOTLIN_VERSION"

    compile rootProject.ext.dependencies["support-v7"]
    compile rootProject.ext.dependencies["design"]
    compile rootProject.ext.dependencies["recyclerview"]
    compile rootProject.ext.dependencies["constraint"]


    testCompile 'junit:junit:4.12'

    //json解析
    compile 'com.alibaba:fastjson:1.1.63.android'


    //网络
    compile 'com.lzy.net:okgo:3.0.4'
    //以下三个选择添加，okrx和okrx2不能同时使用
    compile 'com.lzy.net:okrx2:2.0.2'


    //Debug时依赖：网络调试，数据库调试
    debugCompile 'com.facebook.stetho:stetho:1.5.0'
    debugCompile 'com.facebook.stetho:stetho-okhttp3:1.5.0'

    //路由
    compile rootProject.ext.dependencies["arouterApi"]

    //内存泄漏检测//调试依赖
    //debugCompile 'com.squareup.leakcanary:leakcanary-android:1.5'
}