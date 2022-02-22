## Este projeto é uma solução para o AWS Challange para DevSecOps
[Link do repo do desafio ](http://exemplo.com/)

#### Este projeto tem como objetivo: 
- Utilizar as ferramentas Terraform, Ansible para providenciar uma infrestrutura como código (IaC) na cloud AWS.
- Instalar e configurar as ferramentas Docker, Jenkins e SonarQube.
- Criar um Job no Jenkins trigando um repositório de uma aplicação para teste [Link aplicação](https://github.com/thiagoalmeidadon/app-teste-devsecops)

#### Como Executar:
##### Lembre-se de configurar as Keys de acesso AWS CLI
```
aws configure
```
##### Configurar o SSH (eu criei uma chave geral para AWS, assim tenho acesso com a mesma em qualquer região)
```
ssh-keygen -f aws-geral -t rsa
mv aws-geral ~/.ssh/
mv aws-geral.pub ~/.ssh/
```
##### Executando:
```
terraform init
terraform apply
ansible-playbook ansible/provisioning.yml -i ansible/hosts
```
#### Lógica 
##### - O script Terraform vai gerar toda infra necessária na AWS e também preencher o arquivo hosts do ansible com o IP, grupo e usuário do host
##### - O Ansible vai fazer o update dos repositórios do host e instalar o Docker e o Docker-compose e baixar os contêiners do Jenkins e do Sonarqube. [LINK](https://github.com/thiagoalmeidadon/devsecops-docker-compose)
##### - Quando for criado o Job com a Pipeline do Jenkins vai ser verificado um repositório com um código simples. Caso o código tenha vulnerabilidades, foi definido um stage de verificação na pipeline pelo SonarQube Scanner que vai aprovar a Build somente se o código passar nos requisitos minimos.

### Configurando
1- Primeiro passo foi acessar o jenkins http://host:8080 e configurar a key (está no arquivo senha_jenkins, gerado pelo ansible).        
![](https://github.com/thiagoalmeidadon/aws-challange-devsecops/blob/challenge-accepted/img/jenkins_config.png)

2- É necessário instalar um plugin SonarQube Scanner, ele vai ser usado na pipeline do Jenkins para verificar o código e barrar a pipeline, caso o código não esteja apto.    
![](https://github.com/thiagoalmeidadon/aws-challange-devsecops/blob/challenge-accepted/img/sona_plugin.png)

3- Depois ao acessar o SonarQube http://host:9000, foi criado um token com o nome e um name para o projeto.           
![](https://github.com/thiagoalmeidadon/aws-challange-devsecops/blob/challenge-accepted/img/sonar-token.png)

4- É necessário configurar o stage da pipeline no Jenkinsfile com as credenciais que são geradas.                                                                              
![](https://github.com/thiagoalmeidadon/aws-challange-devsecops/blob/challenge-accepted/img/config_comando_sonar_pipeline.png)

5- No Jenkins, foi criado uma chave de autenticação com a key de acesso do sonar. É preciso configurar o plugin do Sonarqube Scanner em Manage jenkins > Configure System.
![](https://github.com/thiagoalmeidadon/aws-challange-devsecops/blob/challenge-accepted/img/sonar_config_no_jenkins.png)

6- Criando um webhook no SonarQube em Administration > Webhooks > create. Esse webhook vai ser necessário para o plugin do sonarqube no jenkins receber um status de resposta.  
![](https://github.com/thiagoalmeidadon/aws-challange-devsecops/blob/challenge-accepted/img/sonar_webhook_jenkins.png)

7- Foi cofigurado um Quality Gates e criado uma métrica de tolerância de 1 vulnerabilidade para o teste.                                                                
![](https://github.com/thiagoalmeidadon/aws-challange-devsecops/blob/challenge-accepted/img/python_qualitygates_01.png)
![](https://github.com/thiagoalmeidadon/aws-challange-devsecops/blob/challenge-accepted/img/python_qualitygates_02.png)     
Também deve ser configurado no projeto em Administration > Quality Gate, o quality gate que foi criado.
![](https://github.com/thiagoalmeidadon/aws-challange-devsecops/blob/challenge-accepted/img/python_qualitygates_03.png)         

8- O próximo passou foi criar um Job no Jenkins do tipo Pipeline e inserir o conteúdo do Jenkinsfile no editor do groovy.                                 
![](https://github.com/thiagoalmeidadon/aws-challange-devsecops/blob/challenge-accepted/img/jenkins_pipeline.png)                                            
![](https://github.com/thiagoalmeidadon/aws-challange-devsecops/blob/challenge-accepted/img/jenkins_script_na_pipeline.png)                               

9- Fazendo a execução do Job e a aplicação vulnerável com mais de uma vulnerabilidade o build é barrado.                                                
![](https://github.com/thiagoalmeidadon/aws-challange-devsecops/blob/challenge-accepted/img/nao_passou.png)  
Aplicação vulnerável: ![](https://github.com/thiagoalmeidadon/aws-challange-devsecops/blob/challenge-accepted/img/codigo_vulneravel.png)  

10- Fazendo o mesmo teste, mas corrigindo alguma coisa na aplicação, o suficiente para ser aprovado na métrica definida no Quality Gate.   
![](https://github.com/thiagoalmeidadon/aws-challange-devsecops/blob/challenge-accepted/img/passou.png)                       
Aplicação menos vulnerável: ![](https://github.com/thiagoalmeidadon/aws-challange-devsecops/blob/challenge-accepted/img/codigo_menos_vulneravel.png)  




