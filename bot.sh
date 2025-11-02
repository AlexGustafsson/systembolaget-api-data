#!/usr/bin/env bash

set -e

##
# Configuration
# Note: no trailing '/'
binary_repository="https://github.com/AlexGustafsson/systembolaget-api"
# Note: git URL allows for using SSH deploy keys
repository="git@github.com:AlexGustafsson/systembolaget-api-data.git"
binary_name="systembolaget"
# 0: error, 1: warn, 2: info, 3: debug
log_level=2
bot_name="Systembolaget API Bot"
commit_message="Update API data"
ssh_key="$SYSTEMBOLAGET_API_BOT_SSH_KEY"

function log {
  echo -ne "[$(date +"%b %d %H:%M:%S")] [$1] " >&2
  shift
  echo "$@" >&2
}

function log_error {
  if [ $log_level -ge 0 ]; then
    log "error" "$@"
  fi
}

function log_warning {
  if [ $log_level -ge 1 ]; then
    log "warning" "$@"
  fi
}

function log_info {
  if [ $log_level -ge 2 ]; then
    log "info " "$@"
  fi
}

function log_debug {
  if [ $log_level -ge 3 ]; then
    log "debug" "$@"
  fi
}

function git {
  echo "$@"
  log_debug "Executing git command: GIT_SSH_COMMAND=\"ssh -i $ssh_key -o IdentitiesOnly=yes\" git $*"
  GIT_SSH_COMMAND="ssh -i $ssh_key -o IdentitiesOnly=yes" command git "$@"
}

# Setup
function setup {
  # Let GitHub redirect to the latest available release
  latest_release="$(curl -Ls -o /dev/null -w "%{url_effective}" "$binary_repository/releases/latest/")"
  log_debug "Latest release is $latest_release"

  latest_tag="$(echo "$latest_release" | rev | cut -d/ -f1 | rev)"
  if [[ "$latest_tag" == "" ]]; then
    log_error "Unable to fetch the latest available tag. Download the binary manually from $binary_repository"
    exit 1
  fi

  log_debug "Latest available tag is $latest_tag"

  # Download the latest binary available
  case $(uname) in
  "Darwin")
    case $(uname -a) in
    *"x86_64"*)
      log_debug "Downloading Darwin x86_64 build"
      curl -sOL "$binary_repository/releases/download/$latest_tag/darwin_amd64.zip"
      log_debug "Downloaded build, unzipping"
      unzip darwin_amd64.zip
      log_debug "Unzipped build, removing archive"
      mv build/darwin_amd64 systembolaget
      rm -r build darwin_amd64.zip
      ;;
    *"arm"*)
      log_debug "Downloading Darwin arm build"
      curl -sOL "$binary_repository/releases/download/$latest_tag/darwin_arm64.zip"
      log_debug "Downloaded build, unzipping"
      unzip darwin_arm64.zip
      log_debug "Unzipped build, removing archive"
      mv build/darwin_arm64 systembolaget
      rm -r build darwin_arm64.zip
      ;;
    esac
    ;;
  "Linux")
    case $(uname -a) in
    *"x86_64"*)
      log_debug "Downloading Linux x86_64 build"
      curl -sOL "$binary_repository/releases/download/$latest_tag/linux_amd64.tgz"
      log_debug "Downloaded build, unzipping"
      tar -xzf linux_amd64.tgz
      log_debug "Unzipped build, removing archive"
      mv build/linux_amd64 systembolaget
      rm -r build linux_amd64.tgz
      ;;
    *"arm"*)
      log_debug "Downloading Linux arm build"
      curl -sOL "$binary_repository/releases/download/$latest_tag/linux_arm.tgz"
      log_debug "Downloaded build, unzipping"
      tar -xzf linux_arm64.tgz
      log_debug "Unzipped build, removing archive"
      mv build/linux_arm64 systembolaget
      rm -r build linux_arm64.tgz
      ;;
    esac
    ;;
  esac

  # Clone the repository to push to
  log_debug "Cloning $repository"
  git clone --depth=1 "$repository" repository
  if [[ ! $? -eq 0 ]]; then
    log_error "Unable to clone repository: $git_output"
    exit 1
  fi

  log_info "Setup is complete"
}

# Run the bot
function run {
  # Check if a key i specified
  if [[ "$ssh_key" = "" ]]; then
    log_error "No deploy key specified. Must be set in SYSTEMBOLAGET_API_BOT_SSH_KEY or as a parameter"
    print_help
    exit 1
  fi

  # Check if this is the first time running the bot
  if [ ! -e "$binary_name" ] || [ ! -d "./repository" ]; then
    log_info "First time running, will now run setup"
    setup
  fi

  # Update repository, forcing it to be equal to the remote
  log_debug "Updating repository"
  git_output="$(cd repository && git fetch && git reset --hard origin/main 2>&1)"
  if [[ $? -eq 0 ]]; then
    log_debug "$git_output"
  else
    log_error "Unable to update repository: $git_output"
    exit 1
  fi

  # Ensure target directories exist
  log_debug "Creating target directories"
  mkdir -p repository/data

  # Run binary
  log_info "Executing $binary_name"
  # Download
  "./$binary_name" --verbose assortment --page-delay 2s --output repository/data/assortment.json
  "./$binary_name" --verbose stores --output repository/data/stores.json
  log_debug "Download done"

  # Add all new items and commit as $bot_name
  log_debug "Commiting to repository as $bot_name"
  (cd "./repository" && git add .)
  (cd "./repository" && GIT_COMMITTER_NAME="$bot_name" GIT_COMMITTER_EMAIL="" git commit --author="$bot_name <>" -m "$commit_message" 2>&1)
  if [[ $? -eq 0 ]]; then
    log_info "Commited to repository"

    # Push
    log_debug "Pushing to remote repository"
    (cd "./repository" && git push)
  else
    if [[ "$(cd "./repository" && git status --short)" == "" ]]; then
      log_info "Nothing to commit - already up to date"
    else
      (cd "./repository" && git status)
      log_error "Failed to commit to repository"
      exit 1
    fi
  fi

  # Note: does not handle deep diffing of JSON, meaning that the file will be
  # replaced each time and not properly updated with only the changes
}

# Print the help text
function print_help {
  echo "Usage: $0 [--help] [--repository <url>]"
  echo "           [--binary <string>] [--log <error/warning/log/debug>]"
  echo "           [--binary-repository <url>] [--ssh-key <key>]"
  echo "           <help/cleanup/setup/run>"
}

# Cleanup after the bot
function cleanup {
  log_debug "Cleaning up directory"
  rm -rf "output" "repository" &>/dev/null
  log_debug "Cleanup done"
}

command="print_help"
help=false
while [ "$1" != "" ]; do
  case $1 in
  "--help" | "-h")
    help=true
    ;;
  "cleanup")
    command="cleanup"
    ;;
  "setup")
    command="setup"
    ;;
  "run")
    command="run"
    ;;
  "--repository")
    shift
    repository=$1
    ;;
  "--binary-repository")
    shift
    binary_repository=$1
    ;;
  "--binary")
    shift
    binary_name=$1
    ;;
  "--ssh-key")
    shift
    ssh_key="$1"
    ;;
  "--log")
    shift
    case $1 in
    "error")
      log_level=0
      ;;
    "warn")
      log_level=1
      ;;
    "info")
      log_level=2
      ;;
    "debug")
      log_level=3
      ;;
    esac
    ;;
  esac
  shift
done

if [[ "$help" == "true" ]]; then
  grep "$0" -e "function $command" -B1 | head -1 | cut -c 3-
else
  $command
fi
