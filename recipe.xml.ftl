<?xml version="1.0"?>
<recipe>
<#--子模块的配置相关-->
<#macro moduleOther other>
  <merge from="root/${other}settings.gradle.ftl"
         to="${escapeXmlAttribute(topOut)}/settings.gradle"/>
  <instantiate from="root/${other}AndroidManifest.xml.ftl"
               to="${moduleNamePath}/src/main/AndroidManifest.xml"/>

  <instantiate from="root/${other}gradle.properties.ftl"
               to="${moduleNamePath}/gradle.properties"/>
</#macro>
<#--子模块的目录树创建 -->
<#macro createModule modulePath>
<#--  -->
<#-- 模型目录 -->
    <#assign moduleNamePath="${escapeXmlAttribute(topOut)}/${modulePath}"/>
<#-- 模型包名 -->
    <#assign moduleNamePackage="${moduleNamePath}/src/main/java/${slashedPackageName(packageName)}"/>
    <#if isKotlin>
        <#assign moduleNamePackage="${moduleNamePath}/src/main/kotlin/${slashedPackageName(packageName)}"/>
    </#if>

<#-- 模型资源 -->
    <#assign moduleNameRes="${moduleNamePath}/src/main/res"/>
  <mkdir at="${moduleNamePath}"/>
  <mkdir at="${moduleNamePath}/lib"/>
  <mkdir at="${moduleNamePackage}"/>
<#--基础包结构-->
    <#if isMVP>

        <#if modulePath != "${prefixName}.res" && modulePath != "${prefixName}.debug">
          <mkdir at="${moduleNamePackage}/constant"/>
          <mkdir at="${moduleNamePackage}/contract"/>
          <mkdir at="${moduleNamePackage}/model/dto"/>
          <mkdir at="${moduleNamePackage}/model/view"/>
          <mkdir at="${moduleNamePackage}/model/mapper"/>
          <mkdir at="${moduleNamePackage}/presenter"/>
          <mkdir at="${moduleNamePackage}/service"/>
          <mkdir at="${moduleNamePackage}/ui/activity"/>
          <mkdir at="${moduleNamePackage}/ui/fragment"/>
          <mkdir at="${moduleNamePackage}/ui/adapter"/>
        </#if>
        <#if modulePath == "${prefixName}.debug">
          <mkdir at="${moduleNamePath}/src/main/debug/${slashedPackageName(packageName)}"/>
          <mkdir at="${moduleNamePath}/src/main/release/${slashedPackageName(packageName)}"/>
        </#if>
        <#if modulePath=="${prefixName}.code">
          <mkdir at="${moduleNamePackage}/utils"/>
          <mkdir at="${moduleNamePackage}/app"/>
          <mkdir at="${moduleNamePackage}/widget"/>
        </#if>

    </#if>

    <#--   -->

  <instantiate from="root/build.gradle.ftl"
               to="${moduleNamePath}/build.gradle"/>

    <#switch modulePath>
        <#case "${prefixName}.app">
            <@moduleOther other="_app/"/>
            <#break>
        <#case "${prefixName}.code">
            <@moduleOther other="_code/"/>
            <#break>
        <#case "${prefixName}.debug">
            <@moduleOther other="_debug/"/>
            <#break>
        <#case "${prefixName}.res">
            <@moduleOther other="_res/"/>
            <#break>
        <#case "${prefixName}.test">
            <@moduleOther other="_test/"/>
            <#break>
        <#default>
            <@moduleOther other=""/>
    </#switch>


  <!-- 模型默认资源 -->
  <mkdir at="${moduleNameRes}/drawable"/>
  <copy from="root/res/mipmap-hdpi/ic_launcher.png"
        to="${moduleNameRes}/mipmap-hdpi/ic_launcher.png"/>
  <copy from="root/res/mipmap-mdpi/ic_launcher.png"
        to="${moduleNameRes}/mipmap-mdpi/ic_launcher.png"/>
  <copy from="root/res/mipmap-xhdpi/ic_launcher.png"
        to="${moduleNameRes}/mipmap-xhdpi/ic_launcher.png"/>
  <copy from="root/res/mipmap-xxhdpi/ic_launcher.png"
        to="${moduleNameRes}/mipmap-xxhdpi/ic_launcher.png"/>
  <copy from="root/res/mipmap-xxxhdpi/ic_launcher.png"
        to="${moduleNameRes}/mipmap-xxxhdpi/ic_launcher.png"/>
  <instantiate from="root/res/values/styles.xml.ftl"
               to="${moduleNameRes}/values/styles.xml"/>
  <instantiate from="root/res/values/colors.xml"
               to="${moduleNameRes}/values/colors.xml"/>

  <instantiate from="root/res/values/strings.xml.ftl"
               to="${moduleNameRes}/values/strings.xml"/>

  <instantiate from="root/proguard-rules.txt.ftl"
               to="${moduleNamePath}/proguard-rules.pro"/>


  <instantiate from="root/res/values/strings.xml.ftl"
               to="${escapeXmlAttribute(topOut)}/${modulePath}/src/main/res/values/strings.xml"/>

  <instantiate from="root/test/app_package/ExampleInstrumentedTest.java.ftl"
               to="${moduleNamePath}/src/androidTest/java/${slashedPackageName(packageName)}/ExampleInstrumentedTest.java"/>
  <instantiate from="root/test/app_package/ExampleUnitTest.java.ftl"
               to="${moduleNamePath}/src/test/java/${slashedPackageName(packageName)}/ExampleUnitTest.java"/>
</#macro>
<#-- 主模块-->
<#if App>
  <instantiate from="root/config/gradle.properties.ftl"
               to="${escapeXmlAttribute(topOut)}/gradle_.properties"/>

  <instantiate from="root/config/build.gradle.ftl"
               to="${escapeXmlAttribute(topOut)}/build_.gradle"/>

  <instantiate from="root/config/config.gradle.ftl"
               to="${escapeXmlAttribute(topOut)}/config/config.gradle"/>
  <copy from="root/config/refresh.sh"
        to="${escapeXmlAttribute(topOut)}/config/refresh.sh"/>
  <copy from="root/config/md5.sh"
        to="${escapeXmlAttribute(topOut)}/config/md5.sh"/>
  <instantiate from="root/config/super.gradle.ftl"
               to="${escapeXmlAttribute(topOut)}/config/super.gradle"/>

  <instantiate from="root/config/dependencies.gradle.ftl"
               to="${escapeXmlAttribute(topOut)}/config/dependencies.gradle"/>

  <instantiate from="root/config/maven.gradle.ftl"
               to="${escapeXmlAttribute(topOut)}/config/maven.gradle"/>

    <@createModule modulePath="${prefixName}.app"/>
</#if>
<#-- 核心模块 -->
<#if  Code>
    <@createModule modulePath="${prefixName}.code"/>
</#if>
<#-- Debug模块 -->
<#if  Debug>
    <@createModule modulePath="${prefixName}.debug"/>
</#if>
<#-- 公共资源模块 -->
<#if  Res>
    <@createModule modulePath="${prefixName}.res"/>
</#if>
<#-- 测试模块 -->
<#if  Test>
    <@createModule modulePath="${prefixName}.test"/>
</#if>
<#-- 通用模块 -->
<#if Module>
    <@createModule modulePath="${prefixName}.${moduleName}"/>
</#if>


</recipe>