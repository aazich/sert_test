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
                ftp_test()
                
            }
        }
    }

 
}

def ftp_test() {
	withCredentials([string(credentialsId: 'l_ftp', variable: 'USERNAME'), 
			 string(credentialsId: 'p_ftp', variable: 'PASSWORD'), 
			 string(credentialsId: 'ftp_server', variable: 'SERVER'), 
			 string(credentialsId: 'token', variable: 'TOKEN'), 
			 string(credentialsId: 'chat_id', variable: 'CHAT_ID')]){ 
                sh """  
dotest () {
dd if=/dev/urandom of=test_file bs=1 count=1024 &> /dev/null
curl --max-time 3 -T test_file ftp://${SERVER} --user ${USERNAME}:${PASSWORD}
}

dook () {
echo "ftp ok"
curl --request 'POST' 'https://api.telegram.org/bot${TOKEN}/sendMessage?chat_id=${CHAT_ID}&text=ftp ok ✅'
}

doerror () {
curl --request 'POST' 'https://api.telegram.org/bot${TOKEN}/sendMessage?chat_id=${CHAT_ID}&text=ftp error ❌'
}

dotest && dook || doerror
"""
 }
}
