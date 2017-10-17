<manifest xmlns:android="http://schemas.android.com/apk/res/android"
          <#if isInstantApp!false>xmlns:instant="http://schemas.android.com/instantapps"</#if>
    package="${packageName}">


    <application
	<#if (App!false)>
        android:label="@string/app_name"
        android:icon="@mipmap/ic_launcher"
        android:theme="@style/AppTheme">
	</#if>>
    </application>
  

</manifest>
