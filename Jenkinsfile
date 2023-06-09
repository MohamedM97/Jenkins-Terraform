pipeline {
  agent any
  tools {
    terraform 'terraform'
} 
  stages {
    stage('Clone Git Repo') {
      steps {
            checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/MohamedM97/jenkins-docker']])
            }
        }
    stage("terraform init"){
        steps{
                sh 'terraform init'
                echo "====++++executing terraform init++++===="
            }
        }
    stage("Terraform plan"){
        steps{
                sh 'terraform plan'
                echo "====++++executing terraform plan++++===="
        }
    }
    stage("terraform apply")
        steps{
            sh 'terraform apply -auto-approve'
        }
  }
}
