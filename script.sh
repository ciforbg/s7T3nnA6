#!/bin/bash

# Variables
CUSTOMTAG=$1

# Functions
function logger {
    printf "[$(date +"%Y-%d-%m %T")]: $*\n"
}

function usage {
    printf "\nUsage:\n\n"
    printf "$0\n\n" 
    printf "\tPush predefined set of tags to origin.\n\n"
    printf "$0 <tag>\n\n"
    printf "\tAlso push an additional tag. Only one tag is allowed.\n\n"
    exit 1
}

function main {

    if test -n "$(find .git/refs/heads -maxdepth 0 -empty)" ; then

        logger "[ERROR] This repository seems to be a fresh one, without any commits yet. Can't do tagging." && exit 1

    else

        TIMESTAMP=`date +"%Y-%d-%m-%H-%M-%S"`
        BRANCH="$(git branch -l|grep -e '^\*.*' | cut -d " " -f2)"

        if [ "${BRANCH}" == "master" ]; then
            if [ -z $CUSTOMTAG ]; then
                TAGS="${TIMESTAMP}"
            else
                TAGS="${TIMESTAMP} ${CUSTOMTAG}"
            fi
        else
            if [ -z $CUSTOMTAG ]; then
                TAGS="${TIMESTAMP} ${BRANCH}"
            else
                TAGS="${TIMESTAMP} ${BRANCH} ${CUSTOMTAG}"
            fi
        fi 

        for tag in ${TAGS[@]}
        do
          git tag "${tag}" >>/dev/null 2>&1
        done

        if ! git config remote.origin.url >>/dev/null 2>&1; then 
            logger "No remote origin is configured. Configure a remote origin if you want to be able to push the tags."
        else
            logger "Pushing the following tags to origin:"
            logger "${TAGS}"

            if ! git config branch.${BRANCH}.remote >>/dev/null 2>&1; then 
                git push --set-upstream origin "refs/heads/${BRANCH}" --tags
            else
                git push origin --tags
            fi
        fi

    fi
}

# Prechecks
[[ $# -gt 1 ]] && logger "[ERROR] Illegal number of arguments. Script aborted." && usage

# Main action
logger "Script is starting..."
main
if [ $? -eq 0 ]; then
    logger "Script completed."
else
    logger "Script completed with error."
fi