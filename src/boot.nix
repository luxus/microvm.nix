{
  initrd.availableKernelModules = [ "ata_piix" "uhci_hcd" "xen_blkfront" "vmw_pvscsi" ];
  initrd.kernelModules = [ "nvme" ];
  tmp.cleanOnBoot = true;
}
