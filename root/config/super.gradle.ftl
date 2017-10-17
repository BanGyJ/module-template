if (!isAppBuild()&&!isTestBuild()) {
	apply plugin: 'com.android.library'
    apply from: "../config/maven.gradle"
}else{
	apply plugin: 'com.android.application'
}
<#if isKotlin!false>
apply plugin: 'kotlin-android'
apply plugin: 'kotlin-kapt'
</#if>
/**
 * 基本android编译统一全局配置
 * */
android {
    compileSdkVersion COMPILE_SDK_VERSION as int
    buildToolsVersion BUILD_TOOLS_VERSION

    defaultConfig {
		if (isAppBuild()) {
			applicationId "${packageName}"
		}else if(isTestBuild()){
			applicationId "${packageName}.test"
		}
        minSdkVersion MIN_SDK_VERSION as int
        targetSdkVersion TARGET_SDK_VERSION as int
        versionCode VERSION_CODE as int
        versionName VERSION_NAME

    }

    kapt {
        arguments {
            arg("moduleName", project.getName())
        }
    }

    buildTypes {
        debug{
            versionNameSuffix "-debug"
        }
        release {
            // 为版本名添加后缀
            //versionNameSuffix "-relase"
        }
    }
    sourceSets {
        //main.java.srcDirs = ['src/main/java','src/main/kotlin', 'src/main/debug']
        if(isReleaseBuild()){
            main.java.srcDirs = ['src/main/java','src/main/kotlin','src/main/release']
        }else{
            main.java.srcDirs = ['src/main/java','src/main/kotlin', 'src/main/debug']
        }
    }

}
dependencies {
    compile fileTree(dir: 'libs', include: ['*.jar'])
    androidTestCompile('com.android.support.test.espresso:espresso-core:2.2.2', {
        exclude group: 'com.android.support', module: 'support-annotations'
    })
	kapt rootProject.ext.dependencies["arouter"]
	testCompile 'junit:junit:4.12'
    if (isModuleBuild()) {
        //	compile 'com.zhonghonginter:system-code:0.01'
        //  compile project(':system-code')
    }
}
/*-------------------------*/
def isReleaseBuild() {
    return !(hasProperty('POM_NEME_SUFFIX') && POM_NEME_SUFFIX.contains("debug") == true) && (VERSION_NAME.contains("SNAPSHOT") == false)
}
/*MODULE_CLASS = APP*/
def isAppBuild() {
return (hasProperty('MODULE_CLASS') && (MODULE_CLASS.contains("APP") == true))
}
/*MODULE_CLASS = CODE*/
def isCodeBuild() {
return (hasProperty('MODULE_CLASS') && (MODULE_CLASS.contains("CODE") == true))
}
def isModuleBuild() {
return (hasProperty('MODULE_CLASS') && (MODULE_CLASS.contains("MODULE") == true))
}
def isTestBuild() {
return (hasProperty('MODULE_CLASS') && (MODULE_CLASS.contains("TEST") == true))
}

if (isCodeBuild()) {
    apply from: "../config/dependencies.gradle"
}

