#!/bin/bash

git fetch
git rebase origin/develop
git push -f origin HEAD
