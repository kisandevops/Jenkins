# Jenkins

### How to get jenkins plugins list
```
Jenkins.instance.pluginManager.plugins.sort { it.getDisplayName() }.each{
  plugin -> 
    println ("${plugin.getDisplayName()} (${plugin.getShortName()}): ${plugin.getVersion()}")
}
```

```
Jenkins.instance.pluginManager.plugins.each{
  plugin -> 
    println ("${plugin.getDisplayName()} (${plugin.getShortName()}): ${plugin.getVersion()}")
}
```

```
Jenkins.instance.pluginManager.plugins.each{
  plugin -> 
    println ("${plugin.getShortName()}:${plugin.getVersion()}")
}
```
https://gist.github.com/noqcks/d2f2156c7ef8955619d45d1fe6daeaa9


### Jenkins Shared Lib Example
https://github.com/mkobit/jenkins-pipeline-shared-library-example
