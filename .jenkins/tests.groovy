#!/usr/bin/groovy

library "eos-jenkins-shared"

terraformPlans(branch: params.branch,
               repo: gitUtils.getInfo('portals').url + '/core_terraform.git')
