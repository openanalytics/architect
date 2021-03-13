pipeline {
	agent none;

    options {
        buildDiscarder(logRotator(numToKeepStr: '3'))
    }

    stages {
        // stage('Build and Deploy to nexus') {
        // 	agent {
        // 		kubernetes {
        //     		yamlFile 'kubernetesPod.yaml'
        // 		}
    	// 	}
        
        //     steps {
        //         configFileProvider([configFile(fileId: 'maven-settings-rsb', variable: 'MAVEN_SETTINGS_RSB')]) {
        //             container('maven') {
        //                 sh 'mvn -s $MAVEN_SETTINGS_RSB clean deploy'
        //             }
        //         }
        //     }
        // }

        stage('Windows Build and Deploy to nexus') {
        	agent {
        		label 'windows'
    		}
        
            steps {
                configFileProvider([configFile(fileId: 'maven-settings-rsb', variable: 'MAVEN_SETTINGS_RSB')]) {
                		echo "Current workspace is ${env.WORKSPACE}"
                        dir ("eu.openanalytics.architect.installer.win32") {
                        bat "mvn -s $MAVEN_SETTINGS_RSB clean deploy"
                    }
                }
            }
        }
    }
}
