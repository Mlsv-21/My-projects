#!/bin/bash
#AUTHOR: Sujay Sharma
#DATE:07/12/2024
#VERSION:V1.0.0
#-------------------------------------------------------------------------------------------------------------------------------------------
#WORKING:This script list and Display all the users who have a permission to access the GitHub Repository
############################################################################################################################################
START WITH INPUT PARAMETERS
############################################################################################################################################
#git clone:path
#exprort user name="$USER NAME"
#export token="$GITHUB TOKEN"
#excecutable commands(./filename.sh organization name repository name)
#give permissions to .sh file to excecute 
############################################################################################################################################
#MAIN SCRIPT
############################################################################################################################################
# Function to make a GET request to the GitHub API
function github_api_get {
    local endpoint="$1"
    local url="${API_URL}/${endpoint}"

    # Send a GET request to the GitHub API with authentication
    curl -s -u "${USERNAME}:${TOKEN}" "$url"
}

# Function to list users with read access to the repository
function list_users_with_read_access {
    local endpoint="repos/${REPO_OWNER}/${REPO_NAME}/collaborators"

    # Fetch the list of collaborators on the repository
    collaborators="$(github_api_get "$endpoint" | jq -r '.[] | select(.permissions.pull == true) | .login')"

    # Display the list of collaborators with read access
    if [[ -z "$collaborators" ]]; then
        echo "No users with read access found for ${REPO_OWNER}/${REPO_NAME}."
    else
        echo "Users with read access to ${REPO_OWNER}/${REPO_NAME}:"
        echo "$collaborators"
    fi
}

# Main script

echo "Listing users with read access to ${REPO_OWNER}/${REPO_NAME}..."
list_users_with_read_access
