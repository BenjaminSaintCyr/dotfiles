
;; This is an operating system configuration generated
;; by the graphical installer.

(use-modules (gnu) (nongnu packages linux))
(use-service-modules desktop networking ssh xorg)

(operating-system
  (locale "en_US.utf8")
  (timezone "America/New_York")
  (keyboard-layout (keyboard-layout "us"))
  (host-name "ben")
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
    (bootloader grub-bootloader)
    (target "/dev/sda")
    (keyboard-layout keyboard-layout)))
  (firmware (append
	      (list iwlwifi-firmware)
	      %base-firmware))
  (swap-devices
   (list (uuid "58c92de0-1480-4b50-9854-65ecf476f35c")))
  (file-systems
   (cons* (file-system
           (mount-point "/")
           (device
            (uuid "609cf06f-8258-41cc-87d9-c5452558e7fa"
                  'ext4))
           (type "ext4"))
          %base-file-systems))
  (services (append (list (service gnome-desktop-service-type)
                          (set-xorg-configuration
                           (xorg-configuration
                            (keyboard-layout keyboard-layout))))
                    %desktop-services)))

