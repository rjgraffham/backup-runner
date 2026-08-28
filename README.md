# rsync.net backup runner

The rsync.net backup runner for my kubernetes cluster. Image is prebuilt with rsync and ssh installed as they are required, and preloads:

- an exclude list so that it doesn't have to be specified directly in the command
- an ssh `known_hosts` file which already records the expected host key of my rsync.net storage, so it does not have to be interactively accepted (and will fail if the host key changes unexpectedly)
