#!/usr/bin/groovy

library 'portals-shared-library'

terraformUtils.apply(env: params.env,
                     repo: gitUtils.getInfo('portals').url + '/core_terraform.git',
                     branch: params.branch)
