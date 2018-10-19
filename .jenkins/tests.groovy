#!/usr/bin/groovy

library "eos-jenkins-shared"

gitRepo = gitUtils.getInfo('portals').url + '/core_terraform.git'
repoBranch = params.branch
jenkinsCreds = gitUtils.getInfo('portals').jenkinsCreds

testEnvironments = [ 'dev', 'uat', 'qa', 'engprod' ]

node(awsUtils.getAccounts().jenkinsNode) {
  try {
    // notify bitbucket that testing has started
    bitbucketUtils.notify("INPROGRESS")

    wrap([$class: 'AnsiColorBuildWrapper', 'colorMapName': 'xterm']) {
      stage('Checkout') {
        currentBuild.displayName = "#${env.BUILD_NUMBER}: ${env.JOB_NAME} - ${repoBranch}"
        deleteDir()
        complexCheckout('', gitRepo, repoBranch, jenkinsCreds)

        stash name: 'contents', includes: '**/*'
      }
      stage('Run Plans') {
        def plans = [:]

        testEnvironments.each {
          def environment = "${it}"

          plans["${environment}Plan"] = {
            node(awsUtils.getAccount(environment).jenkinsNode) {
              unstash 'contents'
              sh "make clean -e ENV=${environment}"
              sh "make plan -e ENV=${environment}"
            }
          }
        }
        parallel plans
      }
    }
  } catch (e) {
    // notify that testing has failed
    bitbucketUtils.notify("FAILED")
    throw e
  } finally {
    if (currentBuild.currentResult == "SUCCESS") {
      // notify that testing has finished
      bitbucketUtils.notify("SUCCESS")
    }
    slackNotification(currentBuild.result, '#eos_devops', '#eos_jenkins', repoBranch)
  }
}
