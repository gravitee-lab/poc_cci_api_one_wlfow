#!/bin/bash

export PIPELINE_PARAM_GIO_ACTION=${PIPELINE_PARAM_GIO_ACTION}
export PIPELINE_PARAM_PR_BOT_IMAGE_TAG=${PIPELINE_PARAM_PR_BOT_IMAGE_TAG}
export PIPELINE_PARAM_IS_TRIGGERED_FROM_PR=${PIPELINE_PARAM_IS_TRIGGERED_FROM_PR}
export CIRCLE_PULL_REQUEST=${CIRCLE_PULL_REQUEST}
export CIRCLE_PULL_REQUESTS=${CIRCLE_PULL_REQUESTS}
export CIRCLE_PR_NUMBER=${CIRCLE_PR_NUMBER}
export CIRCLE_PR_REPONAME=${CIRCLE_PR_REPONAME}
export CIRCLE_PR_USERNAME=${CIRCLE_PR_USERNAME}
export CIRCLE_BRANCH=${CIRCLE_BRANCH}
export CIRCLE_SHA1=${CIRCLE_SHA1}