pipeline {
  agent any
  tools {
    // Note: This should match with the tool name configured in your jenkins instance (JENKINS_URL/configureTools/)
    maven 'maven383'
  }

  stages {

    stage('Checkout') {
      steps {
        git branch: 'main', url: 'https://github.com/abbassizied/amsrest_sonarqube_nexus.git'
      }
    }    
    stage('build') {
      steps {
        sh 'mvn clean install -DskipTests'
      }
    }

    stage('deploy to Nexus') {

      steps {

        script {

          nexusArtifactUploader(

            artifacts: [
              // Artifact generated such as .jar, .ear and .war files.
              [artifactId: 'ams_rest',
                classifier: '',
                file: 'target/ams_rest-0.0.1-SNAPSHOT.jar',
                type: 'jar']
            ],

            credentialsId: 'nexus_cred',
            groupId: 'com.sip',
            nexusUrl: 'localhost:8081',
            nexusVersion: 'nexus3',
            protocol: 'http',
            repository: 'ams_repo',
            version: '0.0.1-SNAPSHOT'
          );
        }

      }

    }

  }
}


