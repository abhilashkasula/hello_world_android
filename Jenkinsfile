pipeline {
    agent any
    stages {
       stage('Setup') {
           steps {
              sh 'echo "sdk.dir=${ANDROID_HOME}" > local.properties'
           }
       }
       stage('Build') {
          steps {
              sh './gradlew build'
          }
       }
    }
}