{ config, pkgs, ... }:
{	
	environment.systemPackages = with pkgs; [
		helix
		wine
		git
		alacritty
		zellij
		gh
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
