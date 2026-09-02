# LrCBarcodes

A barcode-reading plug-in for **Adobe Lightroom Classic**. It scans photos for
barcodes (QR, Code 128, EAN, etc.), writes the detected type and value into
custom metadata fields, and can then propagate that value into standard fields
like Copy Name or Title — the workflow that makes bulk renaming from barcode
cards possible.

## Credits

This repository is a derivative of
[Okomikeruko/LrCBarcodes](https://github.com/Okomikeruko/LrCBarcodes)
by **Lee Whittaker**, released under the MIT License. That project was itself
an effort to recreate the discontinued
[LR Barcodes](https://www.capturemonkey.com/barcodes/) plug-in from
Capture Monkey, which stopped receiving updates in 2017.

All original copyright notices are preserved in [LICENSE](LICENSE).

## Requirements

- Adobe Lightroom Classic 12.0.1 or later — targets SDK 15.0, verified against
  Lightroom Classic **15.5.1**
- macOS (the plug-in shells out to a bundled `zbarimg` binary)

## Installation

1. Clone or download this repository.
2. In Lightroom Classic, open **File → Plug-in Manager**
   (`⌘ ⌥ ⇧ ,` on macOS, `Ctrl Alt Shift ,` on Windows).
3. Click **Add**, select the `LrCBarcodes.lrdevplugin` folder, and confirm.

## Usage

Two commands appear under **File → Plug-in Extras**:

| Command | What it does |
| --- | --- |
| **Run Barcode Detection** | Scans photos, storing `Barcode Type` and `Barcode Value` in plug-in metadata. |
| **Metadata Propagation** | Copies a source field (e.g. Barcode Content) into a destination field (e.g. Copy Name), optionally in limited sections. |

Detected values show up in the Library module's metadata panel via the
plug-in's own tagset.

## Changes from upstream

- **Own plug-in identifier.** Upstream declared
  `com.adobe.lightroom.sdk.lrcbarcodes`, inherited from the SDK's HelloWorld
  sample; the SDK guide reserves `com.adobe.*` for Adobe's own plug-ins. Now
  `org.wsmetros.lrcbarcodes`.
- **Barcode fields now appear in the Metadata panel.** The tagset referenced
  its fields as `lrcBarcodes.barcodeType` / `lrcBarcodes.barcodeValue` — the
  tagset's own `id` used as the prefix. The SDK addresses plug-in fields as
  `<LrToolkitIdentifier>.<field id>`, and unmatched references are silently
  omitted rather than erroring, so the two barcode fields never rendered.
- **Explicit `LrSdkMinimumVersion = 5.0`** alongside `LrSdkVersion = 15.0`.
  The minimum defaults to `LrSdkVersion`, so raising the latter on its own
  would have restricted the plug-in to Lightroom Classic 15 and newer. The
  effective minimum is unchanged from upstream.
- **Added `VERSION` and `LrPluginInfoUrl`** so the Plug-in Manager shows a
  version number and a link back to this repository.

Note that the new identifier namespaces the custom metadata separately from
upstream's build. Barcode values written by the original plug-in are not
visible to this one.

## Known issues

These are inherited from upstream and are the obvious first things to fix:

- **Bundled binaries are Intel-only.** `bin/zbarimg` and `lib/libzbar.0.dylib`
  are x86_64 Mach-O builds from 2022. On Apple Silicon they require Rosetta 2.
  Replacing them with native `arm64` builds (or a universal binary) from a
  current `zbar` is the recommended fix.
- **Paths are not quoted when shelling out.** `RunBarcodeDetection.lua` builds
  its `io.popen` command by concatenating the photo path directly, so any file
  or folder name containing a space fails to scan.
- **Detection always scans the entire catalog.** It calls
  `catalog:getAllPhotos()` rather than the current selection, which is slow on
  large catalogs and offers no way to limit scope.
- **Only the first barcode per image is recorded.** The XML parsing uses simple
  string matching and stops at the first `<symbol>` element.

## License

MIT — see [LICENSE](LICENSE).
