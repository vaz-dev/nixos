{ config, pkgs, ... }:
{
  home.username = "vaz";
  home.homeDirectory = "/home/vaz";
  home.stateVersion = "26.05";
  programs.home-manager.enable = true;
  home.packages = [];
}
