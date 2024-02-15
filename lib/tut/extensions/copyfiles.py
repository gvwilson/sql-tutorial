"""Copy files verbatim from source directory to destination."""

import ark
from pathlib import Path
from shutil import copyfile


@ark.events.register(ark.events.Event.INIT)
def copy_files():
    """Copy files."""
    for whence in ark.site.config["copydir"]:
        src_dir = Path(ark.site.home(), whence)
        out_dir = Path(ark.site.out(), whence)
        for pat in ark.site.config.get("copy", []):
            for src_file in src_dir.glob(f"**/{pat}"):
                out_file = str(src_file).replace(str(src_dir), str(out_dir), 1)
                Path(out_file).parent.mkdir(exist_ok=True, parents=True)
                copyfile(src_file, out_file)
