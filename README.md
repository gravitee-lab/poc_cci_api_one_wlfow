# poc_cci_api_one_wlfow

A test to proove that using the Circle CI API v2 to trigger a Pipeline, and a Circle CI pipeline definition .circleci/config.yml including at least two workflows, one can run only one Pipeline's Workflow, using the Circle CI API v2.

### The pull Requests Bot

* The pull request bot will be triggered :
  * by any new pull request, on the source bracnh of the pull request
  * by any git pushed commit, on the source branch of any already existing pull request
* The pull request bot will not be triggered if the pipeline execution is triggered using the Circle Ci API v2, and providing the pipeline parameter `gio_action` has any of the enumeration values but the `pull_requests_bot` value.
* So the pull requests bot will then inspect the native Circle CI Env. Variables relative to pull requests, and :
  * if `gio_action` value is etiher of `product_release`, `lts_support_release`, or `sts_support_release`, then the pull requests bot is not triggered and only those
  * if `gio_action` value is `pull_requests_bot`, then :
    * the bot knows the trigger came either from the creation of a pull request, or a new commit on the source branch of an existing pull request.
    * the bot will then inspect the checked out git branch, and :
      * if the checked out git branch name `CIRCLE_BRANCH` starts with `support-`, then the bot will trigger again the pipeline, but this time with `gio_action` equals  `support_pr_review`, and on the source branch of the pull requests, which is exactly `CIRCLE_BRANCH`, like this :

```bash

```

      * if the checked out git branch name `CIRCLE_BRANCH` starts with `support-`, then the bot will trigger again the pipeline, but this time with `gio_action` equals  `dev_pr_review`, and on the source branch of the pull requests, which is exactly `CIRCLE_BRANCH`


enum: [product_release, lts_support_release, sts_support_release, dev_pr_review, support_pr_review, pull_requests_bot]

### Tested : A pipeline, configured to run _"Only on Pull Request"_

* Verified : Build Pull Request Only does trigger pipeline, from a git push, if a pull request is still open (so you cannot git push any commit after a pull request that is stil opened) :
* now let's trigger a pipeline :

```bash
export CCI_API_TOKEN='xxxxxxxxxxxxxxxxxxxxx'
export GIO_CICD_ACTION="empty_workflow"
export GIO_CICD_ACTION="product_release"
export GIO_CICD_ACTION="lts_support_release"
export GIO_CICD_ACTION="sts_support_release"
export GIO_CICD_ACTION="dev_pr_review"
export GIO_CICD_ACTION="support_pr_review"


export GIT_BRANCH="master"
export GIT_BRANCH="develop"
export GIT_BRANCH="3.0.x"
export GIT_BRANCH="3.8.x"
export GIT_BRANCH="issue-test-dev_pr_review-cci-workflow"

export PIPE_PARAMS="{ \"parameters\": { \"gio_action\": \"${GIO_CICD_ACTION}\", \"pull_req_bot_image_tag\": \"4.8.2\" }, \"branch\": \"${GIT_BRANCH}\" }"
export PIPE_PARAMS="{ \"parameters\": { \"gio_action\": \"${GIO_CICD_ACTION}\" }, \"branch\": \"${GIT_BRANCH}\" }"
export PIPE_PARAMS="{ \"parameters\": { \"gio_action\": \"${GIO_CICD_ACTION}\", \"pull_req_bot_image_tag\": \"78.25.46\" }, \"branch\": \"${GIT_BRANCH}\" }"

curl -d "${PIPE_PARAMS}" -X POST https://circleci.com/api/v2/project/gh/gravitee-lab/poc_cci_api_one_wlfow/pipeline -H 'Accept: application/json' -H 'Content-Type: application/json' -H "Circle-Token: ${CCI_API_TOKEN}" | jq .


```

All Circle CI native Env. Variables available in Pipelines : https://circleci.com/docs/2.0/env-vars/#built-in-environment-variables

### Triggering just one workflow of a given pipeline

* the page https://circleci.com/docs/2.0/api-job-trigger/ states :

>
>  It is possible to trigger workflows with the CircleCI API: a singular workflow can be re-run, or you may trigger a pipeline which will run its subsequent workflows.
>

So basically :

* You can re-run a workflow of a pipeline Definition
* You cannot run a workflow of a pipeline "for the first time".

So basically solution is to filter the desired workflow using bracnhes filter.


# Added feature

on a different branch, using the git flow


# Now

Adding a new commit on branch `3.0.x` after releasing `3.0.2` on `master` branch

Adding a new commit on branch [3.0.x] after releasing [3.0.2] on [master] branch


# Finally

Added to make a new commit on `3.0.x` branch, and send a pull request, to trigger pipeline, and execute only `dev-pr-workflow` Circle CI Pipeline Workflow defined in [`./.circleci/config.yml`]
