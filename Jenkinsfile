pipeline {
    agent any
    stages {
        stage('Test') {
            steps {
                sh 'docker run \
                    -v `pwd`:/target \
                    -w /target \
                    android-build ./gradlew test'
            }
        }
       stage('Build') {
          steps {
              sh 'docker run \
                    -v `pwd`:/target        \
                    -w /target              \
                    android-build ./gradlew build'
          }
       }
    }
}
