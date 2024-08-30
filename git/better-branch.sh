#!/bin/bash

git for-each-ref --color --sort=-committerdate --format=$'%(color:red)%(ahead-behind:HEAD)\t%(color:blue)%(refname:short)\t%(color:yellow)%(committerdate:relative)\t%(color:default)%(describe)' refs/heads/ | \
    sed 's/ /\t/' | \
    column --separator=$'\t' --table --table-columns='Ahead,Behind,Branch Name,Last Commit'

