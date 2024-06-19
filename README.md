# Personal Dotfile Configurations

This projects uses stow

## Dependencies

Git and Stow

## Installing

```
brew install stow git
git submodule update --init --recursive
```

## Notes

Ensure that the file structure is the same as the HOME

Run the following:
```
stow .
```
or
```
stow --adopt .
```


## Using tmux

```
tmux new -s <SessionName>
```

```
tmux ls
tmux attach <SessionName>
tmux a
tmux detach
```

Click PREFIX-I to install tmux plugins

