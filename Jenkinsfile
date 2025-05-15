pipeline {
    agent any

    environment {
        IMAGE_NAME = 'my-tomcat-server'
        CONTAINER_NAME = 'tomcat-server'
        HOST_PORT = '8083'
        CONTAINER_PORT = '8080'
    }

    triggers {
        cron('H/5 * * * *') // Runs every 5 minutes
    }

    options {
        timestamps()
    }

    stages {
        stage('Print Info') {
            steps {
                echo 'This pipeline runs every 5 minutes'
            }
        }

        stage('Checkout') {
            steps {
                git credentialsId: 'github-credentials', url: 'https://github.com/venkadali/my-project2.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh """
                        echo "Building Docker image: ${IMAGE_NAME}"
                        docker build -t ${IMAGE_NAME} .
                    """
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    sh """
                        echo "Stopping existing container if running..."
                        docker rm -f ${CONTAINER_NAME} 2>/dev/null || true
                        
                        echo "Starting new container..."
                        docker run -d -p ${HOST_PORT}:${CONTAINER_PORT} --name ${CONTAINER_NAME} ${IMAGE_NAME}
                    """
                }
            }
        }
    }

    post {
        success {
            echo "✅ Tomcat server is running at http://localhost:${HOST_PORT}"
        }
        failure {
            echo "❌ Build failed. Check logs for details."
        }
    }
}

