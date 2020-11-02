pipeline {
    agent any
    stages {
       stage('Build') {
          steps {
              sh 'echo "sdk.dir=${ANDROID_HOME}" > local.properties'
              sh 'docker run \
                        -v `pwd`:/target        \
                        -w /target              \
                        android-build ./gradlew build'
          }
       }
    }
}