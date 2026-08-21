{ config, pkgs, ... }:
{    
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    services.power-profiles-daemon.enable = true;
}
