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
					defaultContainer 'maven'
					workspaceVolume dynamicPVC(accessModes: 'ReadWriteOnce', requestsSize: '40Gi')
				}
			}
			
			steps {
				configFileProvider([configFile(fileId: 'maven-settings-rsb', variable: 'MAVEN_SETTINGS_RSB')]) {
					container('maven') {
						withEnv(['MAVEN_OPTS+MEM=-Xmx3584m -Xms3584m']) {
							sh "mvn deploy\
									--batch-mode -s $MAVEN_SETTINGS_RSB\
									-Dmaven.test.failure.ignore=true\
									-Daether.connector.http.reuseConnections=false"
						}
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
					dir("eu.openanalytics.architect.installer.win32") {
						bat "mvn clean deploy\
								--batch-mode -s $MAVEN_SETTINGS_RSB\
								"
					}
				}
			}
		}
	}
	
}
