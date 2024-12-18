# SOC_design

## Gpio_example
### Hardware setup

- This SOC design is created to provide a general implementation of how the software will access hardware and vice versa. A brief explanation is as follows:
- As shown in the figure, the Axi-GPIO IP block is connected to the Zynq processor block via the Axi Interconnect block. The Zynq block allocates a specific address range, with a default size of 64KB for the block. This address range can be modified in the Address Editor tab in Xilinx Vivado.
- After all the IPs in the block design are connected, first check the block design's validation to ensure the buses are properly connected and their properties are validated.
- Next, generate the wrapper from the block design, which creates a new top-level VHDL file.
- Finally, run synthesis, followed by implementation, and then generate the bitstream. Once these steps are completed, the hardware design can be considered finished.

![seq_det](https://github.com/DineshReddy2k/SOC_design/blob/main/Gpio_example/gpio_example.png)

### Software setup
- Once the bitstream is generated, it must be exported to Xilinx Vitis. This is typically an XSA file, which contains both the hardware description and the bitstream.
- Create an empty application by selecting the appropriate processor (ARM Cortex-A9).
- After the project is successfully created, you need to write a driver to access the GPIO. Xilinx provides a driver for this purpose, which can be used by adding the xgpio.h header file along with the xparameters.h header file.
- The software code sequence involves initializing and configuring the GPIO, followed by writing values to or reading values from the GPIO.
- After writing the code, build and program the FPGA. Finally, run the application.

