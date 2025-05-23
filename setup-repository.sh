#!/usr/bin/env bash

source ./utils.sh

## Apply the gitconfig configuration
#
git config --local include.path ../.gitconfig

positive "Repository should be set up for development"

