
;; This is an operating system configuration generated
;; by the graphical installer.

(use-modules (gnu) (nongnu packages linux))
(use-service-modules desktop networking ssh xorg)

(operating-system
  (locale "en_US.utf8")
  (timezone "America/New_York")
  (keyboard-layout (keyboard-layout "us"))
  (host-name "ben-guix")
  (users (cons* (user-account
		  (name "benjamin")
		  (comment "Benjamin")
		  (group "users")
		  (home-directory "/home/benjamin")
		  (supplementary-groups
		    '("wheel" "netdev" "audio" "video")))
		%base-user-accounts))
  (packages
    (append
      (list (specification->package "emacs")
	    (specification->package "emacs-exwm")
	    (specification->package
	      "emacs-desktop-environment")
	    (specification->package "nss-certs"))
      %base-packages))
  (bootloader 
    (bootloader-configuration
		(bootloader grub-efi-bootloader)
		(target "/boot/efi")
		(keyboard-layout keyboard-layout)))
  (firmware (append
	      (list iwlwifi-firmware)
	      %base-firmware))
  (file-systems 
    (cons* (file-system
	     (mount-point "/")
	     (device (uuid "b2b96101-1af5-4204-98c0-c6c5a0a0fe21" 'ext4))
	     ;;(device (file-system-label "my-root"))
	     (type "ext4"))
	   (file-system
	     (mount-point "/boot/efi")
	     (device (uuid "0CBA-7E00" 'fat32))
	     (type "vfat"))
	   %base-file-systems))
  (services %desktop-services))



;;/dev/nvme0n1p6: LABEL="system-root" UUID="b2b96101-1af5-4204-98c0-c6c5a0a0fe21" BLOCK_SIZE="4096" TYPE="ext4" PARTLABEL="guixsd-partition" PARTUUID="672228d8-70e5-4e83-89de-10a90f68a7d3"
;;/dev/nvme0n1p1: LABEL="SYSTEM_DRV" UUID="0CBA-7E00" BLOCK_SIZE="512" TYPE="vfat" PARTLABEL="EFI system partition" PARTUUID="f1c109b6-fd89-46e5-976a-28c4f98ff913"
