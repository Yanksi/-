#!/usr/bin/env bash
# Fetch the academicpages template into this repo, preserving the
# customizations checked in at the root (_config.yml, _data/navigation.yml,
# _pages/about.md, _pages/cv.md, _pages/publications.html).
#
# After running, review `git status`, commit, and push.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WORK="$(mktemp -d)"
trap 'rm -rf "$WORK"' EXIT

echo "[bootstrap] cloning academicpages template into $WORK"
git clone --depth 1 https://github.com/academicpages/academicpages.github.io.git "$WORK/ap"

cd "$WORK/ap"

# Files / directories we do NOT want copied from upstream.
# These are either things we customize ourselves, or upstream-specific
# meta files (CI workflows, contributing guide, etc.).
EXCLUDE=(
  ".git" ".github"
  "_config.yml" "_data/navigation.yml"
  "_pages/about.md" "_pages/cv.md" "_pages/publications.html"
  # sample content we do not want
  "_publications" "_portfolio" "_talks" "_teaching" "_posts" "_drafts"
  "_pages/markdown.md" "_pages/cv-json.md" "_pages/non-menu-page.md"
  "_pages/talks.html" "_pages/teaching.html" "_pages/portfolio.html"
  "_pages/talkmap.html" "_pages/archive-layout-with-content.md"
  "_pages/year-archive.html" "_pages/category-archive.html"
  "_pages/tag-archive.html" "_pages/page-archive.html"
  "_pages/collection-archive.html" "_pages/terms.md" "_pages/sitemap.md"
  "_data/comments" "_data/cv.json" "_data/authors.yml"
  "talkmap.ipynb" "talkmap.py" "talkmap_out.ipynb" "talkmap" "markdown_generator"
  "images/themes" "images/editing-talk.png" "images/bio-photo.jpg"
  "images/bio-photo-2.jpg" "images/500x300.png"
  "files/bibtex1.bib" "files/paper1.pdf" "files/paper2.pdf" "files/paper3.pdf"
  "files/slides1.pdf" "files/slides2.pdf" "files/slides3.pdf"
  "README.md"
)

# Build the rsync exclude list.
RSYNC_EXCLUDES=()
for e in "${EXCLUDE[@]}"; do
  RSYNC_EXCLUDES+=(--exclude="$e")
done

echo "[bootstrap] copying template files into $REPO_ROOT"
rsync -a "${RSYNC_EXCLUDES[@]}" ./ "$REPO_ROOT/"

# Drop your CV PDF into files/ if you have one handy.
mkdir -p "$REPO_ROOT/files"

cat <<'EOF'

[bootstrap] done.

Remaining steps:
  1. Drop your CV PDF at files/cv.pdf (linked from /cv/).
  2. Optionally replace images/profile.png with your own avatar.
  3. Review the working tree with `git status`, then commit and push.
  4. Enable GitHub Pages: Settings -> Pages -> Deploy from a branch.

To preview locally: `bundle install && bundle exec jekyll serve -l -H 0.0.0.0`.
EOF
