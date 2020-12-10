# faint: Extensible TUI fuzzy file explorer

**faint** is a fuzzy file explorer for the CLI that supports various extensible features.

## Features

-  ### Fuzzy Finding & Depth Searching.

![](https://gitlab.com/salman-abedin/assets/-/raw/master/faint-fuzzy.gif)

-  ### Custom Operations

![](https://gitlab.com/salman-abedin/assets/-/raw/master/faint-op.gif)

-  ### Custom Launch Behaviors

![](https://gitlab.com/salman-abedin/assets/-/raw/master/faint-launch.gif)

-  ### Filters

![](https://gitlab.com/salman-abedin/assets/-/raw/master/faint-filters.gif)

-  ### Bookmarking

![](https://gitlab.com/salman-abedin/assets/-/raw/master/faint-bookmark.gif)

-  ### Multiple Instances

![](https://gitlab.com/salman-abedin/assets/-/raw/master/faint-multi.gif)

## Dependencies

-  [fzf](https://github.com/junegunn/fzf)
-  `find, sort, sed, pkill & awk`
-  `setsid` (Optional; For better launching experience)
-  [hulk](https://github.com/salman-abedin/alfred/blob/master/src/hulk) (Optional; For bulk moving/renaming)

## Installation

#### Git

```sh
git clone https://github.com/salman-abedin/faint.git && cd faint && make && sudo make install
```

#### AUR

```sh
yay -S --noconfirm faint
# Or
yay -S --noconfirm faint-git # Nightly
```

## Commands

| Command        | Effect                         |
| -------------- | ------------------------------ |
| `faint`        | Explore current directory      |
| `faint <PATH>` | Explore specified directory    |
| `faint -l`     | Explore last visited directory |

## Default Bindings

### Navigation

| Key     | Effect                                                    |
| ------- | --------------------------------------------------------- |
| `;`     | `cd` into directory/launch file + resets query & position |
| `:`     | Launches file without resetting the query & position      |
| `,`     | Changes directory backward                                |
| `enter` | Drops down to shell on the current directory              |
| `esc`   | Clears the query / quits the program                      |
| `tab`   | Navigates down                                            |
| `btab`  | Navigates up                                              |

### List

| Key | Effect                        |
| --- | ----------------------------- |
| `.` | Toggles filtered files visual |
| `>` | Toggles hidden files visual   |
| `=` | Increases max depth           |
| `-` | Decreases max depth           |
| `_` | Resets max depth              |
| `<` | Refreshes the list            |

### Operations

| Key     | Effect                                        |
| ------- | --------------------------------------------- |
| `]`     | Toggles mark down                             |
| `[`     | Toggles mark up                               |
| `\`     | Toggles mark All                              |
| `space` | Launches operations menu for the marked files |

### Bookmarks

| Key | Effect                                               |
| --- | ---------------------------------------------------- |
| `'` | Launches bookmark browser / Remove selected bookmark |
| `"` | Adds current directory to bookmark list              |

### Modifications

-  Consult the `~/.config/faintrc` for all your modifications need

## Update

#### Git

```sh
cd faint
git pull rebase && sudo make install
```

#### AUR

```sh
yay -Syu --noconfirm
```

## Uninstallation

```sh
cd faint
sudo make uninstall
```

## Contributors

-  [orhun](https://github.com/orhun) ( AUR package maintainer)
-  [NICHOLAS85](https://github.com/NICHOLAS85)

---

## Shameful Plug

| Name                                                    | Description                     |
| ------------------------------------------------------- | ------------------------------- |
| [devour](https://github.com/salman-abedin/devour)       | X11 window swallower            |
| [bolt](https://github.com/salman-abedin/bolt)           | The launcher wrapper            |
| [uniblocks](https://github.com/salman-abedin/uniblocks) | The status bar wrapper          |
| [tide](https://github.com/salman-abedin/tide)           | Minimal Transmission CLI client |
| [puri](https://github.com/salman-abedin/puri)           | Minimal URL launcher            |
| [Magpie](https://github.com/salman-abedin/magpie)       | The dotfiles                    |
| [Alfred](https://github.com/salman-abedin/alfred)       | The scripts                     |

---

## Contact

SalmanAbedin@disroot.org
