pipeline {
	agent none;

    options {
        buildDiscarder(logRotator(numToKeepStr: '3'))
    }

    stages {
        stage('Build and Deploy to nexus') {
         	agent {
         		kubernetes {
             		yamlFile 'kubernetesPod.yaml'
         		}
    	 	}
        
            steps {
                configFileProvider([configFile(fileId: 'maven-settings-rsb', variable: 'MAVEN_SETTINGS_RSB')]) {
                    container('maven') {
                        sh 'mvn -s $MAVEN_SETTINGS_RSB clean deploy'
                    }
                }
            }
        }

        stage('Build and Deploy Windows Installer to nexus') {
        	agent {
        		label 'windows'
    		}
        
            steps {
                configFileProvider([configFile(fileId: 'maven-settings-rsb', variable: 'MAVEN_SETTINGS_RSB')]) {
                    dir ("eu.openanalytics.architect.installer.win32") {
                        bat "mvn -s $MAVEN_SETTINGS_RSB clean deploy"
                    }
                }
            }
        }
    }
}
