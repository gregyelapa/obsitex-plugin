#!/usr/bin/env bash
#
# Publish the current state of this repo to the PUBLIC repo, as one commit.
#
#   bash tools/publish-release.sh --dry-run    show what would be published
#   bash tools/publish-release.sh              publish
#
# This repo (private) keeps the full history. The public repo gets one commit
# per published release — never the intermediate versions. The public history
# is appended to, never rewritten: installed users update by pulling, and a
# rewritten history would break that.
#
set -euo pipefail

SOURCE_REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
RELEASE_CLONE="${OBSITEX_RELEASE_CLONE:-/c/Users/gmass/dev/ObsitexPluginRelease}"
PUBLIC_REPO="gregyelapa/obsitex-plugin"

DRY_RUN=0
[ "${1:-}" = "--dry-run" ] && DRY_RUN=1

# read with sed, not node: node on Windows cannot resolve an MSYS-style /c/… path
VERSION="$(sed -n 's/.*"version"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' \
  "$SOURCE_REPO/.claude-plugin/plugin.json" | head -1)"
[ -n "$VERSION" ] || { echo "ABBRUCH: no version found in plugin.json" >&2; exit 1; }
echo "Version in plugin.json: $VERSION"

# the working tree must be clean — we publish what is committed, not what is lying around
if [ -n "$(git -C "$SOURCE_REPO" status --porcelain)" ]; then
  echo "ABBRUCH: uncommitted changes in $SOURCE_REPO — commit and push them first." >&2
  git -C "$SOURCE_REPO" status --short >&2
  exit 1
fi

# 1) release clone of the public repo, reset to its current state
if [ ! -d "$RELEASE_CLONE/.git" ]; then
  echo "Cloning $PUBLIC_REPO to $RELEASE_CLONE …"
  git clone -q "https://github.com/$PUBLIC_REPO.git" "$RELEASE_CLONE"
  git -C "$RELEASE_CLONE" config core.longpaths true
fi
git -C "$RELEASE_CLONE" fetch -q origin main
git -C "$RELEASE_CLONE" checkout -q main
git -C "$RELEASE_CLONE" reset -q --hard origin/main

# 2) replace its contents with the current tree of the source repo
git -C "$RELEASE_CLONE" rm -rq --cached . >/dev/null
find "$RELEASE_CLONE" -mindepth 1 -maxdepth 1 -not -name '.git' -exec rm -rf {} +
git -C "$SOURCE_REPO" archive HEAD | tar -x -C "$RELEASE_CLONE"
git -C "$RELEASE_CLONE" add -A

if git -C "$RELEASE_CLONE" diff --cached --quiet; then
  echo "Nothing to publish — the public repo already matches this state."
  exit 0
fi

echo
echo "Would publish these changes to $PUBLIC_REPO:"
git -C "$RELEASE_CLONE" diff --cached --stat

if [ "$DRY_RUN" = "1" ]; then
  echo
  echo "(dry run — nothing pushed)"
  git -C "$RELEASE_CLONE" reset -q --hard origin/main
  exit 0
fi

# 3) one commit, one tag, push
git -C "$RELEASE_CLONE" commit -q -m "Release v$VERSION"
git -C "$RELEASE_CLONE" tag -f "v$VERSION"
git -C "$RELEASE_CLONE" push -q origin main
git -C "$RELEASE_CLONE" push -qf origin "v$VERSION"
echo
echo "Published: v$VERSION → https://github.com/$PUBLIC_REPO"
