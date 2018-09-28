#!/usr/bin/groovy

@Library('eos-jenkins-shared') _

awsAccount = awsUtils.getAccount(ENV)
gitInfo = gitUtils.getInfo()
terraformRepo = "${gitInfo.url}/core_terraform.git"
repoBranch = params.branch
jenkinsCreds = gitInfo.jenkinsCreds

node(awsAccount.jenkinsNode) {
  try {
    wrap([$class: 'AnsiColorBuildWrapper', 'colorMapName': 'xterm']) {
      environment {
        ENV = "${ENV}"
      }
      stage('Checkout') {
        currentBuild.displayName = "#${env.BUILD_NUMBER}: ${env.JOB_NAME} - ${ENV}"
        deleteDir()
        complexCheckout('', terraformRepo, repoBranch, jenkinsCreds)
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
