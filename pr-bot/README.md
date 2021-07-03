# How to run the bot in a Circle CI Pipline


```bash
# --- #

```


```Yaml
# Machine executor, set the machine key to true in .circleci/config.yml:
version: 2.1

parameters:
  gio_action:
    type: enum
    enum: [product_release, lts_support_release, sts_support_release, dev_pr_review, support_pr_review, pull_requests_bot]
    # the [default:] clause is required : without it, a Circle CI error will occur
    # default: none
    # the [default:] clause must have a valid value : without a valid value, a Circle CI error will occur
    default: pull_requests_bot
  pull_req_bot_image_tag:
    type: string
    default: 'stable-latest' # stable -latest is not understood by docker, as "latest" of all tags. So we will use this docker tag to automatically updae / upgrade the Pull Request Bot
    # default: '3.0.76' # we dpo not use explicit version number for docker tag, for us not to be doomed to update a lot of [.circleci/config.yml]
    # default : 'latest' # we never ever use 'latest', but stable-latest
  is_triggered_from_pr:
    type: boolean
    default: true
orbs:
  secrethub: secrethub/cli@1.0.0
jobs:

  pull_requests_bot_exec:
    machine:
      image: 'ubuntu-1604:201903-01'    # recommended linux image - includes Ubuntu 16.04, docker 18.09.3, docker-compose 1.23.1
      # resource_class: medium
      # docker_layer_caching: true    # default - false # requires a Circle CI plan that includes [Docker layer caching feature]
    environment:
      PIPELINE_PARAM_GIO_ACTION: << pipeline.parameters.gio_action >>
      PIPELINE_PARAM_PR_BOT_IMAGE_TAG: << pipeline.parameters.pull_req_bot_image_tag >>
      PIPELINE_PARAM_IS_TRIGGERED_FROM_PR: << pipeline.parameters.is_triggered_from_pr >>
    steps:
      - checkout
      - secrethub/install
      - run:
          name: "Running Pull Request Bot"
          command: |
                   echo "This job will run the pull request bot, in its docker image "
                   docker pull quay.io/gravitee-lab/pull-request-bot:${PIPELINE_PARAM_PR_BOT_IMAGE_TAG}
                   echo "PIPELINE_PARAM_GIO_ACTION=${PIPELINE_PARAM_GIO_ACTION}" | tee -a ./env.list
                   echo "PIPELINE_PARAM_PR_BOT_IMAGE_TAG=${PIPELINE_PARAM_PR_BOT_IMAGE_TAG}" | tee -a ./env.list
                   echo "PIPELINE_PARAM_IS_TRIGGERED_FROM_PR=${PIPELINE_PARAM_IS_TRIGGERED_FROM_PR}" | tee -a ./env.list
                   echo "CIRCLE_PULL_REQUEST=${CIRCLE_PULL_REQUEST}" | tee -a ./env.list
                   echo "CIRCLE_PULL_REQUESTS=${CIRCLE_PULL_REQUESTS}" | tee -a ./env.list
                   echo "CIRCLE_PR_NUMBER=${CIRCLE_PR_NUMBER}" | tee -a ./env.list
                   echo "CIRCLE_PR_REPONAME=${CIRCLE_PR_REPONAME}" | tee -a ./env.list
                   echo "CIRCLE_PR_USERNAME=${CIRCLE_PR_USERNAME}" | tee -a ./env.list
                   echo "CIRCLE_BRANCH=${CIRCLE_BRANCH}" | tee -a ./env.list
                   echo "CIRCLE_SHA1=${CIRCLE_SHA1}" | tee -a ./env.list
                   # echo "CCC=${CCC}" | tee -a ./env.list
                   docker run -it --rm --env-file ./env.list -v "$PWD":/bot-arena/cci/pipeline quay.io/gravitee-lab/pull-request-bot:${PIPELINE_PARAM_PR_BOT_IMAGE_TAG}
```
