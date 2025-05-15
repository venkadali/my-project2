pipeline {
    agent any

    environment {
        IMAGE_NAME = 'my-tomcat-server'
        CONTAINER_NAME = 'tomcat-server'
        HOST_PORT = '8081'
        CONTAINER_PORT = '8080'
    }

    stages {
        stage('Checkout') {
            steps {
                git credentialsId: 'github-credentials', url: 'https://github.com/venkadali/my-project2.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t ${IMAGE_NAME} ."
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    // Stop and remove existing container if it exists
                    sh """
                        docker rm -f ${CONTAINER_NAME} || true
                        docker run -d -p ${HOST_PORT}:${CONTAINER_PORT} --name ${CONTAINER_NAME} ${IMAGE_NAME}
                    """
                }
            }
        }
    }

    post {
        success {
            echo "Tomcat server is running at http://localhost:${HOST_PORT}"
        }
    }
}

