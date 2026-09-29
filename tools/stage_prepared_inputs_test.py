import json
import sys
import tempfile
import unittest
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))

from stage_prepared_inputs import stage_prepared_inputs


class StagePreparedInputsTest(unittest.TestCase):
    def test_stages_inputs_without_manifest_by_default(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            source = root / "source"
            source.mkdir()
            rtl = source / "top.v"
            rtl.write_text("module top; endmodule\n")
            config = root / "config.mk"
            config.write_text(f"export VERILOG_FILES?={rtl}\n")

            stage_prepared_inputs(config, root / "inputs")

            self.assertFalse((root / "manifest.json").exists())
            rewritten = config.read_text()
            self.assertIn("$(PREPARED_INPUTS)/", rewritten)

    def test_writes_tool_neutral_design_and_platform_manifests(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            source = root / "source"
            source.mkdir()
            rtl = source / "top.v"
            rtl.write_text("module top; endmodule\n")
            sdc = source / "constraint.sdc"
            sdc.write_text("create_clock -period 10 [get_ports clk]\n")

            platform = root / "bundle" / "platforms" / "test45"
            for directory in ("lef", "lib", "gds"):
                (platform / directory).mkdir(parents=True, exist_ok=True)
            (platform / "lef" / "tech.lef").write_text("VERSION 5.8 ;\n")
            (platform / "lef" / "cells.lef").write_text("VERSION 5.8 ;\n")
            (platform / "lib" / "cells.lib").write_text("library(cells) {}\n")
            (platform / "gds" / "cells.gds").write_text("gds\n")
            (platform / "tapcell.tcl").write_text("# tapcells\n")
            (platform / "config.mk").write_text(
                "export PLATFORM = test45\n"
                "export TECH_LEF = $(PLATFORM_DIR)/lef/tech.lef\n"
                "export SC_LEF = $(PLATFORM_DIR)/lef/cells.lef\n"
                "export LIB_FILES = $(PLATFORM_DIR)/lib/cells.lib\n"
                "export GDS_FILES = $(PLATFORM_DIR)/gds/cells.gds\n"
                "export PLACE_SITE = test_site\n"
                "export TAPCELL_TCL = $(PLATFORM_DIR)/tapcell.tcl\n"
            )

            design = root / "bundle" / "designs" / "test45" / "example"
            design.mkdir(parents=True)
            config = design / "config.mk"
            config.write_text(
                "export DESIGN_NAME?=top\n"
                "export PLATFORM?=test45\n"
                "export CORE_UTILIZATION?=55\n"
                "export VERILOG_DEFINES?=-DSYNTHESIS\n"
                "export SYNTH_SLANG_ARGS?=--keep-this -Iexternal/include -DUSE_GENERIC\n"
                f"export SDC_FILE?={sdc}\n"
                f"export VERILOG_FILES?={rtl}\n"
            )

            manifest_path = design / "manifest.json"
            stage_prepared_inputs(
                config,
                design / "inputs",
                manifest=manifest_path,
                platform_dir=platform,
            )

            manifest = json.loads(manifest_path.read_text())
            self.assertEqual(manifest["schema_version"], 1)
            self.assertEqual(
                manifest["design"],
                {
                    "name": "top",
                    "platform": "test45",
                },
            )
            self.assertEqual(manifest["rtl"]["defines"], ["-DSYNTHESIS"])
            self.assertEqual(
                manifest["synthesis"]["slang_arguments"],
                ["--keep-this", "-DUSE_GENERIC"],
            )
            self.assertEqual(manifest["floorplan"]["core_utilization"], 55)
            self.assertNotIn("orfs", manifest)
            self.assertTrue((design / manifest["rtl"]["files"][0]).is_file())
            self.assertTrue((design / manifest["constraints"]["sdc"]).is_file())

            platform_manifest_path = design / manifest["platform_manifest"]
            platform_manifest = json.loads(platform_manifest_path.read_text())
            self.assertEqual(platform_manifest["platform"], "test45")
            self.assertEqual(
                platform_manifest["files"]["technology_lef"],
                ["lef/tech.lef"],
            )
            self.assertEqual(
                platform_manifest["files"]["liberty_files"],
                ["lib/cells.lib"],
            )
            self.assertEqual(platform_manifest["place_site"], "test_site")
            self.assertEqual(platform_manifest["scripts"]["tapcell"], "tapcell.tcl")
            self.assertNotIn("orfs", platform_manifest)


if __name__ == "__main__":
    unittest.main()
