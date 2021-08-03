pipeline{
    agent any
    
    stages{
        stage('Git Checkout'){
            steps{
                git 'https://github.com/OrganizationName6/node-app.git'
            }
        }
        stage('SonarQube Analysis'){
            steps{
                script{
                    withSonarQubeEnv('sonarqube'){
                        nodejs(nodeJSInstallationName: 'nodejs16.5'){
                            sh "npm run sonar"
                        }
                    }
                }
            }
        }
        stage('SonarQube Quality Gate'){
            steps{
                script{
                    timeout(time: 2, unit: 'MINUTES') {
                        def qualityGate = waitForQualityGate()
                        if (qualityGate.status != 'OK') {
                            error "Pipeline aborted due to quality gate failure: ${qualityGate.status}"
                        }
                    }
                }
            }
        }
        stage('Build Docker Image'){
            steps{
                sh "docker build -t cyrustheone/nodejs-app ."
            }
        }
        stage('Push Image to Docker Hub'){
            steps{
                withCredentials([string(credentialsId: 'docker-hub-credentials', variable: 'docker_hub_credentials')]) {
                    sh "docker login -u cyrustheone -p ${docker_hub_credentials}"
                    sh "docker push cyrustheone/nodejs-app"
                }
            }
        }
        stage('Execute Ansible Playbook'){
            steps{
                ansiblePlaybook credentialsId: 'private-key', disableHostKeyChecking: true, installation: 'ansibledeploy', inventory: 'playbooks/hosts', playbook: 'playbooks/kubernetes-helm-deployment.yml'
                ansiblePlaybook credentialsId: 'private-key', disableHostKeyChecking: true, installation: 'ansibledeploy', inventory: 'playbooks/hosts', playbook: 'playbooks/kubernetes-monitoring-deployment.yml'
            }
        }
    }
}
