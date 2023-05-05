pipeline {
    agent any

    stages {
        stage('Atualizando Código') {
            steps {
                git branch: 'dev', url: 'https://github.com/gui-sousa/grafana-k8s.git'
            }
        }

        stage('Deploy K8s') {
          steps {
            withKubeConfig([credentialsId: 'k0s-vanuatu']) {
                sh 'curl -LO "https://storage.googleapis.com/kubernetes-release/release/v1.20.5/bin/linux/amd64/kubectl"'  
                sh 'chmod u+x ./kubectl'
                sh './kubectl apply -f https://raw.githubusercontent.com/gui-sousa/nginx-guizin/master/service.yaml'
                sh './kubectl apply -f https://raw.githubusercontent.com/gui-sousa/nginx-guizin/master/deployment.yaml'
            }
        }

      }

      stage('Test Nginx Page') {
        steps {
            httpRequest consoleLogResponseBody: true, responseHandle: 'NONE', url: 'http://10.1.81.21:32001/', validResponseCodes: '200', validResponseContent: 'Guizin!'
        }

      }  
    }
}

