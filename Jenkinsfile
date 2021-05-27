node {

    checkout scm


    docker.withRegistry('https://registry.hub.docker.com', 'dockerHub') {

        /* [1]: Build Image */
        def customImage = docker.build("ziadmmh/goviolin")

        /* [2]: Push the container to the custom Registry */
        customImage.push()
    }
}