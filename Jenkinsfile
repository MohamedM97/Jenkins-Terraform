pipeline {
  agent any
  tools {
    terraform 'terraform'
} 
  stages {
    stage('Clone Git Repo') {
      steps {
                git(
                    url: "https://github.com/MohamedM97/Jenkins-Terraform.git",
                    branch: "main",
                    changelog: true,
                    poll: true
                )
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
