from __future__ import annotations

import json
import re
import subprocess
import tempfile
import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
SKILL = ROOT / ".agents/skills/ai-company-setup"
INIT = SKILL / "scripts/init-ai-company.sh"
BOOTSTRAP = SKILL / "scripts/bootstrap-v2-template.sh"


class ClawEmpireSetupTest(unittest.TestCase):
    def test_new_company_gets_generic_claw_empire_setup(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            base = Path(temp)
            destination = base / "sample-company"
            config = base / "setup.json"
            config.write_text(
                json.dumps(
                    {
                        "destinationRoot": str(destination),
                        "companySlug": "sample-company",
                        "workspaceName": "Sample AI Company",
                        "ownerName": "Sample Owner",
                        "ownerEmail": "owner@example.test",
                        "migrationMode": "COPY_ONLY",
                        "language": "ja",
                    }
                ),
                encoding="utf-8",
            )
            subprocess.run(
                ["bash", str(INIT), "--config", str(config)],
                cwd=ROOT,
                check=True,
                capture_output=True,
                text=True,
            )

            setup = destination / "00-setup/claw-empire"
            for name in {
                "CLAW_EMPIRE_SETUP.md",
                "install-claw-empire.sh",
                "sync-claw-empire.mjs",
                "claw-empire.config.example.json",
            }:
                self.assertTrue((setup / name).is_file(), name)
            routing = json.loads(
                (destination / "03-AI_departments/company-routing.json").read_text(
                    encoding="utf-8"
                )
            )
            self.assertEqual(len(routing["divisions"]), 3)
            self.assertIn(".ai-company-local/", (destination / ".gitignore").read_text())

            result = subprocess.run(
                [
                    "node",
                    str(setup / "sync-claw-empire.mjs"),
                    "init",
                    "--config",
                    str(destination / ".ai-company-local/claw-empire.json"),
                    "--company-root",
                    str(destination),
                ],
                check=True,
                capture_output=True,
                text=True,
            )
            self.assertIn("claw-empire.json", result.stdout)
            directory = subprocess.run(
                [
                    "node",
                    str(setup / "sync-claw-empire.mjs"),
                    "directory",
                    "--config",
                    str(destination / ".ai-company-local/claw-empire.json"),
                ],
                check=True,
                capture_output=True,
                text=True,
            )
            self.assertEqual(
                json.loads(directory.stdout),
                {"divisions": 3, "characters": 3, "provider": "codex"},
            )
            self.assertIn(
                '"nameJa": "プロダクトチーム"',
                (destination / "03-AI_departments/company-routing.json").read_text(
                    encoding="utf-8"
                ),
            )

    def test_bootstrap_does_not_overwrite_existing_routing(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            destination = Path(temp)
            routing = destination / "03-AI_departments/company-routing.json"
            routing.parent.mkdir(parents=True)
            routing.write_text('{"keep":"existing"}\n', encoding="utf-8")
            subprocess.run(
                ["bash", str(BOOTSTRAP), "--dest", str(destination)],
                cwd=ROOT,
                check=True,
                capture_output=True,
                text=True,
            )
            self.assertEqual(
                json.loads(routing.read_text(encoding="utf-8")),
                {"keep": "existing"},
            )

    def test_shared_assets_have_no_personal_path_or_secret(self) -> None:
        text = "\n".join(
            path.read_text(encoding="utf-8")
            for path in (SKILL / "assets/claw-empire").iterdir()
            if path.is_file()
        )
        self.assertNotIn("/Users/kimurataiyou", text)
        self.assertIsNone(re.search(r"sk-[A-Za-z0-9_-]{20,}", text))
        subprocess.run(
            ["bash", "-n", str(SKILL / "assets/claw-empire/install-claw-empire.sh")],
            check=True,
        )
        installer = (
            SKILL / "assets/claw-empire/install-claw-empire.sh"
        ).read_text(encoding="utf-8")
        self.assertIn("66a24ea7df2435ef897c48c147deb7ec572c01c2", installer)
        self.assertIn("pnpm build", installer)


if __name__ == "__main__":
    unittest.main()
