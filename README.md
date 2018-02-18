# Stupid simple image renamer for personal use

Just a little script hacked together for copying images in folders like
YYYY/MM/DD. 

# Invocation

image-sorter sourcefolder destinationfolder

# Installation (nix/nixos)

```bash
nix-env -f shell.nix -i
```

# Limitiations:

- It does not handle subfolders in the source folder
- If you invoke it wrongly, it will just crash
- I completely ignored performance or coding style/elegance.


