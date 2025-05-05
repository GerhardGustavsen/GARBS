# Gerhard's Auto-Rice Bootstrapping Script (GARBS)

## Installation:

On an Arch-based distribution as root, run the following:

```
curl -LO https://raw.githubusercontent.com/GerhardGustavsen/GARBS/master/garbs.sh
sh garbs.sh
```

That's it.

## What is GARBS?

GARBS is a fork of LARBS that autoinstalls and configures a minimal,
efficient Arch Linux desktop using XFCE as a base environment,
with optional tiling WM enhancements and privacy-conscious settings.

GARBS is designed for users who want a practical, hardware-compatible system
with minimal bloat and maximum control, built from curated packages and
tested configurations.

It supports both fresh Arch and Artix installs.

## Customization

By default, GARBS uses the programs listed in [progs.csv](progs/progs.csv) and installs
[Gerhard's dotfiles](https://github.com/GerhardGustavsen/dotfiles),
but you can customize it by editing the variables at the top of the script or by using these options:

- `-r`: custom dotfiles repository (URL)
- `-p`: custom programs list/dependencies (local file or URL)
- `-a`: a custom AUR helper (must be able to install with `-S` unless you
  change the relevant line in the script)

### The `progs.csv` list

GARBS reads this CSV to determine what to install. It must have three columns:

1. **Tag**: install method
   - `""` (blank) for `pacman`
   - `A` for `yay`/AUR packages
   - `G` for `git` repositories (compiled with `make`)
   - `P` for `pip` packages (Python)
2. **Program**: name in repo, AUR name, or git URL
Descriptions must be quoted if they contain commas.

Depending on your own build, you may want to tactically order the programs in
your programs file. GARBS will install from the top to the bottom.

### The script itself

The script is extensively divided into functions for easier readability and
trouble-shooting. Most everything should be self-explanatory.

The main work is done by the `installationloop` function, which iterates
through the programs file and determines based on the tag of each program,
which commands to run to install it. You can easily add new methods of
installations and tags as well.

Note that programs from the AUR can only be built by a non-root user. What
GARBS does to bypass this by default is to temporarily allow the newly created
user to use `sudo` without a password (so the user won't be prompted for a
password multiple times in installation). This is done ad-hocly, but
effectively with the `newperms` function. At the end of installation,
`newperms` removes those settings, giving the user the ability to run only
several basic sudo commands without a password (`shutdown`, `reboot`,
`pacman -Syu`).
