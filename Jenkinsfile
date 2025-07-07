pipeline {
    agent {
        docker {
            image 'docker:20.10.24-dind'
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
                sh '''
                    apk add --no-cache curl wget git
                    curl -sfL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/install.sh | sh -s -- -b /usr/local/bin

                    mkdir -p /tmp/trivy-template
                    wget -O /tmp/trivy-template/html.tpl https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/html.tpl

                    trivy image --format template --template "@/tmp/trivy-template/html.tpl" -o trivy-report.html todo-app
                '''
                archiveArtifacts artifacts: 'trivy-report.html', fingerprint: true
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
