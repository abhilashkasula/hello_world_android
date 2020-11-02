pipeline {
    agent any
    stages {
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
