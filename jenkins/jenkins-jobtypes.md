When creating a "new item", there are different types of "items", also referred to as "jobs", that can be created in Jenkins:

## 1) Freestyle project
This is a central feature of Jenkins. It will build the project, combine SCM with the build system. It can
also be used for things other than building applications.

## 2) Pipeline
This is used to create a pipeline

## 3) Multi-configuration project
This is great if you need a large number of Jenkins configurations if you need multiple environments
like Dev/ UAT, this could even be good for multi-stage pipelines

## 4) Folder
This creates containers and stores nested items inside of it
It is useful in grouping different projects together, also filter them, or creating a namespace, etc.

## 5) Organisation folder
Creates a multibranch project for all different subfolders that are available.

## 6) Multibranch Pipeline
It sets up a pipeline project for different repositories.
