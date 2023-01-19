
gdt:
    null_descriptor             :   dw 0, 0, 0, 0 ; each descriptor is 8 bytes long and word in x86 is 2 bytes long
    kernel_code_descriptor      :   dw 0xffff, 0x0000, 0x9a00, 0x00cf
    kernel_data_descriptor      :   dw 0xffff, 0x0000, 0x9200, 0x00cf
    userspace_code_descriptor   :   dw 0xffff, 0x0000, 0xfa00, 0x00cf
    userspace_data_descriptor   :   dw 0xffff, 0x0000, 0xf200, 0x00cf
    tss_descriptor				:	dw tss + 3, tss, 0x8900, 0x0000; task state segment

gdtr:
    gdt_size_in_bytes   :   dw ( 6 * 8 )
    gdt_base_address    :   dd gdt ; complete physical address of gdt
 