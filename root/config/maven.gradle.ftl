/**
 * 上传子模块的aar到maven,加快编译速度
 * 目前为本地maven依赖
 * */

apply plugin: 'maven'
apply plugin: 'signing' //签名
configurations {
    deployerJars
}
repositories {
    mavenCentral()
}
// type显示指定任务类型或任务, 这里指定要执行Javadoc这个task,这个task在gradle中已经定义
task androidJavadocs(type: Javadoc) {
    // 设置源码所在的位置
    source = android.sourceSets.main.java.sourceFiles
}

// 生成javadoc.jar
task androidJavadocsJar(type: Jar) {
    // 指定文档名称
    classifier = 'javadoc'
    from androidJavadocs.destinationDir
}

// 生成sources.jar
task androidSourcesJar(type: Jar) {
    classifier = 'sources'
    from android.sourceSets.main.java.sourceFiles
}

// 产生相关配置文件的任务
artifacts {
    archives androidSourcesJar
    archives androidJavadocsJar
}


def getReleaseRepositoryUrl() {
    return hasProperty('RELEASE_REPOSITORY_URL') ? RELEASE_REPOSITORY_URL : LOCAL_PATH_MAVEN
}

def getSnapshotRepositoryUrl() {
    return hasProperty('SNAPSHOT_REPOSITORY_URL') ? SNAPSHOT_REPOSITORY_URL : ext.MAVEN_LOCAL_PATH
}

def getRepositoryUsername() {
    return hasProperty('SONATYPE_NEXUS_USERNAME') ? SONATYPE_NEXUS_USERNAME : ""
}

def getRepositoryPassword() {
    return hasProperty('SONATYPE_NEXUS_PASSWORD') ? SONATYPE_NEXUS_PASSWORD : ""
}
def getNameSuffix() {
    return hasProperty('POM_NEME_SUFFIX') ? POM_NEME_SUFFIX : ""
}
def POM_ARTIFACT_ID = project.name+getNameSuffix()

//脚本：将Lib打成aar包上传至maven私有库

uploadArchives {
    if(isAppBuild())return;
    repositories {
        mavenDeployer {
            beforeDeployment {
                MavenDeployment deployment -> signing.signPom(deployment)
            }
            repository(url : getReleaseRepositoryUrl()) {
                //authentication(userName: ACCOUNT, password: PASSWORD) //远程登录
            }
           // println("=======================================")
            pom.project {
                //println("=====================2==================")
                groupId GROUP
                artifactId POM_ARTIFACT_ID
                version VERSION_NAME
                name POM_ARTIFACT_ID
                packaging POM_PACKAGING
                description POM_ARTIFACT_ID
            }
           /* filter { artifact,file ->
                print("=====================3==================")
            }*/
        }
    }
}


// 进行数字签名
signing {
    // 当 发布版本 & 存在"uploadArchives"任务时，才执行
    required { gradle.taskGraph.hasTask("uploadArchives") }
    sign configurations.archives
}


