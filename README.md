First, you need to add `packer.nvim`

```
git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
```

And then, open NeoVim and run commands `:PackerInstall` and `:PackerCompile`

## Rust setup

You need to install `rust-analyzer`, run these commands:

```
$ mkdir -p ~/.local/bin

$ curl -L https://github.com/rust-analyzer/rust-analyzer/releases/latest/download/rust-analyzer-x86_64-unknown-linux-gnu.gz | gunzip -c - > ~/.local/bin/rust-analyzer

$ chmod +x ~/.local/bin/rust-analyzer
```

Then change `$PATH` to:

```
export PATH=$PATH:~/.local/bin
```

