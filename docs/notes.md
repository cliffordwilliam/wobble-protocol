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
