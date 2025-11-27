# 🖨️ The `printf` Command Cheat Sheet

> Print formatted output in bash and POSIX-compatible shells.

---

## 🔤 Basic Format Specifiers

| Spec. | Description               | Example                    | Output    |
|:-----:|:--------------------------|:---------------------------|:---------:|
| `%s`  | String                    | `printf "%s\n" foo`        | foo       |
| `%b`  | Escapes in string         | `printf "%b\n" "a\nb"`     | a <br> b  |
| `%d`  | Signed integer            | `printf "%d\n" -42`        | -42       |
| `%u`  | Unsigned integer          | `printf "%u\n" 300`        | 300       |
| `%x`  | Hex (lowercase)           | `printf "%x\n" 255`        | ff        |
| `%X`  | Hex (uppercase)           | `printf "%X\n" 255`        | FF        |
| `%o`  | Octal                     | `printf "%o\n" 64`         | 100       |
| `%f`  | Float                     | `printf "%.2f\n" 3.14159`   | 3.14      |
| `%e`  | Sci. notation (lower)     | `printf "%e\n" 12300`      | 1.23e+04  |
| `%E`  | Sci. notation (upper)     | `printf "%E\n" 12300`      | 1.23E+04  |
| `%c`  | ASCII character           | `printf "%c\n" 65`         | A         |
| `%%`  | Literal percent sign      | `printf "%%\n"`            | %         |

---

## 🔁 Escape Sequences (Used with `%b`)

| Sequence | Meaning         |
|:--------:|-----------------|
| `\n`     | Newline         |
| `\t`     | Tab             |
| `\r`     | Carriage return |
| `\a`     | Alert (bell)    |
| `\b`     | Backspace       |
| `\\`     | Backslash       |
| `\"`     | Double quote    |
| `\0NNN`  | Octal byte      |

---

## 🎯 Format Syntax

```
%[flags][width][.precision]specifier
```

---

## 🧩 Flags, Width & Precision

- `-` : Left-justify result
- `+` : Always show sign
- space : Prefix space for positive numbers
- `0` : Pad with leading zeros
- `#` : Alternate form (e.g. `0x` for `%x`)

🧮 **Width**:  
Minimum number of characters for the field (e.g. `%8s`)

🎯 **Precision**:  
- Floats: digits after `.` → `%.3f`  
- Strings: max characters → `%.5s`

---

## 🧠 Dynamic Width & Precision

Use `*` to set width or precision from arguments:

```bash
printf "%*.*f\n" 10 3 3.14159
# →    3.142
```

---

## 🧍 Positional Parameters

Reference values by argument order:

```bash
printf "%2$s is %1$d years old\n" 30 "Alice"
# → Alice is 30 years old
```

---

## 🪄 Bash Extensions

Quoting for shell input:

```bash
printf "%q\n" "a b"
# → a\ b
```

---

## 🧼 Prepending Spaces Before Output

### 1. Fixed Leading Spaces

```bash
printf '    %s\n' "Commands for: $program"
```

### 2. Right-Align with Field Width

```bash
printf '%40s\n' "Commands for: $program"
```

### 3. Dynamic Padding

```bash
pad="    "
printf '%s%s\n' "$pad" "Commands for: $program"
```

🔧 **Integrated Example**:

```bash
GLOW "============================"
printf '    %s\n' "Commands for: $program"
GLOW "----------------------------"
```

---

## 🧪 Practical Examples

### 1. Column Output

```bash
printf "%-10s %5s\n" Name Score
printf "%-10s %5.1f\n" Alice 93.5
```

### 2. Zero-Padded Numbers

```bash
printf "ID:%04d\n" {1..3}
```

### 3. Safe Shell Quote

```bash
safe=$(printf "%q" "$input")
eval "echo You entered: $safe"
```

### 4. Byte View (Hex Dump)

```bash
printf "%s" "Hi" | xxd
```

---

## ✅ Best Practices

- Always quote format strings and args.
- Prefer `%s` unless you need escapes → then use `%b`.
- Avoid `%n` in scripts (unsafe).
- Use Bash's built-in `printf` for speed.
- Test with edge cases (empty, long strings, etc.).

---

> 💡 Tip: `printf` is **more portable and safer** than `echo -e`.
