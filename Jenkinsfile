podTemplate(
    containers: [containerTemplate(image: 'docker:19.03.8', name: 'docker', command: 'cat', ttyEnabled: true)],
    volumes: [hostPathVolume(hostPath: '/var/run/docker.sock', mountPath: '/var/run/docker.sock')],
) {
    node(POD_LABEL) {
        def scmInfo

        stage('Clone repository') {
            scmInfo = checkout scm
        }

        stage('Run Maven build') {
	    container('docker') {
	        docker.withRegistry('', 'dockerhub') {
		    def maven = docker.image('maven:3-jdk-11')
                    maven.pull()
                    maven.inside {
                        sh 'mvn install'
                    }
                }
	    }
        }
	
         stage('Tag Docker Images And Push') {
             container('docker') {
                 docker.withRegistry('', 'dockerhub') {
                     image = docker.image("kvalitetsit/medcom-vdx-keycloak-theme:dev")
                     image.push("latest")
                     image.push("${env.GIT_COMMIT}")
                     if (env.TAG_NAME != null && env.TAG_NAME.matches("^v[0-9]*\\.[0-9]*\\.[0-9]*")) {
                         echo "Tagging version"
                         image.push(env.TAG_NAME.substring(1))
                     }
                 }
             }
         }
    }
}