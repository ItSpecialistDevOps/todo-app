pipeline {
    agent {
        docker {
            image 'docker:20.10.24-dind'  // Docker-in-Docker image with CLI
            args '--privileged -v /var/run/docker.sock:/var/run/docker.sock'
        }
    }

    stages {
        stage('Clone Repo') {
            steps {
                git branch: 'main', url: 'https://github.com/ItSpecialistDevOps/todo-app.git'
            }
        }

        stage('Install Dependencies') {
            steps {
                sh '''
                    apk add --no-cache nodejs npm
                    npm install
                '''
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t todo-app .'
            }
        }

        stage('Scan Image with Trivy') {
            steps {
                sh 'trivy image todo-app'
            }
        }

        stage('Run Docker Container') {
            steps {
                sh '''
                    docker stop todo || true
                    docker rm todo || true
                    docker run -d --name todo -p 3000:3000 todo-app
                '''
            }
        }
    }
}
