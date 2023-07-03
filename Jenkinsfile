pipeline {

    environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    }

   agent  any
    stages {
        stage('checkout') {
            steps {
                 script{
                          git branch: 'main', url: 'https://github.com/goodluck2717/rakesh_pipeline.git'
                    }
                }
            }

        stage('Plan') {
            steps {
                sh 'terraform init'
            }
        }

        
        stage('fmt') {
            steps {
                sh 'terraform fmt'
            }
        }

         stage('validate') {
            steps {
                sh 'terraform validate'
            }
        }

        stage('plan') {
            steps {
                sh 'terraform plan'
            }
        }

       
        stage('destroy') {
            steps {
                sh 'terraform destroy -auto-approve'
            }
        } 
        stage('apply') {
            steps {
                sh 'terraform apply -auto-approve'
            }
        }


    }

  }
