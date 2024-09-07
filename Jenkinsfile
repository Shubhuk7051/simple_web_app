pipeline {
    agent any
    
    environment {
        S3_BUCKET= 'python-flask-sk'
    }

    stages {
        stage('Clone the git repository') {
            steps {
                git branch: 'main', credentialsId: 'git_cred', url: 'https://github.com/Shubhuk7051/simple_web_app.git'
            }
        }
        stage("Build"){
            steps {
                echo "Building the image"
                sh "docker build -t flaskapp ."
            }
        }
        stage("Push to Docker Hub"){
            steps {
                echo "Pushing the image to docker hub"
                withCredentials([usernamePassword(credentialsId: 'docker-cred', passwordVariable: 'DOCKERHUBPASS', usernameVariable: 'DOCKERHUBUSER')]) {
                sh "docker tag flaskapp ${env.DOCKERHUBUSER}/flaskapp:${env.BUILD_TAG}"
                sh "docker login -u ${env.DOCKERHUBUSER} -p ${env.DOCKERHUBPASS}"
                sh "docker push ${env.DOCKERHUBUSER}/flaskapp:${env.BUILD_TAG}"
                }
            }
        }
        stage('Package Application') {
            steps {
                withCredentials([aws(accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'aws-cred', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                    sh 'zip -r FlaskApp.zip .'
                    sh 'aws s3 cp FlaskApp.zip s3://${S3_BUCKET}/'
                }
            }
        }
        stage('Deploy to AWS') {
            steps {
                withCredentials([aws(accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'aws-cred', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
    
                    script {
                        def deploymentId = sh(script: """
                        aws deploy create-deployment \
                            --application-name python-flask \
                            --deployment-config-name CodeDeployDefault.OneAtATime \
                            --deployment-group-name python-dg \
                             --s3-location bucket=${S3_BUCKET},bundleType=zip,key=Flaskapp.zip \
                            --region 'ap-south-1' \
                            --output text --query 'deploymentId'
                        """, returnStdout: true).trim()
                        echo "Deployment ID: ${deploymentId}"
                    }
                }
            }
        }
    }
}