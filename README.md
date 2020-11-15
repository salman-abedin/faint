# faint: Extensible TUI fuzzy file explorer

**faint** is a fuzzy file explorer for the CLI that supports scriptable operations & launch behaviors, Bookmarks and Icons & Emojis.

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

## Usage

### Commands

| Command        | Effect                         |
| -------------- | ------------------------------ |
| `faint`        | Explore current directory      |
| `faint <PATH>` | Explore specified directory    |
| `faint -l`     | Explore last visited directory |

### Default Bindings

| Key     | Effect                                             |
| ------- | -------------------------------------------------- |
| `;`     | Change directory forward / launch file             |
| `,`     | Change directory backward                          |
| `enter` | Drops down to shell on the current directory       |
| `esc`   | Clears the query / quits the program               |
| `]`     | Toggle mark down                                   |
| `[`     | Toggle mark up                                     |
| `\`     | Toggle mark All                                    |
| `space` | Pops open the operations menu for the marked files |
| `'`     | Browse bookmarks / Remove selected bookmark        |
| `"`     | Add current directory to bookmarks                 |
| `.`     | Toggle hidden files visual                         |
| `=`     | Increase max depth                                 |
| `-`     | Decrease max depth                                 |
| `_`     | Reset max depth                                    |
| `<`     | Refresh the list                                   |
| `tab`   | Navigate down                                      |
| `btab`  | Navigate up                                        |
| `:`     | Edit file using default editor                     |

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
