# Jenkins

### How to get jenkins plugins list
```
Jenkins.instance.pluginManager.plugins.sort { it.getDisplayName() }.each{
  plugin -> 
    println ("${plugin.getDisplayName()} (${plugin.getShortName()}): ${plugin.getVersion()}")
}
```
