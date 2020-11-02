pipeline {
    agent any
    stages {
        stage('Test and Build') {
            parallel {
                stage('Test') {
                    agent any
                    steps {
                        sh 'docker run \
                            -v `pwd`:/target \
                            -w /target \
                            android-build ./gradlew test'
                    }
                }
                stage('Build') {
                    agent any
                    steps {
                       sh 'docker run \
                             -v `pwd`:/target        \
                             -w /target              \
                             android-build ./gradlew build'
                    }
                }
            }
        }
    }
}
