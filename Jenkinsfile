pipeline {
    agent {
        docker { image 'docker:latest' }
    }
    environment {
        DOCKER_DRIVER = 'overlay2'
        IMAGE_NAME = "mdaaoaun/tetrisant:${env.GIT_COMMIT.substring(0,7)}"
    }
    stages {
        stage('Build') {
            when {
                branch 'main'
            }
            steps {
                script {
                    echo "Building Docker image..."
                    sh 'docker build -t ${IMAGE_NAME} .'
                    echo "Docker image built successfully!"
                }
            }
            post {
                success {
                    archiveArtifacts artifacts: 'dist/Tetris.jar', allowEmptyArchive: true
                }
            }
        }
        stage('Publish') {
            when {
                expression {
                    return env.BRANCH_NAME == 'main' || env.TAG_NAME
                }
            }
            steps {
                script {
                    input message: 'Do you want to publish the Docker image?', ok: 'Publish'
                    echo "Publishing the application..."
                    sh '''
                        echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
                        docker push ${IMAGE_NAME}
                    '''
                }
            }
        }
    }
    post {
        always {
            cleanWs()
        }
    }
}
