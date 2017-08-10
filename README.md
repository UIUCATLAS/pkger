# pkger

pkger creates a macOS installer file that executes a given script, and creates an install receipt.  Can be done on any OS since it's being run in a docker container.

## Requirements

Install docker.  Create your script.  Figure out what you want your installer version number and installs database receipt to be, e.g. in the below example, installer version = 1.0 and the database receipt=edu.illinois.atlas.demo.   

## Example usage

Create a script called `demo.sh`:

```
#!/bin/bash

say "ATLAS rocks!"
```

Execute

```
docker run --rm -v `pwd`:/data uiucatlas/pkger demo.sh edu.illinois.atlas.demo 1.0
```

This will create the installer package `demo.sh.pkg` in your current directory. That's it!
