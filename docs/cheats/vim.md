# Vim Cheat-Sheet

## Search for every instance of lx and replace it with LX:

```shell
:%s/lx/\LX/g
```
  **Note:** Replacing every instance of '\Lx' will throw an error.

    - **(`\`):** The backslash before `LOG_FILE` can cause Vim to interpret `\L` as a special sequence.

To replace all instances of `log_file` with `LOG_FILE` use the following command **without** the backslash:

```shell
:%s/log_file/LOG_FILE/g
```

## Replace every instance of Lx:

```shell
:$s/Lx//g
```

## Remove every number, period and hyphen:

```shell
:%s/[0-9.-]//g
```

## Erase a single word from file:

```shell
sed -i 's/word//g' filename.txt
```

## Remove anything after the first space in each line

```shell
sed -i 's/ .*$//' filename.txt
```

## Sort and remove all dupes

```shell
vi +'%!sort | uniq' +wq filename.txt
```

## Insert a character down entire column.

1. **Position the cursor** on the first line of the block.
2. Press **Ctrl+V** to start visual block mode.
3. **Down-arrow** (or **j**) to extend the block over the lines you want. 
4. Press **I** to start inserting before the block; **i** to start inserting after the block.  
5. Type: **#**
6. Press: **Esc**
