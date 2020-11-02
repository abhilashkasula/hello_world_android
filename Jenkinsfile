pipeline {
    agent any
    stages {
        stage('Test and Build') {
            parallel {
                stage('Test') {
                    steps {
                        sh 'docker run \
                            -v `pwd`:/target \
                            -w /target \
                            android-build ./gradlew test'
                    }
                }
                stage('Build') {
                    agent {
                        node { label 'master' }
                    }
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
