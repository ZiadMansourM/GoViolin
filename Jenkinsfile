pipeline {
    def customImage
    stages {
        stage('Clone repository') {
            checkout scm
        }
        stage('Build image') {
            customImage = docker.build("ziadmmh/goviolin")
        }
        stage('Push image') {   
            docker.withRegistry('https://registry.hub.docker.com', 'dockerHub') {
                customImage.push()
            }
        }
    }
    post {
        always {
            emailext body: 'A Summary EMail', recipientProviders: [[$class: 'DevelopersRecipientProvider'], [$class: 'RequesterRecipientProvider']], subject: 'Summary'
        }
    }
}