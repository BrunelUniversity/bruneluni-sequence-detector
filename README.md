# start dev environment
- create new vivado project for the xilinx artix-7 device
- add all '.vhd' files in '/src' to the design sources
- add all '.vhd' files in '/tests' to the simulation sources
- set library for 'vunit_run_for_vivado.vhd' to vunit_lib
  - do this for each simulation set
- there are multiple test bench files within the /tests dir
  - create an invidual simulation set for each to simulate it
  - make sure to setup the vunit_run_for_vivado.vhd properly
# bruneluni-sequence-detector
sequence detector for the 'xilinx artix-7' fpga
# resources
- https://www.nandland.com/vhdl/examples/example-package.html
- https://vunit.github.io/user_guide.html
- https://www.csee.umbc.edu/portal/help/VHDL/attribute.html
