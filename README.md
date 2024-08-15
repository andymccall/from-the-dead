# Amstrad CPC Development Environment Setup

From the Dead for the Amstrad CPC. A 2D side scrolling 2D survival game where the player has to escape from an zombie apocalypse.

### Install VSCode

Install VSCode and the following extensions:

- ASM Code Lens : https://marketplace.visualstudio.com/items?itemName=maziac.asm-code-lens
- DeZog : https://marketplace.visualstudio.com/items?itemName=maziac.dezog
- Z80 Instruction Set : https://marketplace.visualstudio.com/items?itemName=maziac.z80-instruction-set
- Z80 Assembly : https://marketplace.visualstudio.com/items?itemName=Imanolea.z80-asm
- Makefile Tools : https://marketplace.visualstudio.com/items?itemName=ms-vscode.makefile-tools


### Install sjasmplus

```
username@host:~$ git clone --recursive -j8 https://github.com/z00m128/sjasmplus.git
username@host:~$ cd sjasmplus
username@host:~$ make
username@host:~$ make install PREFIX=~/development/tools/sjasmplus
```

Test:

```
username@host:~$ ./sjasmplus --version
SjASMPlus Z80 Cross-Assembler v1.20.3 (https://github.com/z00m128/sjasmplus)
```

### Install z88dk

```
username@host:~$ sudo apt install libgmp-dev libxml2-dev
username@host:~$ git clone --recurse-submodules --remote-submodules https://github.com/z88dk/z88dk.git
username@host:~$ cd z88dk
username@host:~$ ./build.sh
username@host:~$ make install PREFIX=~/development/tools/z88dk
```

Add the z88dk to the path:

```
username@host:~$ vi ~/.profile
```

Add the following at the bottom of the file:

```
# set PATH so it includes z88dk if it exists
if [ -d "$HOME/development/tools/z88dk/bin" ] ; then
   PATH="$HOME/development/tools/z88dk/bin:$PATH"
fi

# set ZCCCFG if the directory exists
if [ -d "$HOME/development/tools/z88dk/share/z88dk/lib/config" ] ; then
   ZCCCFG=${HOME}/develoment/tools/z88dk/share/z88dk/lib/config
fi
```

Test:

```
username@host:~$ source ~/.profile
username@host:~$ zcc
zcc - Frontend for the z88dk Cross-C Compiler - v22742-3f05c420f1-20240625

Usage: zcc +[target] {options} {files}
...
```