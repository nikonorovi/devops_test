pipeline {
    agent any
    stages {
        stage('Preparation') {  

            sh 'mvn archetype:generate -B ' +
            '-DarchetypeGroupId=org.apache.maven.archetypes ' +
            '-DarchetypeArtifactId=maven-archetype-quickstart ' +
            '-DgroupId=com.company -DartifactId=myproject'
      
 
        }
        stage('Build') {
            
            dir ('myproject') {
                sh 'mvn clean install test'
            } 
       
       }
    }
}
