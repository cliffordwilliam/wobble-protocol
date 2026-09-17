# Notes

This document store important notes about how to work on this project.

## Commit message format

Here is an example:

```text
fix: prevent race condition in token refresh

Token refresh could fire twice if two requests hit a 401
simultaneously. Added a mutex so only one refresh happens
at a time; concurrent requests await the same promise.
```

Types to use:
- feat: new feature
- fix: bug fix
- docs: documentation only
- style: formatting, no code change
- refactor: code change that's neither a fix nor a feature
- test: adding/fixing tests
- chore: tooling, dependencies, build config

## Editor sluggyishness and stuck popup editor solutions

To solve the "sluggyishness", turn off the editor vsync,
EditorSettings → interface/editor/display/vsync_mode — controls the editor's own V-Sync.
Then to lower the chance of popup getting stuck,
go to Editor Settings → Interface → Enable Single Window Mode.
I could have also toggle off the project vsync, and also make the project display server to
use wayland. But these affects the exported project so I think I am fine with just these.
