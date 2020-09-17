# poc_cci_api_one_wlfow

A test to proove that using the Circle CI API v2 to trigger a Pipeline, and a Circle CI pipeline definition .circleci/config.yml including at least two workflows, one can run only one Pipeline's Workflow, using the Circle CI API v2.

### Tested :

* Verified : Build Pull Request Only does trigger pipeline, from a git push, if a pull request is still open (so you cannot git push any commit after a pull request that is stil opened) :
* now let's trigger a pipeline :

```bash
export CCI_API_TOKEN='xxxxxxxxxxxxxxxxxxxxx'
export GIO_CICD_ACTION="product_release"
export GIO_CICD_ACTION="lts_support_release"
export GIO_CICD_ACTION="sts_support_release"
export GIO_CICD_ACTION="dev_pr_review"
export GIO_CICD_ACTION="support_pr_review"

export PIPE_PARAMS="{ \"parameters\": { \"gio_action\": \"${GIO_CICD_ACTION}\", \"pull_req_bot_image_tag\": \"4.8.2\" } }"
curl -d "${PIPE_PARAMS}" -X POST https://circleci.com/api/v2/project/gh/gravitee-lab/poc_cci_api_one_wlfow/pipeline -H 'Accept: application/json' -H "Circle-Token: ${CCI_API_KEY}" | jq .

```

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
