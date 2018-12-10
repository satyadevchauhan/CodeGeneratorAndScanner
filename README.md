# CodeGeneratorAndScanner

## How to generate Bar code or QR code on iOS using native iOS APIs?

Using the CoreImage framework, one can easily generate Bar/QR Codes within an iOS app with very few lines of code. Using the CoreImage filter, specifically the 'CICode128BarcodeGenerator' for Bar code and ‘CIQRCodeGenerator‘ for QR Code filter, we can get a CIImage that can be convert to UIImage for usage. Please visit [Core Image Filter Reference](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html) for more information.

Following are supported [CICategoryGenerator](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/uid/TP30000136-SW142):
  - [CIAztecCodeGenerator](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CIAztecCodeGenerator)
  - [CICheckerboardGenerator](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CICheckerboardGenerator)
  - [CICode128BarcodeGenerator](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CICode128BarcodeGenerator)
  - [CIConstantColorGenerator](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CIConstantColorGenerator)
  - [CILenticularHaloGenerator](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CILenticularHaloGenerator)
  - [CIPDF417BarcodeGenerator](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CIPDF417BarcodeGenerator)
  - [CIQRCodeGenerator](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CIQRCodeGenerator)
  - [CIRandomGenerator](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CIRandomGenerator)
  - [CIStarShineGenerator](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CIStarShineGenerator)
  - [CIStripesGenerator](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CIStripesGenerator)
  - [CISunbeamsGenerator](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CISunbeamsGenerator)


### Bar Code Example
``` swift
  func generateBarCode(_ string: String) -> UIImage {
        
        if !string.isEmpty {
            
            let data = string.data(using: String.Encoding.ascii)
            
            let filter = CIFilter(name: "CICode128BarcodeGenerator")
            // Check the KVC for the selected code generator
            filter.setValue(data, forKey: "inputMessage")   
            
            let transform = CGAffineTransform(scaleX: 10, y: 10)
            let output = filter.outputImage?.transformed(by: transform)
            
            return UIImage(ciImage: output!)
        } else {
            return UIImage()
        }
  }

```

### QR Code Example
``` swift
  func generateQRCode(_ string: String) -> UIImage {
        
        if !string.isEmpty {
            
            let data = string.data(using: String.Encoding.ascii)
            
            let filter = CIFilter(name: "CIQRCodeGenerator")
            // Check the KVC for the selected code generator
            filter.setValue(data, forKey: "inputMessage")
            
            let transform = CGAffineTransform(scaleX: 10, y: 10)
            let output = filter.outputImage?.transformed(by: transform)
            
            return UIImage(ciImage: output!)
        } else {
            return UIImage()
        }
  }
    
```  

## How to scan Bar code or QR code on iOS using native iOS APIs?

Using AVFoundation framework we can scan all kinds of market leading bar code formats. Please visit [AVMetadataObject.ObjectType](https://developer.apple.com/documentation/avfoundation/avmetadataobject/objecttype) for all supported formats on iOS.

Following are supported scanning formats:
 - [AVMetadataObject.ObjectType.aztec](https://developer.apple.com/documentation/avfoundation/avmetadataobject/objecttype/1618809-aztec)
 - [AVMetadataObject.ObjectType.code128](https://developer.apple.com/documentation/avfoundation/avmetadataobject/objecttype/1618817-code128)
 - [AVMetadataObject.ObjectType.code39](https://developer.apple.com/documentation/avfoundation/avmetadataobject/objecttype/1618814-code39)
 - [AVMetadataObject.ObjectType.code39Mod43](https://developer.apple.com/documentation/avfoundation/avmetadataobject/objecttype/1618811-code39mod43)
 - [AVMetadataObject.ObjectType.code93](https://developer.apple.com/documentation/avfoundation/avmetadataobject/objecttype/1618829-code93)
 - [AVMetadataObject.ObjectType.dataMatrix](https://developer.apple.com/documentation/avfoundation/avmetadataobject/objecttype/1618802-datamatrix)
 - [AVMetadataObject.ObjectType.ean13](https://developer.apple.com/documentation/avfoundation/avmetadataobject/objecttype/1618807-ean13)
 - [AVMetadataObject.ObjectType.ean8](https://developer.apple.com/documentation/avfoundation/avmetadataobject/objecttype/1618822-ean8)
 - [AVMetadataObject.ObjectType.face](https://developer.apple.com/documentation/avfoundation/avmetadataobject/objecttype/1385845-face)
 - [AVMetadataObject.ObjectType.interleaved2of5](https://developer.apple.com/documentation/avfoundation/avmetadataobject/objecttype/1618825-interleaved2of5)
 - [AVMetadataObject.ObjectType.itf14](https://developer.apple.com/documentation/avfoundation/avmetadataobject/objecttype/1618831-itf14)
 - [AVMetadataObject.ObjectType.pdf417](https://developer.apple.com/documentation/avfoundation/avmetadataobject/objecttype/1618827-pdf417)
 - [AVMetadataObject.ObjectType.qr](https://developer.apple.com/documentation/avfoundation/avmetadataobject/objecttype/1618819-qr)
 - [AVMetadataObject.ObjectType.upce](https://developer.apple.com/documentation/avfoundation/avmetadataobject/objecttype/1618835-upce)
