#!/bin/bash

PARAM_STR_ACCOUNT_ID=$(circleci env subst "${PARAM_STR_ACCOUNT_ID}")
PARAM_STR_REGION=$(circleci env subst "${PARAM_STR_REGION}")
PARAM_STR_REPO_NAME=$(circleci env subst "${PARAM_STR_REPO_NAME}")
PARAM_STR_TAGS=$(circleci env subst "${PARAM_STR_TAGS}")

FIRST_TAG="${PARAM_STR_TAGS%%,*}"
IMAGE_NAME_WITH_TAG="${PARAM_STR_ACCOUNT_ID}.dkr.ecr.\
${PARAM_STR_REGION}.amazonaws.com/\
${PARAM_STR_REPO_NAME}:${FIRST_TAG}"

echo "Exporting '${IMAGE_NAME_WITH_TAG}' as the 'BUILD_IMAGE_NAME_WITH_TAG'"

echo "export BUILD_IMAGE_NAME_WITH_TAG='${IMAGE_NAME_WITH_TAG}'" >>"${BASH_ENV}"
