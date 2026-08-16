{ config, pkgs, ... }:
{	
	networking.hostName = "rebel";
	networking.networkmanager.enable = true;
}
