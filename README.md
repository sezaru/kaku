<p align="center"><img src="https://i.imgur.com/X5zKxvp.png" width=300px></p>

*This was originally a fork of [linuxmobile/kaku](https://github.com/linuxmobile/kaku) config.*

## INSTALLATION 

- Download ISO.

```bash
wget -O https://channels.nixos.org/nixos-25.05/latest-nixos-minimal-x86_64-linux.iso
```

- Boot Into the Installer.

- Switch to Root: `sudo su`

- Partitions:

```bash
# Replace nvme with your disk partition
gdisk /dev/nvme0n1
```

    - `o` (create new partition table)
    - `n` (add partition, 512M, type ef00 EFI)
    - `n` (add partition, remaining space, type 8300 Linux)
    `w` (write partition table and exit)

- Format Partitions:

```bash
mkfs.fat -F 32 -n EFI /dev/nvme0n1p1
mkfs.xfs -L NIXOS /dev/nvme0n1p2
```

- Mount Partitions:

```bash
mount /dev/disk/by-label/NIXOS /mnt
mkdir -p /mnt/boot
mount /dev/disk/by-label/EFI /mnt/boot
```

- Enable nixFlakes

```bash
nix-shell -p nixVersions.stable git
```

# TODO Add texto about sbctl create-keys

- Clone my Dotfiles

```bash
git clone --depth 1 https://github.com/linuxmobile/kaku /mnt/etc/nixos
```

- Generate your Own Nix Hardware Settings:

### ⚠ <sup><sub><samp>DON'T FORGET IT</samp></sub></sup>

```bash
sudo nixos-generate-config --dir /mnt/etc/nixos/hosts/aesthetic --force

# Remove configuration.nix
rm -rf /mnt/etc/nixos/hosts/aesthetic/configuration.nix
```

- Install Dotfiles Using Flake

```bash
# Move to folder
cd mnt/etc/nixos/

# Install
nixos-install --flake .#aesthetic
```

- Reboot

### 🐙 <sup><sub><samp>Remember <strong>Default</strong> User & password are: nixos</samp></sub></sup>

- Change Default password for User.

```bash
passwd YourUser
```

- Install w/ Home-Manager the config

```bash
home-manager switch --flake 'github:linuxmobile/kaku#linudev@aesthetic'
```

### 🌸 <samp>SCREENSHOTS</samp>

|                           |                           |
| :-----------------------: | :-----------------------: |
| <img src="/assets/1.png"> | <img src="/assets/2.png"> |
| <img src="/assets/3.png"> | <img src="/assets/4.png"> |
| <img src="/assets/5.png"> | <img src="/assets/6.png"> |

### 🌻 <samp>TODO LIST</samp>

### 🎋 <samp>ADDITIONALS</samp>

## 🍀 <samp>KEY BINDINGS</samp>

## 💐 <samp>ACKNOWLEDGEMENTS</samp>

|           |     | Inspiration and Resources                   |                            |     |
| :-------: | :-: | :------------------------------------------ | :------------------------- | :-: |
|           |  1  | [owl4ce](https://github.com/owl4ce)         |                            |     |
|           |  2  | [Ilham25](https://github.com/ilham25)       |                            |     |
|           |  3  | [Siduck](https://github.com/siduck)         |                            |     |
|           |  4  | [NvChad](https://github.com/NvChad)         |                            |     |
|           |  5  | [Rxyhn](https://github.com/rxyhn)           |                            |     |
|           |  6  | [HeinzDev](https://github.com/HeinzDev)     |                            |     |
|           |  7  | [fufexan](https://github.com/fufexan)       |                            |     |
|           |  8  | [AmitGolden](https://github.com/AmitGolden) |                            |     |
|           |     |                                             |                            |     |
| **Based** |     | **Community**                               | **Membership Status**      |     |
|     🗺     |  3  | [r/unixp*rn](https://reddit.com/r/unixporn) | Not working there anymore. |     |

## 🌳 <samp>CONTRIBUTING</samp>

WIP

## 🎃 <samp>SECURITY POLICY</samp>

<pre align="center">
<a href="#readme">BACK TO TOP</a>
</pre>
