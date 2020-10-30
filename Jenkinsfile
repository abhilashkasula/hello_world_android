pipeline {
    agent any
    stages {
       stage('Build') {
          steps {
              sh 'echo "sdk.dir=${ANDROID_HOME}" > local.properties'
              sh './gradlew build'
          }
       }
    }
}