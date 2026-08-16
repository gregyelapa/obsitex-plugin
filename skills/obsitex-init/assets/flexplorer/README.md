# Bundled plugin: Flexplorer 4.0.5

Snapshot of the Obsidian community plugin **Flexplorer** by [kh4f](https://github.com/kh4f)
(MIT license, see `LICENSE`), bundled so the scaffold can pre-install it into the target
vault's `.obsidian/plugins/flexplorer/` folder (see `SKILL.md`, "Install the Flexplorer
plugin").

Why: Obsidian's core file explorer always lists folders above files, so the visible order
does not match the alphabetical document order of the scaffold. Flexplorer shows the true
order and lets users reorder files per drag & drop — the ordering mechanism the Obsitex
app recommends.

- Source: https://github.com/kh4f/flexplorer/releases/tag/4.0.5 (2026-06-24)
- SHA256 (verified at download, 2026-07-20):
  - `main.js` — `63f9637f90a7706f14bb53d1e19bd6d55be0d34c7c2c00890f4bb9c4899e472d`
  - `manifest.json` — `4a87d8f905dd8380d0e383e75f204b4b6784629e03b2b935f49323086deba412`
  - `styles.css` — `57d4c010c5727f342ff7ee1b84839d158b3cc99078b1451c24cfbfc6adfb20dc`

## Why the scaffold also writes a seed `data.json`

Flexplorer ships with `newItemPlacement: "top"` and assigns every folder it first meets a
`custom` sort order with an empty list. On its first sync it therefore *prepends* each file
it discovers, so a freshly scaffolded vault shows up **completely reversed** — and because
Flexplorer sorts per folder, the user would have to correct every folder by hand. The skill
therefore seeds the order (see `SKILL.md`, "Seed the Flexplorer order"); the plugin owns the
file from the first Obsidian session onwards.

The pinned version does not need to chase upstream releases: the plugin id is registered
in the official community store, so Obsidian's own plugin manager offers updates once the
user has enabled the plugin. Refresh this snapshot only occasionally (maintenance
contract) or when a newer version is required for compatibility.
