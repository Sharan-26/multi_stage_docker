pipeline{
    agent any

    environment{
        DOCKER_IMAGE = "kubesharan/multi-stage-docker"
        DOCKER_TAG = "latest"
    }

    stages{

        stage('Build Docker Image'){
            steps{
                echo ' Building Multi-Stage Docker Image'

                sh '''
                    docker build -t ${DOCKER_IMAGE}:${DOCKER-TAG} .
                '''

            }
        }

        stage('Test Docker Image'){
            steps{
                echo ' Testing Docker Image'

                sh '''
                    docker run --rm ${DOCKER_IMAGE}:${DOCKER_TAG}
                '''
            }
        }

        stage('Docker Login') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh '''
                        echo "$DOCKER_PASS" | docker login \
                        -u "$DOCKER_USER" --password-stdin
                    '''
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                sh '''
                    docker push ${DOCKER_IMAGE}:${DOCKER_TAG}
                '''
            }
        }
    }

    post {
        always {
            sh 'docker logout || true'
            echo 'Pipeline completed'
        }

    }
}