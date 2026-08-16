{ config, pkgs, ... }:
{    
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    programs.appimage.enable = true;
    programs.appimage.binfmt = true;
}
