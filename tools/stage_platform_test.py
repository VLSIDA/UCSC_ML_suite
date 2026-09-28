#!/usr/bin/env python3

import json
import sys
import tempfile
import unittest
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))

from stage_platform import SOURCE_FILE, stage_platform


class StagePlatformTest(unittest.TestCase):
    def test_stages_platform_common_files_and_dereferences_symlinks(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            source = root / "orfs" / "flow" / "platforms"
            (source / "common").mkdir(parents=True)
            (source / "common" / "common.v").write_text("module common; endmodule\n")
            (source / "asap7").mkdir()
            (source / "asap7" / "config.mk").write_text("export PLATFORM = asap7\n")
            (source / "asap7" / "cells.lib").write_text("library(cells) {}\n")
            (source / "asap7" / "cells-link.lib").symlink_to("cells.lib")
            (root / "orfs" / "LICENSE").write_text("ORFS license\n")

            destination = root / "export" / "platforms"
            self.assertTrue(stage_platform(source, "asap7", destination, "abc123"))

            self.assertEqual(
                (destination / "common" / "common.v").read_text(),
                "module common; endmodule\n",
            )
            copied_link = destination / "asap7" / "cells-link.lib"
            self.assertFalse(copied_link.is_symlink())
            self.assertEqual(copied_link.read_text(), "library(cells) {}\n")
            self.assertEqual(
                (destination / "ORFS_LICENSE").read_text(), "ORFS license\n"
            )
            self.assertEqual(
                json.loads((destination / SOURCE_FILE).read_text())["source_id"],
                "abc123",
            )
            self.assertFalse(stage_platform(source, "asap7", destination, "abc123"))

    def test_replaces_a_previous_generated_platform_set_on_source_change(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            source = root / "orfs" / "flow" / "platforms"
            (source / "asap7").mkdir(parents=True)
            config = source / "asap7" / "config.mk"
            config.write_text("old\n")
            destination = root / "export" / "platforms"
            stage_platform(source, "asap7", destination, "old-source")

            config.write_text("new\n")
            self.assertTrue(stage_platform(source, "asap7", destination, "new-source"))
            self.assertEqual((destination / "asap7" / "config.mk").read_text(), "new\n")

    def test_will_not_replace_an_unowned_directory(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            source = root / "orfs" / "flow" / "platforms"
            (source / "asap7").mkdir(parents=True)
            (source / "asap7" / "config.mk").write_text("config\n")
            destination = root / "export" / "platforms"
            destination.mkdir(parents=True)
            (destination / "user-file").write_text("keep\n")

            with self.assertRaisesRegex(RuntimeError, "refusing to replace"):
                stage_platform(source, "asap7", destination, "source")


if __name__ == "__main__":
    unittest.main()
