pipeline {
    agent any
    tools {
        maven 'Maven 3.6.0'
        jdk 'jdk8'
    }
    stages {
    stage('Checkout external proj') {
        steps {
            git branch: 'master',
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
                sh 'mvn clean install'
                sh 'ls ./target/ |grep .jar$|xargs -i cp ./target/{} /data/repo/example-0.0.1-${BUILD_NUMBER}-master.jar'
            }
        }
        stage ('Clear old container') {
            steps {
                sh 'docker stop spring_dev_app'
                sh 'docker rm spring_dev_app'
                sh 'docker rmi app_dev_img'
            }
        }
        stage ('Build image and run') {
            steps {
            sh '''
            cat << EOF > Dockerfile
            FROM openjdk:8-jdk
            COPY ./target/*.jar /
            CMD java -jar /*.jar
            '''
            sh 'docker build -t app_dev_img .'
            sh 'docker run -d -p 8091:8080 --name spring_dev_app app_dev_img'
            }
        }
        stage ('Test app') {
            steps {
                sh '''#!/bin/bash
                    status=$(curl -s -o /dev/null -w "%{http_code}" http://127.0.0.1:8091/up)
                    if [[ "$status" -eq 200 ]];then
                        echo "APP returned response 200"
                        exit 0
                    else
                        echo "APP returned response 500"
                        exit 2
                    fi
                '''
            }
        }
        stage ('Push image to registry') {
            steps {
                withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'dockerhub', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD']])
                        {
                            sh 'docker login -u $USERNAME -p $PASSWORD'
                            sh 'docker tag app_dev_img inik/gamepoint:latest'
                            sh 'docker push inik/gamepoint'
                        }
            }
        }
    }
}
