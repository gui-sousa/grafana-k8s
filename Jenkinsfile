pipeline {
    agent any

    environment {
        CHAT_TOKEN = credentials('google-chat-guisousa')
        GIT_URL = "https://github.com/gui-sousa/grafana-k8s.git"
    }

    stages {
        stage('Update Code') {
            steps {
                git branch: 'dev', url: "$GIT_URL"
            }

            post {
                always {
                   hangoutsNotify message: "⚙️ Iniciando build\n⏰ Horario de início: $BUILD_TIMESTAMP", token: "$CHAT_TOKEN", threadByJob: false
                }
            }
        }

        stage('Docker Build') {
            steps {
                script {
                    dockerapp = docker.build("guisousa/grafana-bwg:${env.BUILD_ID}", "-f Dockerfile . --no-cache")
                }
            }
        }

        stage('Docker Push Image') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'docker-gsousa') {
                        dockerapp.push('latest')
                        dockerapp.push(env.BUILD_ID)
                    }
                }
            }
        }

        stage('Deploy Kubernetes') {
            steps {
                withKubeConfig([credentialsId: 'k0s-vanuatu']) {
                    sh 'curl -LO "https://storage.googleapis.com/kubernetes-release/release/v1.20.5/bin/linux/amd64/kubectl"'
                    sh 'chmod +x kubectl' 
                    sh './kubectl apply -f service.yaml'
                    sh './kubectl apply -f deployment.yaml'
                }
            }
        }

        stage('Test Grafana login Page') {
            steps {
                httpRequest consoleLogResponseBody: true, responseHandle: 'NONE', url: 'http://10.1.81.21:32004/', validResponseCodes: '200', validResponseContent: 'Grafana'
            }
        }

        stage('Aprovar Exlusão k8s') {
            steps {
                input "Deseja continuar com a exclusão da Infraestrutura Kubernetes?"
            }

            post {
                always {
                    hangoutsNotify message: "✅ Deu Certo!\n⏰ Tempo de Duração: ${currentBuild.duration / 1000} segundos", token: "$CHAT_TOKEN", threadByJob: false
                }
            }
        }

        stage('Destruindo Infraestrutura 👿') {
            steps {
                withKubeConfig ([credentialsId: 'k0s-vanuatu']) {
                    sh './kubectl delete -f deployment.yaml'
                    sh './kubectl delete -f service.yaml'
                }
            }
        }
    }

    post {
        success {
            hangoutsNotify message: "✅ Deu Certo!\n⏰ Tempo de Duração: ${currentBuild.duration / 1000} segundos", token: "$CHAT_TOKEN", threadByJob: false
        }

        failure {
           hangoutsNotify message: "❌ Deu Errado!\n⏰ Tempo de Duração: ${currentBuild.duration / 1000} segundos", token: "$CHAT_TOKEN", threadByJob: false 
        }
    } 
}
