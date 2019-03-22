pipeline {
    agent any
    tools {
        maven 'Maven 3.6.0'
        jdk 'jdk8'
    }
    stages {
    stage('Checkout external proj') {
        steps {
            git branch: 'develop',
                url: 'https://github.com/nikonorovi/devops_test.git'

            sh "ls -lat"
        }
    }
        stage ('Initialize') {
            steps {
                sh '''
                    echo "PATH = ${PATH}"
                    echo "M2_HOME = ${M2_HOME}"
                '''
            }
        }

        stage ('Build') {
            steps {
                sh 'mvn clean install '
                sh 'ls ./target/ |grep .jar$|xargs -i cp ./target/{} /data/repo/example-0.0.1-${BUILD_NUMBER}-develop.jar'
            }
        }
    }
}
