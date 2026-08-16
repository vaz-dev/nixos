{ config, pkgs, ... }:
{	
	environment.systemPackages = with pkgs; [
		helix
		wine
		git
		alacritty
		zellij
		gh
		appimage-run
		mako
		hyprpaper
		bolt-launcher
	];

	programs.firefox.enable = true;
	programs.steam = {
		enable =  true;
		remotePlay.openFirewall = true;
		dedicatedServer.openFirewall = true;
		extraPackages = with pkgs; [
			vulkan-loader
			libGL
			mesa
		];
	};
}
