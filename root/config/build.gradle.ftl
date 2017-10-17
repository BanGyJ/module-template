// Top-level build file where you can add configuration options common to all sub-projects/modules.
apply from: "./config/config.gradle"

buildscript {

	ext.LOCAL_PATH_MAVEN = "file:///" + rootDir.absolutePath + "\\cache-maven"  //可以替换成自建Nexus地址

    repositories {
		maven { url 'http://maven.aliyun.com/nexus/content/groups/public/' }
        maven { url LOCAL_PATH_MAVEN }
        jcenter()
		mavenCentral()
        mavenLocal()
    }
    dependencies {
        classpath 'com.android.tools.build:gradle:${gradlePluginVersion}'
		
		<#if isKotlin!false>
		classpath "org.jetbrains.kotlin:kotlin-gradle-plugin:$KOTLIN_VERSION"
		</#if>
		
        // NOTE: Do not place your application dependencies here; they belong
        // in the individual module build.gradle files
    }
}

allprojects {
    repositories {
		maven { url 'http://maven.aliyun.com/nexus/content/groups/public/' }
        maven { url LOCAL_PATH_MAVEN }
        jcenter()
		mavenCentral()
        mavenLocal()
    }
}

task clean(type: Delete) {
    delete rootProject.buildDir
}
