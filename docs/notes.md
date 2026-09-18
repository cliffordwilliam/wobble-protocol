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

## Movement and size values are from SMB1

Note that the following applies to any dimensional values,
here is just showing how speed is computed.

Note that we use 120 tile size.

Mario's SMB1 movement constants (px/frame at 60 fps), converted to px/s.
These were tuned for the NES's 256x240 screen. HORIZONTAL_SCALE/VERTICAL_SCALE
are this project's viewport size divided by the NES's, per axis, so a value
takes the same fraction of a frame (in time) to cross the screen as in SMB1.
Reference: https://forums.sonicretro.org/threads/help-understanding-a-mario-physics-guide.34457/

const BASE_MAX_SPEED := 90.0
const BASE_ACCELERATION := 196.875
const BASE_RISE_GRAVITY := 225.0
const BASE_FALL_GRAVITY := 1125.0
const BASE_MAX_FALL_SPEED := 258.75
const BASE_JUMP_VELOCITY := -206.25

const HORIZONTAL_SCALE := 1920.0 / 256.0  # 7.5
const VERTICAL_SCALE := 1080.0 / 240.0  # 4.5

## Using no assets

This game rely on built in resources for the visual rendering.
For the actors, we use reusable gradient resource and per actor creates inline gradient texture 2d.
Tiles uses reusable gradient texture 2d instead.
Actor can have different color using modulate, tiles can use per tile modulate attribute.
