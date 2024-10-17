pipeline {
    agent {
        docker { 
            image 'docker:latest' 
            args '-v /var/run/docker.sock:/var/run/docker.sock' // If needed to use Docker-in-Docker
        }
    }
    environment {
        DOCKER_USERNAME = 'your-dockerhub-username'
        DOCKER_PASSWORD = 'your-dockerhub-password'
        IMAGE_NAME = "${DOCKER_USERNAME}/tetrisant:${env.GIT_COMMIT}"
    }
    stages {
        stage('Build Image') {
            steps {
                script {
                    echo "Building Docker image..."
                    sh "docker build -t ${IMAGE_NAME} ."
                }
            }
        }
        stage('Push Image') {
            when {
                branch 'main'
            }
            steps {
                script {
                    echo "Logging into DockerHub..."
                    sh "echo ${DOCKER_PASSWORD} | docker login -u ${DOCKER_USERNAME} --password-stdin"
                    echo "Pushing the image to DockerHub..."
                    sh "docker push ${IMAGE_NAME}"
                }
            }
        }
    }
    post {
        always {
            echo 'Cleaning up...'
            sh "docker rmi ${IMAGE_NAME} || true"
        }
    }
}
