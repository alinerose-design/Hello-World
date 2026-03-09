pipeline {
    agent any

    stages {

        stage('Clone Repository') {
            steps {
                echo 'Cloning repository...'
                git 'https://github.com/alinerose-design/Hello-World.git'
            }
        }

        stage('Run Tests') {
            steps {
                echo 'Running unit tests'
                sh 'echo "Tests executed successfully"'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo 'Simulating Docker build'
                sh 'echo "Docker image hello-world-app built successfully"'
            }
        }

        stage('Deploy Application') {
            steps {
                echo 'Deploying application to test server'
                sh 'echo "Application deployed successfully"'
            }
        }

    }
}
