#!/usr/bin/env bash
# Assemble docs/ from the repo's markdown, then build the MkDocs site.
#
# The guides live at the repo root (guides/, README.md, ...) so they read well
# on GitHub. MkDocs needs them under a single docs_dir, so we copy them into
# docs/ at build time. Relative links between guides are preserved because the
# directory structure is copied verbatim.
set -euo pipefail
cd "$(dirname "$0")/.."

rm -rf docs
mkdir -p docs

cp -r guides docs/guides
for f in README.md INTRODUCTION.md TABLE_OF_CONTENTS.md CHANGELOG.md CONTRIBUTING.md; do
  [ -f "$f" ] && cp "$f" "docs/$f"
done

# Working documents and agent instructions are not reader documentation.
rm -f docs/CLAUDE.md docs/DOCUMENTATION_REVIEW_PLAN.md \
      docs/PROMPT_ENGINEERING_PLAN.md docs/PROMPT_ENGINEERING_DOCS_SUMMARY.md

echo "Assembled docs/ ($(find docs -name '*.md' | wc -l) markdown files)"
exec python3 -m mkdocs "${@:-build}"
