pipeline
{
    environment
    {
        IMAGE_NAME = 'ziadmmh/goviolin'
        CREDENTIALS = 'dockerHub'
        CUSTOM_IMAGE = ''
    }
    agent any
    stages
    {
        stage('Build IMAGE')
        {
            steps
            {
                script
                {
                    CUSTOM_IMAGE = docker.build("ziadmmh/goviolin")
                }
            }
        }
        
        stage('Push')
        {
            steps
            {
                script
                {
                    docker.withRegistry('https://registry.hub.docker.com', CREDENTIALS) 
                    {
                        CUSTOM_IMAGE.push('latest')
                    }
                }
            }
        }
    }
    post
    {
        always
        {
            echo 'Finished.'
        }
        failure {
            mail to: 'ziadmansour.4.9.2000@gmail.com', subject: 'The Pipeline failed :(', body: 'Please refer to the logs ...'
        }
    }
}