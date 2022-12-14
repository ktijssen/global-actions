#!/bin/bash


# Get the latest tag of the repo
CURRENT_TAG=$(git tag --sort=committerdate | tail -1)

# Check if the brach is 'main' or 'master'
if [ ${GITHUB_REF_NAME} == "main" ] || [ ${GITHUB_REF_NAME} == "master" ]; then

    # Get the SHA commmit of the latest tag
    SHA_CURRENT_TAG=$(git rev-parse ${CURRENT_TAG})

    # Split up tag in seperated bits
    TAG_BITS=(${CURRENT_TAG//./ })
    TAG_BIT1=${TAG_BITS[0]}
    TAG_BIT2=${TAG_BITS[1]}
    TAG_BIT3=${TAG_BITS[2]}

    # Check if 'major', 'minor' or 'patch' needs to increment
    if [ "${MAJOR}" -gt "${TAG_BIT1}" ]; then
        TAG_BIT1=${MAJOR}
        TAG_BIT2=0
        TAG_BIT3=0
        NEW_GIT_TAG="${TAG_BIT1}.${TAG_BIT2}.${TAG_BIT3}"
    elif [ "${MINOR}" -gt "${TAG_BIT2}" ]; then
        TAG_BIT2=${MINOR}
        TAG_BIT3=0
        NEW_GIT_TAG="${TAG_BIT1}.${TAG_BIT2}.${TAG_BIT3}"
    else
        TAG_BIT1=${MAJOR}
        TAG_BIT2=${MINOR}
        TAG_BIT3=$((TAG_BIT3+1))
        NEW_GIT_TAG="${TAG_BIT1}.${TAG_BIT2}.${TAG_BIT3}"
    fi

    # Get the current SHA commit
    GIT_COMMIT=$(git rev-parse HEAD)

    # Check if the latest commit is already tagged
    if [ ${GIT_COMMIT} != ${SHA_CURRENT_TAG} ]; then
        git tag $NEW_GIT_TAG
        git push --tags
    else
        echo "Already a tag on this commit"
    fi

    # Export the tag to GitHub Outputs for later usages
    echo "git_tag=$(echo ${NEW_GIT_TAG})" >> $GITHUB_OUTPUT

else
    # Get the latest SHA commit
    GITHUB_SHA_SHORT=$(git rev-parse --short HEAD)

    # Export the PR-tag to GitHub Outputs for later usages
    echo "${CURRENT_TAG}-PR-${GITHUB_SHA_SHORT}" >> git_tag.file
fi