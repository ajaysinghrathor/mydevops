pipeline {
    agent any
    
        
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
