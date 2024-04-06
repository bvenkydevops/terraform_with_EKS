pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_KEY')
        AWS_DEFAULT_REGION = 'us-east-1'
    }
    stages {
        stage('git checkout') {
            steps {
                script{
                  checkout scmGit(branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/bvenkydevops/terraform_with_EKS.git']])
                }
            }
        }
        stage('initializing terraform'){
            steps{
                script{
                    dir('EKS-cluster'){
                        sh 'terraform init'
                    }
                }
            }
        }
        stage('formating terraform'){
            steps{
                script{
                    dir('EKS-cluster'){
                        sh 'terraform fmt'
                    }
                }
            }
        }
        stage('validating terraform'){
            steps{
                script{
                    dir('EKS-cluster'){
                        sh 'terraform validate'
                    }
                }
            }
        }
        stage('previewing the infra using terraform'){
            steps{
                script{
                    dir('EKS-cluster'){
                        sh 'terraform plan'
                    }
                    input(message: 'Are you sure to proceesd', ok: 'proceed')
                }
            }
        }
        stage('create/Destroy the EKS-cluster'){
            steps{
                script{
                    dir('EKS-cluster'){
                        sh 'terraform $action --auto-approve'
                    }
                }
            }
        }
        stage('Deploy the App into EKS'){
            steps{
                script{
                    dir('EKS-cluster/ConfigurationFiles'){
                        sh 'aws eks update-kubeconfig --name my-eks-cluster'
                        sh 'kubectl apply -f deployment.yml'
                        sh 'kubectl apply -f service.yml'
                    }
                }
            }
        }
    }
}
