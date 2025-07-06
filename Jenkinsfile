pipeline {
    agent {
        docker {
            image 'node:18'  // or 'node:20' for latest LTS
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
                sh 'npm install'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t todo-app .'
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
