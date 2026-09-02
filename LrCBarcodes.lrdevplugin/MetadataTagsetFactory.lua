-- Custom metadata fields are addressed in a tagset as
-- '<LrToolkitIdentifier>.<field id>'. Upstream prefixed them with this
-- tagset's own id instead, so Lightroom found no matching plug-in fields and
-- silently omitted them from the panel.
return {
    title = "LrC Barcode Metadata",
    id = "org.wsmetros.lrcbarcodes.tagset",
    items = {
        'org.wsmetros.lrcbarcodes.barcodeType',
        'org.wsmetros.lrcbarcodes.barcodeValue',

        'com.adobe.separator',

        'com.adobe.title',
        'com.adobe.caption',
        'com.adobe.copyname',
        'com.adobe.label',

        'com.adobe.separator',

        'com.adobe.headline',
        'com.adobe.personShown'
    }
}
