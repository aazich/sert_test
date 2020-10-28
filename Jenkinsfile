pipeline {
    
     //triggers {
	//    cron('''*/5 * * * *''')
	  //}
    
    options {
	    disableConcurrentBuilds()
	  }
    
    agent any
    stages {
        stage('Example') {
            steps {
                ftp2_test()
                
            }
        }
    }


  post {
	   success {
	       echo "${env.BUILD_URL} has result success"
	       withCredentials([string(credentialsId: 'token', variable: 'TOKEN'), string(credentialsId: 'chat_id', variable: 'CHAT_ID')]) {
	             sh ("curl -s --header 'Content-Type: application/json' --request 'POST' --data '{\"chat_id\":\"${CHAT_ID}\",\"text\":\"success\n${env.BUILD_URL} has result success. ✅ \"}' 'https://api.telegram.org/bot${TOKEN}/sendMessage\'")
	       }
	   }
	   failure {
	       echo "${env.BUILD_URL} has result fail"
	       withCredentials([string(credentialsId: 'token', variable: 'TOKEN'), string(credentialsId: 'chat_id', variable: 'CHAT_ID')]) {
	             sh ("curl -s --header 'Content-Type: application/json' --request 'POST' --data '{\"chat_id\":\"${CHAT_ID}\",\"text\":\"fail\n${env.BUILD_URL} has result fail. ❌ \"}' 'https://api.telegram.org/bot${TOKEN}/sendMessage\'")
	       }
	   }
	  }
}

def ftp2_test() {
	withCredentials([string(credentialsId: 'l_ftp', variable: 'USERNAME'), string(credentialsId: 'p_ftp', variable: 'PASSWORD')]) {
	       sh ("dd if=/dev/urandom of=test_file bs=1 count=1024 &> /dev/null")
	       sh ("curl --max-time 3 -T test_file ftp://ftp.uadreams.com --user ${USERNAME}:${PASSWORD}")
	   }
}
