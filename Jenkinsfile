pipeline {
    
     //triggers {
	//    cron('''*/5 * * * *''')
	  //}
    
    options {
	    disableConcurrentBuilds()
	  }
    
    agent { label 'master' }
	    stages {
	        stage('checkExpireCerts') {
	            parallel {
	                stage('checkExpireCerts_HTTP') {
	                    steps {
	                        checkExpireCerts_HTTP_Task01()
	                    }
	                }
	                stage('checkExpireCerts_SMTP') {
	                    steps {
	                        checkExpireCerts_SMTP_Task02()
	                    }
	                }
	
	
	
	
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

def checkExpireCerts_HTTP_Task01() {
	  def labels = ['testzone01']
	  def builders = [: ]
	  for (x in labels) {
	    def label = x
	
	    builders[label] = {
	      node(label) {
	
	        cleanWs()
	        checkout scm
	        sh "chmod +x ./checkCertsHTTP.sh ./checkCertsSMTP.sh"
	        sh "sudo ./checkCertsHTTP.sh www.uadreams.com cp.uadreams.com requestor.uadreams.com"
	        cleanWs()
	
	      }
	    }
	  }
	  parallel builders
	}
	
	
	def checkExpireCerts_SMTP_Task02() {
	  def labels = ['testzone01']
	  def builders = [: ]
	  for (x in labels) {
	    def label = x
	
	    builders[label] = {
	      node(label) {
	
	        cleanWs()
	        checkout scm
	        sh "chmod +x ./checkCertsHTTP.sh ./checkCertsSMTP.sh"
	        sh "sudo ./checkCertsSMTP.sh mx0.uadreams.com mx1.uadreams.com"
	        cleanWs()
	
	      }
	    }
	  }
	  parallel builders
	}
	
