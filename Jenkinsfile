pipeline {
    agent any
    stages {
       stage('Build') {
          steps {
              sh 'echo "sdk.dir=${ANDROID_HOME}" > local.properties'
              sh 'docker run --rm             \
                        -u "${UID}"            \
                        -v `pwd`:/target        \
                        -w /target              \
                        android-env ./gradlew build'
          }
       }
    }
}