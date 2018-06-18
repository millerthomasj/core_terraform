#!groovy

@Library('eos-jenkins-shared') _
def jenkinsCreds = 'a20a062d-348a-4d9b-8db8-458cc76acf16'

node("portals-${ENV}-slave") {
  try {
    wrap([$class: 'AnsiColorBuildWrapper', 'colorMapName': 'xterm']) {
      environment {
        ENV = '${ENV}'
      }
      stage('Checkout') {
        currentBuild.displayName = "#${env.BUILD_NUMBER}: ${env.JOB_NAME} - ${ENV}"
        deleteDir()
        complexCheckout('', 'https://stash.dev-charter.net/stash/scm/portals/core_terraform.git', params.branch, jenkinsCreds)
      }
      stage('Make Clean') {
        sh "make clean"
      }
      stage('Make Plan') {
        sh "make plan"
      }
      if(params.branch == 'master') {
        stage('Make Apply') {
          timeout(time: 10, unit: 'MINUTES') {
              input 'Is the terraform plan reasonable?'
          }
          sh "make apply"
        }
      }
    }
  } catch (e) {
    currentBuild.result = "FAILED"
    throw e
  } finally {
    if (params.branch == 'master') {
      slackNotification(currentBuild.result, '#eos_devops', '#eos_jenkins', ENV)
    }
  }
}