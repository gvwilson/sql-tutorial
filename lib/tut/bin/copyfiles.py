"""Copy static files."""

from pathlib import Path
import shutil
import sys


USAGE = "usage: copyfiles.py destination_root source_directories extensions"

assert len(sys.argv) == 4, USAGE
dst_root = Path(sys.argv[1])
src_dirs = sys.argv[2].split()
exts = sys.argv[3].split()

assert dst_root.exists(), f"Destination directory {dst_root} does not exist"
for src_d in src_dirs:
    src_d = Path(src_d)
    dst_d = Path(dst_root, src_d)
    dst_d.mkdir(exist_ok=True)
    for x in exts:
        pat = f"*{x}"
        for src_f in Path(src_d).glob(pat):
            dst_f = Path(dst_d, src_f.name)
            shutil.copyfile(str(src_f), str(dst_f))
