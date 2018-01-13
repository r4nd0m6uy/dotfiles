My dotfiles managed with [dotdrop](https://github.com/deadc0de6/dotdrop.git).

# Sudoers
Remember, some scripts require root permissions (sysfs). Here is what
sudo configuration might loook like:

```txt
random ALL=(ALL) NOPASSWD: /home/random/bin/backlight.sh
```

Alternatively (and much better), sysfs permission can be changed using
udev rules, so do it stupid!
