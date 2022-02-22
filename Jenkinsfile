node {

  stage('Baixa o repositório') { 
    git branch: 'main', url: "https://github.com/thiagoalmeidadon/app-teste-devsecops.git"
  }
  
  stage('Instala o Python e o Wget') {
    sh 'apt update -y && apt install python3 -y && apt install wget'
  }
  
  stage('Baixa sonar-scanner') {
      sh 'wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-4.6.2.2472-linux.zip'
  }
  
  stage('Unzip sonar-scanner') {
      sh 'unzip -n sonar-scanner-cli-4.6.2.2472-linux.zip'
  }

  stage('Executa sonar-scanner') {
      withSonarQubeEnv('sonar') {
            sh 'sonar-scanner-4.6.2.2472-linux/bin/sonar-scanner \
        -Dsonar.projectKey=teste \
        -Dsonar.sources=. \
        -Dsonar.host.url= \
        -Dsonar.login='
      }
  }
  
  stage('Verifica se passou no SonarQube') {
      timeout(time: 5, unit: 'MINUTES') {
          def qualityGate = waitForQualityGate() 
            if (qualityGate.status != 'OK') {
              error "Seu código não passou no teste do Sonarqube status: ${qualityGate.status}"
            }
        }
  }
  
  stage('Deleta') {
    sh 'rm -rf app-teste-devsecops'
  }

}