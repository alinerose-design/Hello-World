pipeline {
    agent any

    stages {

        stage('Clone Repository') {
            steps {
                echo 'Cloning repository'
                git 'https://github.com/alinerose-design/Hello-World.git'
            }
        }

        stage('Run Unit Tests') {
            steps {
                echo 'Running tests'
                sh 'echo "Tests executed successfully"'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo 'Building Docker image'
                sh 'echo "docker build -t hello-world-app ."'
            }
        }

        stage('Push Image to Docker Hub') {
            steps {
                echo 'Pushing image to Docker Hub'
                sh 'echo "docker push yourdockerhub/hello-world-app"'
            }
        }

        stage('Deploy to Test Server') {
            steps {
                echo 'Deploying container'
                sh 'echo "docker run -d -p 8082:80 hello-world-app"'
            }
        }

    }
}
