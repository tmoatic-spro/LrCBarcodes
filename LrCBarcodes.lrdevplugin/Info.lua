return {
    -- Target the current Lightroom Classic SDK. Note that LrSdkMinimumVersion
    -- defaults to LrSdkVersion, so it is set explicitly below -- without it,
    -- raising LrSdkVersion would stop the plug-in loading in older releases.
    LrSdkVersion = 15.0,
    LrSdkMinimumVersion = 5.0,

    -- com.adobe.* is reserved for plug-ins written by Adobe; upstream inherited
    -- 'com.adobe.lightroom.sdk.lrcbarcodes' from the SDK's HelloWorld sample.
    LrToolkitIdentifier = 'org.wsmetros.lrcbarcodes',

    LrPluginName = "LrC Barcodes",
    LrPluginInfoUrl = 'https://github.com/tmoatic-spro/LrCBarcodes',

    VERSION = { major = 1, minor = 0, revision = 0, display = "1.0.0" },

    LrMetadataProvider = 'MetadataProvider.lua',
    LrMetadataTagsetFactory = 'MetadataTagsetFactory.lua',

    LrExportMenuItems = {
        {
            title = "Run Barcode Detection",
            file = "RunBarcodeDetection.lua"
        },
        {
            title = "Metadata Propagation",
            file = "MetadataPropagation.lua"
        }
    }
}
