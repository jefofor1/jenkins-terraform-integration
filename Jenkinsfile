pipeline {
    agent any
    
    parameters {
        choice(
            name: 'action',
            choices: ['apply', 'destroy'],
            description: 'Select Terraform action'
        )
    }
    
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
    
        stage ("terraform init") {
            steps {
                sh ("terraform init -reconfigure") 
            }
        }
        
        stage ("terraform plan") {
            steps {
                sh ('terraform plan') 
            }
        }
        
        stage ("terraform Action") {
            steps {
                echo "Terraform action is --> ${params.action}"
                sh ('terraform ${params.action} --auto-approve') 
           }
        }
    }
}
