pipeline {
    agent any
    
    stages {
/**        stage('Checkout') {
            steps {
                // Checkout your repository
                git 'https://github.com/ajaysinghrathor/mydevops.git'
            }
        }
**/        
        stage('Terraform Init') {
            steps {
                // Execute 'terraform init' command
                sh 'terraform init'
            }
        }
        
        stage('Terraform Apply') {
            steps {
                echo "subscription_id: ${params.subscription_id}"
                echo "tenant_id: ${params.tenant_id}"
                // Execute 'terraform apply' command
                sh 'terraform apply -auto-approve'
            }
        }
    }
}
