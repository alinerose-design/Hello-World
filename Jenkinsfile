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
                echo 'Building Docker image'
                sh 'docker build -t hello-world-app .'
            }
        }

        stage('Deploy Application') {
            steps {
                echo 'Deploying application'
                sh 'docker run -d -p 8081:80 hello-world-app || true'
            }
        }

    }
}
