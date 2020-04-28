# stimmtaush.vim

Simple vim plugin for writing to [Stimmtausch](https://stimmtausch.org) connections

## Setting up

Create a global with config options:

```vim
let g:stimmtausch = {'worlds': [
                    \ {'name': 'FM: Makyo',  'dir': '~/.local/share/stimmtausch/furry_makyo'},
                    \ {'name': 'SPR: Ephah', 'dir': '~/.local/share/stimmtausch/spr_ephah'}]}
```

Other options that can go in the dict:

`showbreak`
:   Whether to `set showbreak` (character defaults to ⮨)

`break_symbol`
:   The symbol used to show breaks (implies `showbreak`)

`clear_on_send`
:   If set, clears the buffer after sending (thus dumping history)

You'll probably want to set up a shortcut for starting. I like `nmap <silent> <Leader>st :call Stimmtausch()<CR>`. From there, you select the world with `<Leader>#`, where `#` is the 1-index of the world in the array.

## How do?

### Writing

Start a `tmux` or `screen` session, create a horizontal split pane, and `tail -f` the proper MUCK output file (e.g: `~/.local/share/stimmtausch/spr_ephah/out`) in the upper pane, and set the proper world with `<Leader>#` and you're ready to go. In insert mode, enter sends the current line, and in visual mode, it sends the current selection (so you can type up a few lines and send them at the same time; to get a new line, do `<ESC>o`)

### Reading

If you want vim's wordwrap, you can do `<Leader>#r` to have it read and follow the output file as well. A bit slow on longer buffers, though. You'll need the [Colorizer](https://github.com/chrisbra/Colorizer) plugin for this to work, too, otherwise you'll keep getting ANSI escapes.

## Why?!

* Visible history (with editable reposes!)
* Optional spellcheck
* Syntax highlighting
* Length of lines (some MUCKs only allow 1024 characters to be sent, and if you're buffer-busting, knowing how many characters you're sending is good)
* Word-wrap breaking links with smaller screens/longer links

...all things I'd like to fix in Stimmtausch's UI but haven't the time to tackle.
