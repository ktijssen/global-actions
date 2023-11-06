# Building Manifest files 

This is a GitHub Actions workflow to create Kubernetes/OpenShift manifests files for the deployment. These files are re-used in a later stage to deploy our services. 

## Inputs

```yaml
buildManifests:
name: Build
uses: ktijssen/global-actions/.github/workflows/build_manifests.yaml@v1
secrets: inherit
with:
    projectName: ${{ inputs.projectName }}
    buildType: kustomize
    gitTag: ${{ inputs.gitTag }}
    helmVersion
    manifestSource: 'src/frontend/kubernetes'
    preBuildManifestScript: 'src/frontend/.pre-build-yaml.sh'
    teamName: ${{ inputs.teamName }}
```

|Input value|Description|Default values|Required|
|-|-|-|-|
|projectName|The name of the project you want to deploy|None|X|
|buildType|What kind of build you want to do|Possible values: helm or kustomize. Default kustomize||
|containerRegistry|URL of the container registry|registry.gdnnet.lan||
|gitTag|The gitTag is used for versioning of all the files, builds and images. Also to keep record of the |None|X|
|helmVersion|The version of the helm chart you want to use|1.0.0||
|manifestSource|Location of the where the manifest files are located|./kubernetes||
|preBuildManifestScript|Location of the where the pre-build script is located|./.pre-build-yaml.sh||
|teamName|The name of the team to which this project belongs|None||
