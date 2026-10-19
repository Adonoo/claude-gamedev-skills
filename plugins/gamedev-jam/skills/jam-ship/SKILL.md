---
name: jam-ship
description: Release checklist for submitting a Unity game jam entry — final build for WebGL or desktop, smoke test of the build, itch.io page, submission ahead of the deadline, tagging the release. Use when the user is preparing the release candidate, building the final version, uploading to itch.io, or submitting to the jam.
---

# Jam ship checklist

Go through it with the user; tick items in CLAUDE.md. Start **at least a day** before the
deadline, and submit **hours** early.

## Build

- [ ] All scenes in Build Settings in the right order; the start scene first.
- [ ] Debug overlays, cheats and test keys off (or behind a define).
- [ ] Resolution / aspect: the game looks right at the target size (WebGL canvas size, or
      windowed + fullscreen on desktop).
- [ ] Player Settings: product name, company, icon, version (`1.0-jam`).
- [ ] WebGL: a compression the host serves correctly (when unsure: Gzip with "Decompression
      Fallback" on), test the uploaded build early (not on the last day); the first sound
      waits for a click.
- [ ] Build with the `unity:unity-cli` skill (or File → Build) into `Builds/` (git-ignored).

## Smoke test the BUILD (not the Editor)

- [ ] Fresh start → start screen → play → win/lose → restart works.
- [ ] Keyboard and (if promised) gamepad work; controls are shown in-game.
- [ ] Audio plays, volume is sane, nothing is missing (resources that only exist in the Editor).
- [ ] No errors in the browser console / player log.
- [ ] Someone else plays it on another machine for 5 minutes.

## itch.io page

- [ ] Upload: WebGL = zip of the build folder with `index.html` at the root, "This file will be
      played in the browser", viewport size set; desktop = zip per platform.
- [ ] Cover image (630×500), 3–5 screenshots, ideally a GIF of the core loop.
- [ ] Short description: what you do, controls, team credits, used assets and their licenses,
      the jam name and theme.
- [ ] Page visibility public (or as the jam requires), then **submit to the jam page**.

## Wrap-up

- [ ] Commit, tag the release (`git tag jam-submission`), push.
- [ ] Update CLAUDE.md: status "submitted", known bugs, post-jam ideas from the Could list.
- [ ] Optional: a short retro with the user — what worked in the workflow, what to change next
      time (record lessons in the project's CLAUDE.md, and tell the user which ones could
      improve the shared skills).
