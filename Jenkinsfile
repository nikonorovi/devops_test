pipeline {
    agent any
    stages {
        stage ('Clone') {
            steps {
                git branch: 'master', url: "https://github.com/nikonorovi/devops_test.git"
                withMaven(
                    maven: 'Maven_3.6',
 
              sh "mvn clean install"
            }
        }



        stage ('Artifactory configuration') {
            steps {
                echo "test"
            }
        }
    }
}
