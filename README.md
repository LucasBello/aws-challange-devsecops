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
##### - O Ansible vai fazer o update dos repositórios do host e instalar o Docker e o Docker-compose, também vai instalar o Jenkins e copiar a senha inicial
##### - O Jenkins e o SonarQube estão versionados neste repositório ([LINK](https://github.com/thiagoalmeidadon/devsecops-docker-compose)) em um arquivo do docker-compose
##### - 
