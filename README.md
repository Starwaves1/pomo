# 🍅 pomo

A Pomodoro timer for the terminal, with a braille progress bar.

Five questions, each pre-filled with the session you ran last — so five Enters
repeats it exactly. Then it takes over the window until you're done.

```
  🍅 pomo  25m focus  ·  5m break  ·  goal 4

  focus     ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀   12:43  ●●○○

  focus     ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿   3:12 PM  ●○○○  ✓
  break     ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿   3:17 PM  ●○○○  ✓

  space pause · s skip · r restart · q quit
```

## Install

Needs macOS and Python 3.9+. No dependencies — it's one file, standard library only.

```sh
git clone https://github.com/Starwaves1/pomo.git
ln -s "$PWD/pomo/pomo" ~/bin/pomo    # anywhere on your PATH
```

## Use

```sh
pomo        # set up this session, then start it
pomo help   # keys, settings, where things live
```

Setup asks five questions:

```
  Focus              25m  ▸
  Short break         5m  ▸
  Long break         15m  ▸
  Focus per set        4  ▸
  Sessions today       4  ▸ 4   1h 55m  ·  3:26 PM
```

Answer durations as `25`, `45m`, `90s` or `1h`. Anything unparseable keeps the
default — there's no error to dismiss, you just try again next run.

Answer **Sessions today** and the row fills in how long the whole run takes and
the time you'll finish, breaks included. `0` means no goal: cycle until you quit.

| key | |
|---|---|
| `space` | pause / resume |
| `s` | skip to the next interval |
| `r` | restart this interval |
| `q` | quit (Ctrl+C works too) |

## The bar

A braille cell is 2 columns × 4 rows of dots, so each character holds two
horizontal half-steps — twice the resolution of a block bar the same width.
Three glyphs do all the work:

| | |
|---|---|
| `⣿` | full cell |
| `⡇` | half cell — the odd step |
| `⣀` | the unfilled rail |

Each interval colour has a matching muted rail in the same hue, so the bar reads
as one object filling up rather than a bright thing sitting on grey.

## Settings

Everything lives in `~/.config/pomo/pomo.ini`, rewritten after every run so it
always holds your last session. Setup covers the timings; edit the file for the
rest:

```ini
[sound]
# A macOS system sound (Glass, Ping, Submarine, Hero, Funk, Sosumi, Basso...)
# or a path to any audio file. Leave empty for silence.
file = Glass
volume = 0.5

[display]
width = 24
notify = yes
```

The alarm plays through `afplay`, so any wav/mp3/aiff/m4a works.

## Notes

- Uses the alternate screen buffer, like `vim` or `htop` — your scrollback is
  untouched while it runs, and you get the window back exactly as you left it,
  with one line saying what you got done.
- Colours are 256-colour, which every modern macOS terminal handles.
- macOS only, because of `afplay` and `osascript`. The rest is portable; swap
  those two calls and it would run anywhere.

## License

MIT
