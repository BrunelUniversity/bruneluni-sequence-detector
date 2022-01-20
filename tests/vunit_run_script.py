from pathlib import Path
from vunit import VUnit
import os

vu = VUnit.from_argv()
lib = vu.add_library("lib")
lib.add_source_files(f"{os.path.dirname(os.path.realpath(__file__))}/../src/*.vhd")
lib.add_source_files(f"{os.path.dirname(os.path.realpath(__file__))}/../tests/*.vhd")
vu.main()