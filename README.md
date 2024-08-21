# AHA Nix devshell demos

This repo contains three different devshell envioronments all located in the `flake.nix` in each directory.

## Install Nix

Install and enable [nix](https://nixos.org/download/)

```
sh <(curl -L https://nixos.org/nix/install) --no-daemon
```

## Python devshell

Here is a Python devshell with [r2](https://rada.re/n/radare2.html)

```
❯ cd cmu_binary_bomb
❯ nix develop
❯ python3 flag2.py
❯ r2 --version
```

Note that Rust is not available in this devshell

```
❯ cargo --version
cargo: command not found
```

And python3 `requests` is also not available in the Python environment
since it was not in the included packed in the [flake.nix](./cmu_binary_bomb/flake.nix)

```
python = pkgs.python311.withPackages (p: with p; [ 
  angr
  ipython 
  ipdb
  python-lsp-server
]);
```

```
❯ python3 -c 'import requests'
Traceback (most recent call last):
  File "<string>", line 1, in <module>
ModuleNotFoundError: No module named 'requests'
```

## Rust devshell

```
❯ cd macroquad_breakout_juicing
❯ nix develop
❯ cargo run -r
```

Note that Python3 with angr is not available in this devshell.

```
❯ python3 -c 'import angr'
Traceback (most recent call last):
  File "<string>", line 1, in <module>
ModuleNotFoundError: No module named 'angr'
```

## AHA Terminal fun

```
❯ cd fun_nix
❯ nix develop
❯ asciiquarium
❯ nyancat
❯ fortune
```

Note that Python3 with angr is not available in this devshell.

```
❯ python3 -c 'import angr'
Traceback (most recent call last):
  File "<string>", line 1, in <module>
ModuleNotFoundError: No module named 'angr'
```

Note that Rust is not available in this devshell

```
❯ cargo --version
cargo: command not found
```
