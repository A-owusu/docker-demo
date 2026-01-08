pipeline {
    agent any

    environment {
        IMAGE = "owusu495/flask-app"
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t ${IMAGE}:latest ."
            }
        }

        stage('Test') {
            steps {
                sh "echo 'Running tests...'"
                // sh "pytest -q"   // (optional: once tests exist)
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                    sh """
                        echo \$PASS | docker login -u \$USER --password-stdin
                        docker push ${IMAGE}:latest
                    """
                }
            }
        }

        stage('Deploy') {
            steps {
                sh """
                    docker stop flask-app || true
                    docker rm flask-app || true
                    docker run -d -p 5000:5000 --name flask-app ${IMAGE}:latest
                """
            }
        }
    }
}
