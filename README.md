# tpm2-setup


### tpm2 TSS/TOOLS/ABRMD/sikulator Dependency Version Chart

| tpm2-tools version | tpm2-tss version | tpm2-abrmd version| ibmtpm version|
|--------------------|------------------|-------------------|---------------|
|[master](https://github.com/keylime/tpm2-tools.git)|[1765642](https://github.com/tpm2-software/tpm2-tss.git)|[642ca16](https://github.com/tpm2-software/tpm2-abrmd.git)|[1119](http://sourceforge.net/projects/ibmswtpm2/files/ibmtpm1119.tar.gz/download)|


**Note**
Check out this [link](https://github.com/tpm2-software/tpm2-abrmd/blob/master/INSTALL.md#selinux) for more SELinux information.
`setenforce 0` would work but not suggested.

To run the tpm2 command in the shell with virtual machine set up and sofware tpm enable, follow the following steps.
Set the envrionment variable `TPM2TOOLS_TCTI` so that the tpm2-tools would user the resource manager to communicate with software-tpm2.
```
export TPM2TOOLS_TCTI="tabrmd:bus_name=com.intel.tss2.Tabrmd"
```

Start the software TPM server in the background
```
tpm_server &
```

Start the resource manager using the tss user accound, since tss is the owner of this server
```
sudo -u tss tpm2-abrmd --tcti=mssim
```

Use this command to start up TPM command line interface
```
tpm2_startup -c
```

Now TPM command is good to go. Let try this example
```
tpm2_getrandom 8
```
