# symlinkify

A lightweight bash utility to create symlinks based on a given file of paths.


### Usage:

```
symlinkify

	-x - Used to set the prefix path of your path file. Default unset.
	-p - Used to set the path file name. Default "paths.txt".
	-d - Used to set the target output directory. "Default ~/symlinks"
```

## Why?

I am a pentester and I have many tools that are on network share/local external storage so having a good way to quickly generate symlinks allows my tools to be portable and avoid having to install every tool on every system. Exporting your target directory to the PATH variable for instance allows you to quickly add a toolset to your working user.

