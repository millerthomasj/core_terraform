#!/usr/bin/groovy

library "eos-jenkins-shared"

project = 'portals'
if (params.VPC) {
  project = 'eos'
}

terraformApply(env: params.env,
               project: project,
               branch: params.branch,
               repo: gitUtils.getInfo(project).url + '/core_terraform.git')
