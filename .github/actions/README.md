# Clean GitHub Action Workspace folder
Simple remove all files from the _work directory

## Description
When a checkout action is performed on a runner, the original files aren't deleted.
This could intervene with some actions in the next steps.

The action will remove all the file created by previous steps and will make sure that the _work folder is empty

## Usage
```
name: Build with Clean

on:
  push:
    branches: [ "main" ]

jobs:
  build:
    runs-on: self-hosted
    steps:
      - name: Clean Working dir
        uses: ktijssen/global-actions/actions/cleanup-workspace@crystal
      - name: Checkout Project Repo
        uses: actions/checkout@v3
      - run: echo Hello World
```
