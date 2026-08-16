{ config, lib, pkgs, ... }:

{
	nixpkgs.config.allowUnfree = true;
	nix.settings.experimental-features = [ "nix-command" "flakes" ];

	imports = [
		./hardware-configuration.nix
		./modules/boot.nix
		./modules/users.nix
		./modules/networking.nix
		./modules/desktop.nix
		./modules/nvidia.nix
		./modules/packages.nix
	];
	


	time.timeZone = "America/Sao_Paulo";
	i18n.defaultLocale = "en_US.UTF-8";

	services.pipewire = {
		enable = true;
		pulse.enable = true;
	};


	system.stateVersion = "26.05";
}
