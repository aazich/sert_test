
pipeline {

    triggers {
        cron('''0 1 * * *''')
    }

  options {
    disableConcurrentBuilds()
    copyArtifactPermission('backup-tests_pipeline')
    authorizationMatrix([
        'hudson.model.Item.Build:bocharov', 
        'hudson.model.Item.Build:sasha', 
        'hudson.model.Item.Discover:bocharov', 
        'hudson.model.Item.Discover:sasha', 
        'hudson.model.Item.Read:bocharov', 
        'hudson.model.Item.Read:sasha', 
    ])
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
       withCredentials([string(credentialsId: 'JENKINS_BOT_TOKEN', variable: 'TOKEN'), string(credentialsId: 'JENKINS_NOTIFY_TO_CHAT_ID', variable: 'CHAT_ID')]) {
             sh ("curl -s --header 'Content-Type: application/json' --request 'POST' --data '{\"chat_id\":\"${CHAT_ID}\",\"text\":\"success\n${env.BUILD_URL} has result success. ✅ \"}' 'https://api.telegram.org/bot${TOKEN}/sendMessage\'")
       }
   }
   failure {
       echo "${env.BUILD_URL} has result fail"
       withCredentials([string(credentialsId: 'JENKINS_BOT_TOKEN', variable: 'TOKEN'), string(credentialsId: 'JENKINS_NOTIFY_TO_CHAT_ID', variable: 'CHAT_ID')]) {
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
        sh "sudo ./checkCertsHTTP.sh www.uadreams.com cp.uadreams.com requestor.uadreams.com cpdev.uadreams.com testpma.uadreams.com redesign0.uadreams.com redesign.jenkins.testzone.uadreams.com api.uadreams.com api0.uadreams.com apidev.uadreams.com photo.uadreams.com upload.uadreams.com storage.uadreams.com v.uadreams.com vchat.uadreams.com git.uadreams.com zabbix.uadreams.com mail.uadreams.com jenkins.uadreams.com elk.uadreams.com backup.uadreams.com teampass.uadreams.com ldap.uadreams.com upload.uadreams.com photo.uadreams.com salon.uadreams.com uadreams.de www.uadreams.de v.uadreams.de storage.uadreams.de streams2.uadreams.com streams0.uadreams.com rabbitmq.uadreams.com dockerhub.uadreams.com redesigndocs.uadreams.com anyfortranslate.com brama.in.ua dreamsrun.com.cy fight-scam.com gris.kharkov.ua html-and-cms.com marriage-world.org russian-language-for-couples.com talkersite.com translaterun.com ua-brides.com uadatingreviews.com uadreams-frauds.com uadreamsfullinfo.com uadreams.mobi ua-dreams-review.com uadreams-review.com uadreamsreview.com uadreamsscam.com uadreamsscams.com uadreams-scams-complaints.com uagiftshop.com ua-scams.com"
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
        sh "sudo ./checkCertsSMTP.sh mx0.uadreams.com mx1.uadreams.com mx2.uadreams.com mx6.uadreams.com mx7.uadreams.com mx8.uadreams.com"
        cleanWs()

      }
    }
  }
  parallel builders
}


