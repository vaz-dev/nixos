{ config, pkgs, ... }:
{	
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

	# magically run AppImages
	boot.binfmt.registrations.appimage = {
	  wrapInterpreterInShell = false;
	  interpreter = "${pkgs.appimage-run}/bin/appimage-run";
	  recognitionType = "magic";
	  offset = 0;
	  mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
	  magicOrExtension = ''\x7fELF....AI\x02'';
	};
}
