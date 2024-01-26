# Give macOS’ Terminal a better ‘ls’
Anyone who uses Terminal will run the ls command to get a listing of files and directories. It’s built in to macOS’ BSD Unix foundation layer. It has one key limitation for me: it has no option to list directories before listing files. Read on to learn how to deal with this issue.

## gls in action in macOS’ Terminal app

The trick is to use Linux’s ls, aka Gnu ls, aka gls. This is part of coreutils, and this is easy to install using Homebrew:

```brew install coreutils```

Once coreutils is installed, you can enter:

```gls --group-directories-first```

Of course, you have to remember to call gls rather than ls, but that’s easy to sidestep by using an alias. Here‘s mine, which also forces the listing into long mode:

```alias ls='gls -lhF --group-directories-first --color=auto'```  

Both forms of ls can be set to show colour output. The --color=auto option shown in the code above is equivalent to BSD ls’ -G but it gets its colour definitions from a different environment variable: LS_COLORS rather than LSCOLORS. LS_COLORS’ values are specified as style;foreground;background colour values. Each colour value is a specific code. For example:

```export LS_COLORS="$LS_COLORS:di=0;36:ln=0;93:ex=0;35:"```

This sets directories (di) to cyan, links (ln) to yellow and executables (ex) to purple. The style value in each case is zero, which means ‘no style’. Change it, for example, to 1 for bold, or 5 for flashing, though you probably won‘t want to keep it that way. 


**The complete list of styles is:**
```
0 — no style
1 — bold
4 — underlined
5 — flashing text
7 — reverse (background colour on foreground colour)
```

**The foreground colours are:**
```
31— red
32 — green
33 — orange
34 — blue
35 — purple
36 — cyan
37 — grey
90 — dark grey
91 — light red
92 — light green
93 — yellow
94 — light blue
95 — light purple
96 — turquoise
```

**And the backgrounds are:**
```
40 — black
41 — red
42 — green
43 — orange
44 — blue
45 — purple
46 — cyan
47 — grey
100 — dark grey
101 — light red
102 — light green
103 — yellow
104 — light blue
105 — light purple
106 — turquoise
```

All the colour options have defaults, most of which I left unchanged — I only altered the most commonly listed entities. 

**The list of entities you can change is:**
```
di — directory
fi — file
ln — link
pi — FIFO (ie. a named pipe)
so — socket
bd — buffered block
cd — unbuffered character
or — link pointing to a non-existent file, ie. an orphan
mi — link pointing to a non-existent file when you use ls -l
ex — executable
```

To list the defaults, enter: ```gdircolors --print-database```. 

As you’ll notice if you run the above command, a final tweak you can perform is to colour files by their extension.
For example, to colour .md files white, you’d add ```:*.md=0;37:``` to your LS_COLORS. The scope for customisation 
is colossal, and the key here is to experiment and find the colours you prefer and which are clear against whatever 
window-background colour (and opacity) you’ve set Terminal to display.