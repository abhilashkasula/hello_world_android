pipeline {
    agent any
    stages {
       stage('Build') {
          steps {
              sh 'echo "sdk.dir=${ANDROID_HOME}" > local.properties'
              sh 'CMD="./gradlew build"
                        docker run --rm             \
                        -u "${UID}"            \
                        -v `pwd`:/target        \
                        -w /target              \
                        android-env $CMD'
          }
       }
    }
}