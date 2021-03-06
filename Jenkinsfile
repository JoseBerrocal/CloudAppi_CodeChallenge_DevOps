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





       stage('Desplegar Infraestructura') {

           when { anyOf {
               branch 'master' 
               branch 'infra'
           }}       

             steps {
                echo 'Creación del VPC para el EKS'
                sh "aws s3 ls"
                sh "./infraestructure/create.sh CloudAppi-Infra infraestructure/ourinfra.yml infraestructure/ourinfra-params.json"
                sh "sleep 100"
                echo 'Creación del VPC para el EKS satisfactorio'
                echo 'Creación del EKS Cluster'
                sh "./infraestructure/create.sh EKS-Cluster-CA infraestructure/eks_cluster.yml infraestructure/eks_cluster-params.json"
                sh "sleep 900"
                echo 'Creación del EKS Cluster satisfactorio'               
                echo 'Creación de Nodos EKS'
                sh "./infraestructure/create.sh EKS-API-Nodos infraestructure/eks_nodegroup.yml infraestructure/eks_nodegroup-params.json"
                sh "sleep 240"
                echo 'Creación de Nodos EKS satisfactorio'
                sh "aws eks --region us-west-2 update-kubeconfig --name ClusterEKS-CA"                
                sh "kubectl config use-context arn:aws:eks:us-west-2:545867861938:cluster/ClusterEKS-CA"
                sh "sleep 5"
                sh "kubectl get svc"
                sh "sleep 5"       
                sh "sh infraestructure/IAM_node.sh" 
                sh "cat infraestructure/aws-auth-cm.yaml"
                sh "sleep 5"
                sh "kubectl apply -f infraestructure/aws-auth-cm.yaml"
                sh "kubectl get nodes"
                sh "sleep 5"      
                sh "kubectl get nodes"
                sh "sleep 5"     
                sh "kubectl get nodes"                                          
            }
        }



       stage('Construir la Imagen Docker') {

           when { anyOf {
               branch 'master' 
               branch 'desple_api'
               branch 'appv2_ima'
           }}          

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

           when { anyOf {
               branch 'master' 
               branch 'desple_api'
               branch 'appv2_ima'
           }}          
           
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


       stage('Remover la imagen Docker') {
           when { anyOf {
               branch 'master' 
               branch 'desple_api'
               branch 'appv2_ima'
           }}           
             steps {
                echo 'Remover la imagen Docker'
                sh "docker rmi $repodocker:$BUILD_NUMBER"
                sh "docker rmi $repodocker:latest"
                 echo 'Se removió la imagen Docker satisfactoriamente'
                 }
             }

        stage('Desplegar la web API') {
           when { anyOf {
               branch 'master' 
               branch 'desple_api'
               branch 'appv2_ima'
           }}           
             steps {
                 echo 'Desplegar la web API'
                 echo 'Crear el Despliege'
                 sh "aws eks --region us-west-2 update-kubeconfig --name ClusterEKS-CA"
                 sh "sleep 5"
                 sh "kubectl apply -f deployment_cloudappi.yaml"
                 echo 'Exponer el servicio http'
                 sh "kubectl expose deployment cloudappi-api --type=LoadBalancer --name=cloudappi-api-svc-http"
                 sh "sleep 15"
                 sh "kubectl get pods"
                 sh "kubectl get deployment"
                 sh "kubectl get svc"
                 sh "sleep 15"
                 sh "sh ext_ip_svc.sh"
                 echo 'Despliege de la web API satisfactorio'
                 }
             }

    }
}