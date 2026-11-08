# How we work

The short version for humans. Claude follows the same rules (they're in `CLAUDE.md` and the
team plugin).

## The loop

1. **Pick an issue** from the board's *Ready* column (new? take a `good-first-issue`). Assign
   yourself.
2. **Start a session**: open the project in Unity, open Claude Code in the repo folder, say
   *"let's continue with #12"*. Claude catches up on what changed, makes the branch and locks
   the scenes you need.
3. **Answer Claude's questions.** It asks before building because guessing wastes your time.
   "Your call" is a fine answer.
4. **Claude builds a small piece and hands you a checklist.** Play it. Say how it feels in
   normal words ("the jump is floaty", "I can't see the exit").
5. **Tune numbers yourself** in the Inspector (the assets under `Data/`). That's your job, not
   Claude's.
6. **Open a pull request** when it plays well. A teammate plays your checklist and approves.
7. **Merge**, and the next person gets your work on `main`.

Stopping mid-way is fine: say *"wrap up"* and Claude pushes the branch and writes a handoff
note on the issue.

## Rules that save us pain

- **Never work on `main` directly.** Branch → PR → merge.
- **Lock a scene before you edit it** (Claude does this; or `git lfs lock <scene>`). Locked
  scenes are read-only for everyone else — if Unity says a scene is read-only, someone has it
  or you haven't locked it.
- **Don't edit someone else's scene or tuned values.** Ask them in the issue or the channel.
- **Changes to project settings, packages, input or layers** affect everybody: ask first.
- **Same Unity version for everyone:** <version>.
- **Save your scene before you let Claude run checks**, and tell it when you're playtesting.

## Where things are

| I want to… | Look at |
|---|---|
| know what to do next | the board: <url> |
| know who decides what | `TEAM.md` |
| know why something is the way it is | `docs/decisions/` |
| tune a value | `Assets/_Project/Data/<area>/` in the Inspector |
| build a level | <recipe / menu item> |
| learn a Unity concept | ask Claude: "explain prefabs to me with an example from our project" |

## Weekly sync (<day, time>)

We play `main` together, take the open decisions, plan the week, and spend 5 minutes on what
slowed us down. Bring one sentence: best moment, worst moment.

## Stuck?

More than ~30 minutes on the same problem → ask in <channel>. Include what you tried and the
console error. Everyone is learning here, including the AI.
