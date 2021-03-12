pipeline {
	agent none;

    options {
        buildDiscarder(logRotator(numToKeepStr: '3'))
    }

    stages {
        stage('Windows Build and Deploy to nexus') {
        	agent {
        		label 'windows'
    		}
        
            steps {
                configFileProvider([configFile(fileId: 'maven-settings-rsb', variable: 'MAVEN_SETTINGS_RSB')]) {
                    //container('maven') {
                        bat 'mvn -s $MAVEN_SETTINGS_RSB clean deploy'
                    //}
                }
            }
        }
    }
}
