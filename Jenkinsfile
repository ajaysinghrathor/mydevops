pipeline {
    agent any
    
    stages {
        stage('Checkout') {
            steps {
                // Checkout your repository
                git 'https://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@github.com/ajaysinghrathor/mydevops.git'
            }
        }
        
        stage('Terraform Init') {
            steps {
                // Execute 'terraform init' command
                sh 'terraform init'
            }
        }
        
        stage('Terraform Apply') {
            steps {
                // Execute 'terraform apply' command
                sh 'terraform apply -auto-approve'
            }
        }
    }

}
