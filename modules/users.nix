{ config, pkgs, ... }:
{	
	users.users.vaz = {
		isNormalUser = true;
		extraGroups = [ "wheel" "networkmanager" "video" ];
		shell = pkgs.bash;
	};
}
