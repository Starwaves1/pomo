# 🍅 pomo

A Pomodoro timer for the terminal, with a braille progress bar.

Five questions, each pre-filled with the session you ran last — so five Enters
repeats it exactly. Then it takes over the window until you're done.

![pomo running](docs/running.png)

## Install

macOS or Linux, Python 3.9+. No dependencies — one file, standard library only.

```sh
git clone https://github.com/Starwaves1/pomo.git
ln -s "$PWD/pomo/pomo" ~/bin/pomo    # anywhere on your PATH
```

## Use

```sh
pomo        # set up this session, then start it
pomo help   # keys, settings, where things live
```

![pomo setup](docs/setup.png)

Answer durations as `25`, `45m`, `90s` or `1h`. Anything unparseable keeps the
default — there's no error to dismiss, you just try again.

Answer **Sessions today** and the row fills in how long the whole run takes and
the time you'll finish, breaks included. `0` means no goal: cycle until you quit.

| key | |
|---|---|
| `space` | pause / resume |
| `s` | skip to the next interval |
| `r` | restart this interval |
| `q` | quit (Ctrl+C works too) |

## Settings

Everything lives in `~/.config/pomo/pomo.ini`, rewritten after every run so it
always holds your last session. Setup covers the timings; edit the file for the
rest:

```ini
[sound]
# A bundled sound by name, or a path to any audio file of your own.
# Leave empty for silence.
file = ~/Documents/ping.wav
volume = 0.5

[display]
width = 24
notify = yes
```

Bundled names that work out of the box:

| | |
|---|---|
| macOS | `Glass` `Ping` `Submarine` `Hero` `Funk` `Sosumi` `Basso` |
| Linux | `complete` `bell` `message` `alarm-clock-elapsed` |

Or point `file` at anything you like — `~/Documents/ping.wav`, an mp3, an ogg.

## Portability

The same install works on both platforms. The audio player and notifier are
discovered at runtime rather than hardcoded:

| | macOS | Linux |
|---|---|---|
| sound | `afplay` | `paplay`, `ffplay`, `mpv`, `aplay` |
| notification | `osascript` | `notify-send` |

The first one present wins. On a machine with none of them, pomo runs quiet
instead of failing.

## Notes

- Uses the alternate screen buffer, like `vim` or `htop` — your scrollback is
  untouched while it runs, and you get the window back exactly as you left it,
  with one line saying what you got done.
- Colours are 256-colour, which every modern terminal handles.

## License

MIT
