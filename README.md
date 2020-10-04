# Dicer

Simple CLI app build with Argument Parser for in-company presentation.

Keynote attached.

## Usage

### Example 1 - Simple roll

``` bash
❯ swift run Dicer d10 d12
> 18
```

### Example 2 - repeat roll <n> times

``` bash
❯ swift run Dicer d10 d12 --repeat 2
> 16
> 8
```

### Example 2 - print each dice on separate row

``` bash
❯ swift run Dicer d6 d6 d6 --show-separately
> 6
> 3
> 6
```

