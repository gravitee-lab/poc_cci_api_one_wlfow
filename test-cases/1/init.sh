#!/bin/bash

export COMMIT_MESSAGE="initializing test case"
# retour à la branche sur laquelle je rédige cette doc
export WORK_BRANCH=issue-test-dev_pr_review-cci-workflow
git checkout ${WORK_BRANCH}



# -- #

# -- run

git branch -D support-one-testcase1
git push -u origin --delete support-one-testcase1

git branch -D issue-one-testcase1
git push -u origin --delete issue-one-testcase1

git branch -D issue-two-testcase1
git push -u origin --delete issue-two-testcase1

git branch -D support-two-testcase1
git push -u origin --delete support-two-testcase1

git branch -D issue-three-testcase1
git push -u origin --delete issue-three-testcase1

git branch -D issue-four-testcase1
git push -u origin --delete issue-four-testcase1

git checkout 3.0.x
git checkout -b support-one-testcase1
echo "pushing a commit on branch [support-one-testcase1]" >> README.support-one-testcase1.md
git add --all && git commit -m "${COMMIT_MESSAGE}" && git push -u origin HEAD

git checkout 3.0.x
git checkout -b issue-one-testcase1
echo "pushing a commit on branch [issue-one-testcase1]" >> README.issue-one-testcase1.md
git add --all && git commit -m "${COMMIT_MESSAGE}" && git push -u origin HEAD

git checkout 3.0.x
git checkout -b issue-two-testcase1
echo "pushing a commit on branch [issue-two-testcase1]" >> README.issue-two-testcase1.md
git add --all && git commit -m "${COMMIT_MESSAGE}" && git push -u origin HEAD

git checkout 3.0.x
echo "[3.0.x] branch is ready : pushing another commit on branch [3.0.x] to make a beautiful git graph" >> README.3.0.x.md
git add --all && git commit -m "${COMMIT_MESSAGE}" && git push -u origin HEAD

# --- #

git checkout 3.8.x
git checkout -b support-two-testcase1
echo "pushing a commit on branch [support-two-testcase1]" >> README.support-two-testcase1.md
git add --all && git commit -m "${COMMIT_MESSAGE}" && git push -u origin HEAD

git checkout 3.8.x
git checkout -b issue-three-testcase1
echo "pushing a commit on branch [issue-three-testcase1]" >> README.issue-three-testcase1.md
git add --all && git commit -m "${COMMIT_MESSAGE}" && git push -u origin HEAD

git checkout 3.8.x
git checkout -b issue-four-testcase1
echo "pushing a commit on branch [issue-four-testcase1]" >> README.issue-four-testcase1.md
git add --all && git commit -m "${COMMIT_MESSAGE}" && git push -u origin HEAD

git checkout 3.8.x
echo "[3.0.x] branch is ready : pushing another commit on branch [3.0.x] to make a beautiful git graph" >> README.3.0.x.md
git add --all && git commit -m "${COMMIT_MESSAGE}" && git push -u origin HEAD


git checkout ${WORK_BRANCH}
