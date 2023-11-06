# Building Application files 

This is a GitHub Actions workflow to create applications files for the deployment. These files are re-used in a later stage to build a container image. 

## Inputs
Within this workflow there are several input values. Most values are optional but some are required. These are also configurable.

```yaml
jobs:
  buildApplication:
    name: Build
    uses: ktijssen/global-actions/.github/workflows/build_application.yaml@v1
    secrets: inherit
    with:
      projectName: ${{ inputs.projectName }}
      buildType: 'npm'
      dockerfileName: 'Dockerfile.frontend'
      dockerSource: 'src/frontend'
      gitTag: ${{ inputs.gitTag }}
      npmCommands: 'npm ci,npm run test,npm run release'
      npmDistPath: 'src/frontend/dist'
      npmSource: 'src/frontend'
      preBuildApplicationScript: 'src/frontend/.pre-build-app.sh'
      teamName: ${{ inputs.teamName }}
```

|Input value|Description|Default values|Required|
|-|-|-|-|
|projectName|The name of the project you want to deploy|None|X|
|buildType|What kind of appliction do you want to build?. For example: If you want to build a nodejs appliction, you enter npm and for a simple container just enter container.|Possible values: maven, npm, maven-npm, container. Default: container||
|containerRegistry|URL of the container registry|registry.gdnnet.lan||
|dockerfileName|Name of the Dockerfile|Dockerfile||
|dockerSource|Location of the where the docker files are located|./||
|gitTag|The gitTag is used for versioning of all the files, builds and images. Also to keep record of the |None|X|
|mavenArgs|Option to pass additional maven argument|None||
|mavenTargetPath|Target location where maven stores his files during the build and will be stored as artifact|./target||
|npmCommands|Command to create a npm build|None||
|npmDistPath|Dist location where maven stores his files during the build and will be stored as artifact|./dist||
|npmSource|Location of the where the npm files are located|./||
|preBuildApplicationScript|Location of the where the pre-build script is located|./.pre-build-yaml.sh||
|preBuildApplicationScriptParams|Additional parametersfor  the pre-build script|None||
|skipBuild|Possibility to skip the build of the container image|false||
|skipSonar|Possibility to skip the Sonar quality check|false||
|teamName|The name of the team to which this project belongs|None||

## Environment Variables
These are the environment values. These are not configurable.

|Name|Description|Value|
|-|-|-|
|SONAR_HOST|URL of the SonarQube server|http://gdnsonar03.gdnnet.lan:9000|
|SONAR_LOGLEVEL|Log level of SonarQube|INFO|

## Jobs
