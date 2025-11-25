# ZSH Comps

Provides zsh shell completions (includes selected OSX commands). 
This repository's main purpose is to create quality auto completions, 
e.g. conditional flag aware presentation and selection of choices, 
as well as up-to-date and feature-complete auto completions.

# Installation

```bash
# clone this repo
git clone git://github.com/danydodson/zsh-comps ${DOTFILES}/plugins/zsh-comps

# ~.zshrc
source ${DOTFILES}/plugins/zsh-comps/zsh-comps.plugin.zsh

# init completions
autoload -Uz compinit
compinit -d ~/.cache/zsh/zcompdump
```
---
# Usage

# Table of Contents
- [Intro](#intro)
- [Getting started](#getting-started)
  - [Telling zsh which function to use for completing a command](#telling-zsh-which-function-to-use-for-completing-a-command)
  - [Completing generic gnu commands](#completing-generic-gnu-commands)
  - [Copying completions from another command](#copying-completions-from-another-command)
- [Writing your own completion functions](#writing-your-own-completion-functions)
  - [Utility functions](#utility-functions)
  - [Writing simple completion functions using _describe](#writing-simple-completion-functions-using-_describe)
  - [Writing completion functions using _alternative](#writing-completion-functions-using-_alternative)
  - [Writing completion functions using _arguments](#writing-completion-functions-using-_arguments)
  - [Writing completion functions using _regex_arguments and _regex_words](#writing-completion-functions-using-_regex_arguments-and-_regex_words)
  - [Complex completions with _values, _sep_parts, & _multi_parts](#complex-completions-with-_values-_sep_parts-&-_multi_parts)
  - [Adding completion words directly using compadd](#adding-completion-words-directly-using-compadd)
- [Testing & debugging](#testing--debugging)
- [Gotchas (things to watch out for)](#gotchas-things-to-watch-out-for)
- [Tips](#tips)
- [Other resources](#other-resources)

# Intro
The official documentation for writing zsh completion functions is difficult to understand, and doesn't give many examples.
At the time of writing this document I was able to find a few other tutorials on the web, however those tutorials only
explain a small portion of the capabilities of the completion system. This document aims to cover areas not explained elsewhere,
with examples, so that you can learn how to write more advanced completion functions. I do not go into all the details, but will
give enough information and examples to get you up and running. If you need more details you can look it up for yourself in the
[official documentation](https://zsh.sourceforge.net/Doc/Release/Completion-System.html#Completion-System).

Please make any scripts that you create publicly available for others (e.g. by forking this repo and making a [pull request](#pull-request)).
Also if you have any more information to add or improvements to make to this tutorial, please do.

# Getting started
## Telling zsh which function to use for completing a command
Completion functions for commands are stored in files with names beginning with an underscore `_`, and these files should
be placed in a directory listed in the `$fpath` variable.
You can add a directory to `$fpath` by adding a line like this to your `~/.zshrc` file:

```sh
fpath=(~/newdir $fpath)
```

The first line of a completion function file can look something like this:

```sh
#compdef foobar
```

This tells zsh that the file contains code for completing the `foobar` command.
This is the format that you will use most often for the first line, but you can also use the same file for completing
several different functions if you want. See [here](https://zsh.sourceforge.net/Doc/Release/Completion-System.html#Autoloaded-files) for more details.

You can also use the `compdef` command directly (e.g. in your `~/.zshrc` file) to tell zsh which function to use for completing
a command like this:

```sh
compdef _function foobar
```

or to use the same completions for several commands:

```sh
compdef _function foobar goocar hoodar
```

or if you want to supply arguments:

```sh
compdef '_function arg1 arg2' foobar
```

See [here](https://zsh.sourceforge.net/Doc/Release/Completion-System.html#Functions-4) for more details.

## Completing generic gnu commands
Many [gnu](https://www.gnu.org/) commands have a standardized way of listing option descriptions (when the `--help` option is used).
For these commands you can use the `_gnu_generic` function for automatically creating completions, like this:

```sh
compdef _gnu_generic foobar
```

or to use `_gnu_generic` with several different commands:

```sh
compdef _gnu_generic foobar goocar hoodar
```

This line can be placed in your `~/.zshrc` file.

## Copying completions from another command
If you want a command, say `cmd1`, to have the same completions as another, say `cmd2`, which has already had
completions defined for it, you can do this:

```sh
compdef cmd1=cmd2
```

This can be useful for example if you have created an alias for a command to help you remember it.

# Writing your own completion functions
A good way to get started is to look at some already defined completion functions.
On my linux installation these are found in `/usr/share/zsh/functions/Completion/Unix`
and `/usr/share/zsh/functions/Completion/Linux` and a few other subdirs.

You will notice that the `_arguments` function is used a lot in these files.
This is a utility function that makes it easy to write simple completion functions.
The `_arguments` function is a wrapper around the `compadd` builtin function.
The `compadd` builtin is the core function used to add completion words to the command line, and control its behaviour.
However, most of the time you will not need to use `compadd`, since there are many utility functions such as `_arguments`
and `_describe` which are easier to use.

For very basic completions the `_describe` function should be adequate

## Utility functions
Here is a list of some of the utility functions that may be of use.
The full list of utility functions, with full explanations, is available [here](https://zsh.sourceforge.net/Doc/Release/Completion-System.html#Completion-Functions).
Examples of how to use these functions are given in the next section.

### Main utility functions for overall completion
| Function        | Description                                                                                                                                 |
|-----------------|---------------------------------------------------------------------------------------------------------------------------------------------|
| `_alternative`  | Can be used to generate completion candidates from other utility functions or shell code.                                                   |
| `_arguments`    | Used to specify how to complete individual options & arguments for a command with unix style options.                                       |
| `_describe`     | Used for creating simple completions consisting of words with descriptions (but no actions). Easier to use than `_arguments`.               |
| `_gnu_generic`  | Can be used to complete options for commands that understand the `--help` option.                                                           |
| `_regex_arguments` | Creates a function for matching commandline arguments with regular expressions, and then performing actions/completions.                    |

### Functions for performing complex completions of single words
| Function        | Description                                                                                                                                 |
|-----------------|---------------------------------------------------------------------------------------------------------------------------------------------|
| `_values`       | Used for completing arbitrary keywords (values) and their arguments, or comma separated lists of such combinations.                          |
| `_combination`  | Used to complete combinations of values, for example pairs of hostnames and usernames.                                                       |
| `_multi_parts`  | Used for completing multiple parts of words separately where each part is separated by some char, e.g. for completing partial filepaths: `/u/i/sy` -> `/usr/include/sys` |
| `_sep_parts`    | Like `_multi_parts` but allows different separators at different parts of the completion.                                                    |
| `_sequence`     | Used as a wrapper around another completion function to complete a delimited list of matches generated by that other function.              |

### Functions for completing specific types of objects
| Function        | Description                                                                                                                                 |
|-----------------|---------------------------------------------------------------------------------------------------------------------------------------------|
| `_path_files`   | Used to complete filepaths. Take several options to control behaviour.                                                                        |
| `_files`        | Calls `_path_files` with all options except `-g` and `-/`. These options depend on file-patterns style setting.                              |
| `_net_interfaces` | Used for completing network interface names                                                                                               |
| `_users`        | Used for completing user names                                                                                                            |
| `_groups`       | Used for completing group names                                                                                                           |
| `_options`      | Used for completing the names of shell options.                                                                                           |
| `_parameters`   | Used for completing the names of shell parameters/variables (can restrict to those matching a pattern).                                       |

### Functions for handling cached completions
If you have a very large number of completions you can save them in a cache file so that the completions load quickly.
| Function        | Description                                                                                                                                 |
|-----------------|---------------------------------------------------------------------------------------------------------------------------------------------|
| `_cache_invalid` | Indicates whether the completions cache corresponding to a given cache identifier needs rebuilding.                                          |
| `_retrieve_cache` | Retrieves completion information from a cache file.                                                                                       |
| `_store_cache`  | Store completions corresponding to a given cache identifier in a cache file.                                                                |

### Other functions
| Function        | Description                                                                                                                                 |
|-----------------|---------------------------------------------------------------------------------------------------------------------------------------------|
| `_message`      | Used for displaying help messages in places where no completions can be generated.                                                          |
| `_regex_words`  | Can be used to generate arguments for the `_regex_arguments` command. This is easier than writing the arguments manually.                     |
| `_guard`        | Can be used in the ACTION of specifications for `_arguments` and similar functions to check the word being completed.                         |

### Actions
Many of the utility functions such as `_arguments`, `_regex_arguments`, `_alternative` and `_values` may include an action
at the end of an option/argument specification. This action indicates how to complete the corresponding argument.
The actions can take one of the following forms:
| Action            | Description                                                                                                                                 |
|-------------------|---------------------------------------------------------------------------------------------------------------------------------------------|
| `( )`             | Argument is required but no matches are generated for it.                                                                                   |
| `(ITEM1 ITEM2)`   | List of possible matches                                                                                                                     |
| `((ITEM1:'DESC1' ITEM2:'DESC2'))` | List of possible matches, with descriptions. Make sure to use different quotes than those around the whole specification.                  |
| `->STRING`        | Set `$state` to `STRING` and continue (`$state` can be checked in a case statement after the utility function call)                            |
| `FUNCTION`        | Name of a function to call for generating matches or performing some other action, e.g. `_files` or `_message`                               |
| `{EVAL-STRING}`   | Evaluate string as shell code to generate matches. This can be used to call a utility function with arguments, e.g. `_values` or `_describe` |
| `=ACTION`         | Inserts a dummy word into completion command line without changing the point at which completion takes place.                                  |

Not all action types are available for all utility functions that use them. For example the `->STRING` type is not available in the
`_regex_arguments` or
