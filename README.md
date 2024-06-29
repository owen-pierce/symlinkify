# symlinkify

A lightweight bash utility to create symlinks based on a given file of paths.


### Usage:

```
symlinkify

	-x - Used to set the prefix path of your path file. Default unset.
	-p - Used to set the path file name. Default "paths.txt".
	-d - Used to set the target output directory. "Default ~/symlinks"
```

Example usage:
```
./symlinkify.sh -x "/tools/" -p "custom_paths_name.txt" -d "/opt/symlinks"
```


Example "paths.txt" with prefix written in:
```
/tools/some_long_dir/important_tool/script.py
/tools/some_long_dir/important_tool2/script2.py
```
Ran with:
```
./symlinkify.sh -d "/target_output_dir/"
```

Example "paths.txt" with no prefix:
```
important_tool/script.py
important_tool2/script.py
```

Ran with:
```
./symlinkify.sh -d "/target_output_dir/" -x "/tools/some_long_dir/"
```

## Why?

I am a pentester and I have many tools that are on network share/local external storage so having a good way to quickly generate symlinks allows my tools to be portable and avoid having to install every tool on every system. Exporting your target directory to the PATH variable for instance allows you to quickly add a toolset to your working user.

