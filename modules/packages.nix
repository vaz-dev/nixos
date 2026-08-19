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
		networkmanagerapplet
		rofi
		fastfetch
		discord
		spotify
		evince
		grim
		slurp
		nautilus
		thunderbird
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

	programs.appimage.enable = true;
	programs.appimage.binfmt = true;
}
