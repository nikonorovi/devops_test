pipeline {
    agent any
    stages {
        stage ('Clone') {
            steps {
                git branch: 'master', url: "https://github.com/nikonorovi/devops_test.git"
            }
        }

        stage ('Artifactory configuration') {
            steps {
                mvn clean install
            }
        }
    }
}
