pipeline {

  environment {
    repodocker = "joseberrocal/cloudappi-codechallenge"
    registryCredential = 'docker-hub'
    dockerImage = ''
  }
    agent any

    stages {

       stage('Probando Jenkinsfile') {
             steps {
                 echo 'Test en Jenkinsfile'
                 echo 'Test en Jenkinsfile satisfactorio'
                 }
             }


       stage('Construir la Imagen Docker') {

             steps {
                 checkout scm
                echo 'Construir la imagen Docker'
                script {
                    dockerImage = docker.build repodocker + ":$BUILD_NUMBER"
                    }
                 echo 'Creacion de la Imagen Docker satisfactoriamente'
                 }
             }


       stage('Subir la Imagen Docker') {
             steps {
                echo 'Subir la Imagen Docker'
                script {
                    docker.withRegistry( '', registryCredential ) {
                        dockerImage.push()
                        dockerImage.push('latest')
                        }
                    }
                 echo 'Se subio la Imagen Docker satisfactoriamente'
                 }
             }


    }
}