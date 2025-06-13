# Cheat Sheets

My cheat sheets. Some shortcuts may depend on local dotfiles/config.

## Vim

`<leader>` is `\` by default, or `,` if you like convenience.

When browsing `:help`, use `<ctrl>]` to follow link under cursor.

### Movement/selection

- `$`: EOL.
- `0`: Beginning of line.
- `^`: First non-whitespace character (e.g `d^` deletes from cursor to indentation).
- `b`: Go back one word.
- `{`/`}`: Move up/down a paragraph.
- `<ctrl>e/y`: Move screen down/up one line without moving cursor.
- `<ctrl>u/d`: Scroll half screen up/down, or prefix _n_ lines.
- `zt` / `zb`: Move current line to top/bottom of screen.
- `v/<term>`: Mark forward from cursor to `<term>`.
- `v?<term>`: Mark backward from cursor to `<term>`.
- `'[a-z]`: Go to mark a-z, set by `m[a-z]`.
- `v'[a-z]`: Select from cursor to mark a-z.
- `:g/expr/y A`: Yank all lines matching expr into register a. (May need to
  first empty it, e.g. by recording an empty macro: `qaq`.)
- `gg<cmd>G`: Apply `<cmd>` to entire buffer.
- `:jumps`
    - `<ctrl>o`: Go back to previous location in jumplist.
    - `<ctrl>i`: Go forward to next location in jumplist.
- ``.`: Go to location of last change (using `:marks`).
- `gi`: Insert text in the same position where Insert mode was last stopped.

### Text objects

- `<cmd>i<object-range>`: Apply `<cmd>` inside `<object-range>`.
- `<cmd>a<object-range>`: Apply `<cmd>` around `<object-range>`.

Some useful object ranges:

- `w`/`s`/`p`: Word/sentence/paragraph.
- `"`/`'`: A quoted string. `quoteescape` option is used to skip escaped quotes.
- `(`/`)`/`[`/`]`/`{`/`}`.
- `i`: Indentation level, with `vim-indent-object`.

Examples:

- `ciw`: Replace entire word without needing to put cursor on first character.
- `yi"`: Yank text inside quotes.
- `di(`: Delete everything inside parens, leaving the paren itself in place.
- `ca[`: Change everthing inside square bracket, including the bracket itself.
- `vai`: Visually select current indentation level, including the line above.
- `vii`: Visually select current indentation level, excluding the line above.

### Macros

- `q<char>`: Start recording to register `<char>`. `q` again to stop recording.
- `@<char>`: Play macro `<char>.` Can be preceded by number.
- `:%norm! @m`: Apply macro `m` to every line of file.

### quickfix/vimgrep:

- `:vimgrep <p> **`: Grep recursively for `<p>` and put results in quickfix list
- `:copen`: Open quickfix window.
- `vim -q <file>`: Read `<file>` into quickfix buffer. It expects results to be
  formatted as `<filepath>:<lineno>:<msg>`, e.g. output of `grep -Hn <...>`.

### Misc

- `:new`: New `[No Name]` buffer.
- `:!r <cmd>`: Read output of `<cmd>` into current buffer.
- `:new|r! <cmd>`: Read output of `<cmd>` into new buffer (also works with
  `tabnew`).
- `:!rm %`: Delete file for current buffer.
- `S`: Delete line and put in insert mode, at the right indentation level.
- `g~iw`: Toggle case of word under cursor.
- `gUw`: Uppercase from cursor end of current word.

### Split navigation

- `<ctrl>h/j/k/l`: Also works for navigating to/from tmux panes.
- `<ctrl>w r`: Rotate splits.
- `<ctrl>w =`: Resize splits to be equal.
- `<ctrl>w T`: Make current split a new tab.

### File navigation
- `gf`: Go to filename under cursor.
- `<ctrl>^`: Return to alternate (usually previous) file.

### `jedi-vim`

- `<leader>g`: Go to assignments.
- `<leader>d`: Go to definitions
- `K`: Show documentation.
- `<leader>r`: Renaming.
- `<leader>n`: Show all usages of a name.
- `:Pyimport`: Open module (e.g. `:Pyimport os`)

### `vim-indent-object`

- `<cmd>ai`: `<cmd>` (e.g, `v`, `d`, `c`, etc.) current indent level + the line
  that initalizes it (i.e function header).
- `<cmd><count>ai`: `<cmd><count>` indent levels + the line that initalizes it.
- `<cmd><count>ii`: Like above, but don't include lines above/below.
- `<cmd><count>aI`: Also include line that terminates the indentation.

### `ale`

- `<ctrl>n`: Next error/warning.
- `<ctrl>m`: Previous error/warning.

### `vim-fugitive` /` vim-gitgutter`
- `:G`: Git status. Can do numerous operations from here; press `g?` for
  details. Press enter on file to open. Refreshes automatically when you
  re-enter the split.
- `:Gblame`         Git blame. Press `o` on commit to view commit details.
- `:Git <cmd> %`: Does `<cmd>` (e.g. add/checkout/rm/mv) on current buffer.
- `[c` / `]c`: Jump between change hunks (same as standard `vimdiff`).
- `<leader>hp`: Preview hunk under cursor (vim-gitgutter).
- `<leader>hu`: Undo hunk under cursor (vim-gitgutter).
- `<leader>hs`: Stage hunk under cursor (vim-gitgutter).

### `vim-surround`

- `ys<movement><surrounding>`: New surrounding. E.g. `ysiw'` turns `Hello` into
  `'Hello'`.
- `cs<old><new>`: Change surrounding. E.g. `cs"<p` to change "foo" too `<p>foo</p>`.
- `ds<surrounding>`: Remove surrounding. E.g. `ds(` to change `(foo)` to `foo`.
- `v<movement>S<surrounding>`: Surround visual selection.

For bracket types (`{}`, `[]`, `()`, `<>`) using the open will add a space and
the close will not. E.g. `isiw(` -> `( foo )` and `ysiw)` -> `(foo)`.

`vim-repeat` makes `.` work with `vim-surround` commands.

### `viminfo`

Used to store command/search/jumplist history, among other things. Normally
located in `~/.viminfo`. Disable by starting a session with `vim -i NONE`.

## Tmux

`<prefix>` is `<ctrl>b` by default.

- `<ctrl>h/j/k/l`: Navigate panes. Also works for navigating to/from vim splits.
- `<prefix>z:` Toggle zoom.
- `<prefix>"`: Horizontal split.
- `<prefix>%`: Vertical split.

## Git

- `git remote show origin`: Show remote info.
- `git diff --staged`: Show only changes which have already been staged.
- `git diff <branch> -G<pattern> --stat`: List files adding `<pattern>`
  compared to `<branch>`. E.g. TODOs compared to master.
- `git show <commit>`: Show commmit.
- `git log --oneline`: Condensed log.
- `git commit -v`: View changes while editing commit message.
- `git commit -pv`: Interactively select chunks and commit in one go and view
  changes in commit message. Option summary:
  - `y` - stage this hunk.
  - `n` - do not stage this hunk.
  - `q` - quit; do not stage this hunk or any of the remaining ones.
  - `a` - stage this hunk and all later hunks in the file.
  - `d` - do not stage this hunk or any of the later hunks in the file.
  - `g` - select a hunk to go to.
  - `/` - search for a hunk matching the given regex.
  - `j` - leave this hunk undecided, see next undecided hunk.
  - `J` - leave this hunk undecided, see next hunk.
  - `k` - leave this hunk undecided, see previous undecided hunk.
  - `K` - leave this hunk undecided, see previous hunk.
  - `s` - split the current hunk into smaller hunks.
  - `e` - manually edit the current hunk.
  - `?` - print help.
- Fixups:
  - `git commit --amend`: The simple case. Amends most recent commit.
  - `git commit --fixup <commit>`: Create fixup commit for `<commit>`.
  - `git rebase -i --autosquash <commit>`: Rebase on `<commit>`, organizing
    `--fixup` commits in the right order.
- `git reset HEAD~`: Undo most recent commit, leaving state of files on disk
  untouched.

## jq

- `jq 'keys'`: Top-level keys.
- `jq '.results | length'`: Count items in subscripted array.

## Misc shell stuff

- `du -d 1 -h | sort -h`: More useful disk usage overview.
- `date -r`: Timestamp to human-friendly string.
- `diff <(cmd1) <(cmd2)`: Diff output of two commands.

## macOS

Several of these are set in System Preferences -> Keyboard -> Shortcuts.

- `⇧⌘/`: The omni-shortcut; search to find other shortcuts.
- `^⌥⌘F`: Toggle full screen.
  - Annoyingly, macOS has no standard fullscreen command for all apps. May need
    to map several menu items (e.g. "Enter Full Screen" / "Exit Full Screen" /
    "Toggle Full Screen") to the same shortcut.
- `^⌘F`: "Zoom" window.
- `^⌘→` / `^⌘←`: Move window to right/left side of screen.
- `^⌥⌘→` / `^⌥⌘←`: Tile window to right/left side of screen.

### Finder / Quick Look

- `⌥+Space`: Open Quick Look in fullscreen.
- `⌥+Return`: View index sheet in Quick Look, with multiple files selected in Finder.


### iTerm2

- `⌥⌘ + <click-drag>`: Rectangular selection.
- `⌥ + <click-drag>`: Discontinuous selections. (Doesn't work in tmux?)

### Capture One 20

- Rating:
    - `0`-`5`: Assign star rating.
    - `⌘1`-`⌘5`: Toggle star rating filter.
- View:
    - `G`: Show/hide viewer.
    - `⌘T`: Show/hide tools.
    - `⌘B`: Show/hide browser.
    - `⌘E`: Exposure warning.
    - `Y`: Before/after.
    - Zoom:
        - `⌘+`/`⌘-`: Zoom in/out.
        - `,`: Zoom to fit.
        - `.`: Zoom to 100%.
        - `⌘.`: Zoom to 400%.
- `⌥⌘1`-`⌥⌘0`: Select tool tab.
- Cursor tools:
    - Click and hold to reveal sub-tools...
    - `H`: Pan (hand).
    - `P`: Loupe.
    - `C`: Crop.
    - `R`: Straighten/rotate.
    - `K`: Keystone.
    - `O`: Spot removal.
    - `Q`: Healing mask. Creates new/selects heal layer.
    - `S`: Cloning mask. Creates new/selects clone layer.
    - `L`: Draw linear gradient mask. Creates new/selects adjustment layer.
    - `T`: Draw radial gradient mask. Creates new/selects adjustment layer.
- Adjustments:
    - `⌘L`: Auto adjust.
    - `⌘R`: Reset adjustments.
    - `⇧⌘C`: Copy adjustments.
    - `⇧⌘V`: Apply adjustments.

### Garage Band

- `⌘K`: Show/hide on-screen keyboard.
