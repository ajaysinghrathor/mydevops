pipeline {
    agent any
    stages{
        stage('Terraform Init') {
            steps {
                // Execute 'terraform init' command
                sh 'terraform init'
            }
        }

        stage('Terraform Plan') {
            steps {
                //echo "subscription_id: ${params.subscription_id}"
                //echo "tenant_id: ${params.tenant_id}"
                // Execute 'terraform apply' command
                //sh "terraform plan -var='client_id=${params.client_id}' -var='client_secret=${params.client_secret}' -var='subscription_id=${params.subscription_id}' -var='tenant_id=${params.tenant_id}'"
                sh 'terraform plan'
            }
        }

        stage('Terraform Apply') {
            steps {
                //echo "subscription_id: ${params.subscription_id}"
                //echo "tenant_id: ${params.tenant_id}"
                // Execute 'terraform apply' command
                //sh "terraform apply -var='client_id=${params.client_id}' -var='client_secret=${params.client_secret}' -var='subscription_id=${params.subscription_id}' -var='tenant_id=${params.tenant_id}'"
                sh 'terraform apply -auto-approve'
            }
        }


    }//stages    
}//pipeline
