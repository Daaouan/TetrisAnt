pipeline {
    agent any
    environment {
        DOCKER_USERNAME = "${DOCKER_USERNAME}" // Ensure this is set in Jenkins credentials or environment variables
        DOCKER_PASSWORD = "${DOCKER_PASSWORD}" // Ensure this is set in Jenkins credentials or environment variables
        IMAGE_NAME = "${DOCKER_USERNAME}/tetrisant:${env.GIT_COMMIT}" // Use GIT_COMMIT for image tagging
    }
    stages {
        stage('Build Image') {
            steps {
                script {
                    echo "Building Docker image..."
                    sh "docker build -t ${IMAGE_NAME} ."
                    echo "Docker image built successfully!"
                }
            }
        }
        
        stage('Publish Image') {
            steps {
                script {
                    echo "Publishing the application..."
                    echo "${DOCKER_PASSWORD}" | sh "docker login -u ${DOCKER_USERNAME} --password-stdin"
                    echo "Pushing the image to DockerHub..."
                    sh "docker push ${IMAGE_NAME}"
                }
            }
            // This step runs manually and only on 'main' and tag branches
            when {
                allOf {
                    triggeredBy 'manual' // Ensure the step can be triggered manually
                }
            }
        }
    }
    post {
        always {
            echo 'Cleaning up...'
            sh "docker rmi ${IMAGE_NAME} || true" // Clean up the image after the job
        }
    }
}
