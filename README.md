# poc_cci_api_one_wlfow

A test to proove that using the Circle CI API v2 to trigger a Pipeline, and a Circle CI pipeline definition .circleci/config.yml including at least two workflows, one can run only one Pipeline's Workflow, using the Circle CI API v2.



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
