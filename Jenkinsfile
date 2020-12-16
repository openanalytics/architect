pipeline {
    agent {
        kubernetes {
            yamlFile 'kubernetesPod.yaml'
        }
    }

    options {
        buildDiscarder(logRotator(numToKeepStr: '3'))
    }

    stages {
        stage('Build and Deploy to nexus') {
            steps {
                configFileProvider([configFile(fileId: 'maven-settings-rsb', variable: 'MAVEN_SETTINGS_RSB')]) {
                    container('maven') {
                        sh 'mvn -s $MAVEN_SETTINGS_RSB clean deploy'
                    }
                }
            }
        }
    }
}
