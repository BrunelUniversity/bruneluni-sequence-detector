from pathlib import Path
from vunit import VUnit

vu = VUnit.from_argv()
lib = vu.add_library("lib")
lib.add_source_files(Path("src/*.vhd").resolve())
lib.add_source_files(Path("tests/*.vhd").resolve())
vu.main()