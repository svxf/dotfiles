<div align="center">
<img alt="Profiles Pictures" src="https://avatars.githubusercontent.com/u/60079016?v=4" width="200" height="200"/>
</div>

<div align="center">
    <h3>svxf's dot files</h3>
</div>

<div align="center">
  
  ![](https://img.shields.io/github/last-commit/svxf/dotfiles?&style=for-the-badge&color=8D748C&logoColor=D9E0EE&labelColor=252733)
  [![](https://img.shields.io/github/repo-size/svxf/dotfiles?color=%23DDB&label=SIZE&logo=codesandbox&style=for-the-badge&logoColor=D9E0EE&labelColor=252733)](https://github.com/svxf/dotfiles)

</div>

# Contents 📚:

### **use at your own risk!!!**

### Overview 🎑

- [🌾 Windows Manager]():
  - [🍙 HyprLand](#hypr)
- [😶‍🌫️ Terminal]():
  - **☄ Emulator**:
    - [kitty 😽](https://sw.kovidgoyal.net/kitty/)
  - **🌌 Shell**: 
    - [Oh My Zsh](https://ohmyz.sh/#install)

# Hyprland 🍙<a name = "hypr"></a>:
8 themes!

<div align="center">

![image](https://github.com/user-attachments/assets/a7e4520e-3f41-417c-bb6f-6aaa0d7b1c4a)
![image](https://github.com/user-attachments/assets/10cbbeb6-1057-4d57-8dbb-525295a3644e)
![image](https://github.com/user-attachments/assets/49c3c044-7b60-43df-9075-b4fb320cbee9)
![image](https://github.com/user-attachments/assets/4375a9dc-0711-4c06-aa3a-b2eda296332d)


</div>

<div align="center">
    <h1>Installation 💫</h1>
</div>

## Dependencies

- get the newest [Hyprland](https://hyprland.org/):

  ```zsh
  yay -S hyprland-git
  ```

### Base setups 💻:

- Install waybar, Rofi, Dunst, kitty terminal, swww, swaylock-fancy:

```
yay -S waybar-hyprland rofi dunst kitty swww-git swaylock-fancy-git
```

### Fonts 🔑:

- [JetBrains Mono Nerd Font](https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/JetBrainsMono.zip)
- [NotoColorEmoji](https://github.com/googlefonts/noto-emoji/raw/main/fonts/NotoColorEmoji.ttf)

download them and unpack them, place them into `~/.local/share/fonts.`

then run this command to see the newly installed fonts.

```
fc-cache -fv
```

## Copy Files 💾

```
git clone https://github.com/svxf/dotfiles
cd dotfiles
cp -r ./configs/* ~/.config/
```
