# Project-wide Gradle settings.

# IDE (e.g. Android Studio) users:
# Gradle settings configured through the IDE *will override*
# any settings specified in this file.

# For more details on how to configure your build environment visit
# http://www.gradle.org/docs/current/userguide/build_environment.html

# Specifies the JVM arguments used for the daemon process.
# The setting is particularly useful for tweaking memory settings.
<#if isLowMemory!false>
org.gradle.jvmargs=-Xmx1024m
<#else>
org.gradle.jvmargs=-Xmx1536m
</#if>

# When configured, Gradle will run in incubating parallel mode.
# This option should only be used with decoupled projects. More details, visit
# http://www.gradle.org/docs/current/userguide/multi_project_builds.html#sec:decoupled_projects
# org.gradle.parallel=true
#maven打包相关
GROUP=${packageName}
#VERSION_NAME = 1.0-SNAPSHOT
POM_PACKAGING=aar

#APP版本
VERSION_CODE=0
VERSION_NAME=0.0.1

#sdk版本    
COMPILE_SDK_VERSION=${compileSdk}
BUILD_TOOLS_VERSION=${buildTools}

MIN_SDK_VERSION=${minApi}
TARGET_SDK_VERSION=${targetApi}
#版本号
ANDROID_SUPPORT=${compileSdk}.+
ROUTER=1.1.3
ROUTERAPI=1.2.2
<#if isKotlin!false>
KOTLIN_VERSION = 1.1.4-3
</#if>