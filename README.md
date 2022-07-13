# session.vim

Automatically load the session contained in the current directory.

## Specification

The behaviour of this plugin is:
 1. If there is a session file (e.g. `Session.vim`) in the current directory, no
    input from stdin and no file argument on the command line, the session is
    loaded on start.
 2. If currently in a session, either loaded on start or activated manually with
    `:ToggleSession`, it is written to a session file on exit.
 3. The command `:ToggleSession` toggles, whether the current session is saved
    on exit.  Additionally, the session file will be removed or created if a
    currently in a session or not respectively.

The name of the session file may be configured via the `g:session_name`
variable.  By default, it is named `Session.vim`.

## Installation

With packer:
```lua
use "f1rstlady/session"
```

Alternatively, clone this repository into a the `start/` directory of a package
(see `:h packages`).
