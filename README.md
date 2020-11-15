# faint: Extensible TUI fuzzy file explorer

**faint** is a fuzzy file explorer for the CLI that supports custom operations, custom launch behaviors, bookmarks and icons.

## Features

-  ### Fuzzy Finding, Depth Searching & Forward-Backward Navigation.

![](demo/navigation.gif)

-  ### Scriptable Launch Behaviors

![](demo/launching.gif)

-  ### Scriptable Operations

![](demo/operations.gif)

-  ### Filters & Icons

![](demo/filtering.gif)

-  ### Bookmarking

![](demo/bookmarks.gif)

## Dependencies

-  [fzf](https://github.com/junegunn/fzf)
-  `find, sort, sed & awk`

## Installation

```sh
git clone https://github.com/salman-abedin/faint.git && cd faint && sudo make install
```

## Commands

| Command        | Effect                         |
| -------------- | ------------------------------ |
| `faint`        | Explore current directory      |
| `faint <PATH>` | Explore specified directory    |
| `faint -l`     | Explore last visited directory |

## Default Bindings

### Navigation

| Key     | Effect                                       |
| ------- | -------------------------------------------- |
| `;`     | Changes directory forward / launch file      |
| `,`     | Changes directory backward                   |
| `enter` | Drops down to shell on the current directory |
| `esc`   | Clears the query / quits the program         |
| `tab`   | Navigates down                               |
| `btab`  | Navigates up                                 |

### Visual

| Key | Effect                      |
| --- | --------------------------- |
| `.` | Toggles hidden files visual |
| `=` | Increases max depth         |
| `-` | Decreases max depth         |
| `_` | Resets max depth            |
| `<` | Refreshes the list          |

### Operations

| Key     | Effect                                        |
| ------- | --------------------------------------------- |
| `]`     | Toggles mark down                             |
| `[`     | Toggles mark up                               |
| `\`     | Toggles mark All                              |
| `space` | Launches operations menu for the marked files |
| `:`     | Edits file using default editor               |

### Bookmarks

| Key | Effect                                               |
| --- | ---------------------------------------------------- |
| `'` | Launches bookmark browser / Remove selected bookmark |
| `"` | Adds current directory to bookmark list              |

### Modifications

-  Consult the `faint-config` for all your modifications need
-  `sudo make install` after making changes

## Update

```sh
cd faint
git pull rebase && sudo make install
```

## Uninstallation

```sh
cd faint
sudo make uninstall
```

---

## Shameful Plug

| Name                                                    | Description                     |
| ------------------------------------------------------- | ------------------------------- |
| [devour](https://github.com/salman-abedin/devour)       | X11 window swallower            |
| [bolt](https://github.com/salman-abedin/bolt)           | The launcher wrapper            |
| [uniblocks](https://github.com/salman-abedin/uniblocks) | The status bar wrapper          |
| [tide](https://github.com/salman-abedin/tide)           | Minimal Transmission CLI client |
| [puri](https://github.com/salman-abedin/puri)           | Minimal URL launcher            |
| [crystal](https://github.com/salman-abedin/crystal)     | The transparent setup           |
| [Magpie](https://github.com/salman-abedin/magpie)       | The dotfiles                    |
| [Alfred](https://github.com/salman-abedin/alfred)       | The scripts                     |

---

## Contact

SalmanAbedin@disroot.org
