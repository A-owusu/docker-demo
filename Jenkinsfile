pipeline {
    agent any

    environment {
        DOCKERHUB = credentials('dockerhub')
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
            }
        }

        stage('Push to Docker Hub') {
            steps {
                sh "echo ${DOCKERHUB_PSW} | docker login -u ${DOCKERHUB_USR} --password-stdin"
                sh "docker push ${IMAGE}:latest"
            }
        }

        stage('Deploy') {
            steps {
                sh "docker stop flask-app || true"
                sh "docker rm flask-app || true"
                sh "docker run -d -p 5000:5000 --name flask-app ${IMAGE}:latest"
            }
        }
    }
}