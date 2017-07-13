import UIKit
import AvocarrotSDK
import GoogleMobileAds

@objc(AvocarrotMediatedNativeContentAd)
open class AvocarrotMediatedNativeContentAd: NSObject {

    var nativeAd: AVONativeAssets

    public init(nativeAd: AVONativeAssets) {
        self.nativeAd = nativeAd
    }

}

extension AvocarrotMediatedNativeContentAd: GADMediatedNativeContentAd {

    public func headline() -> String? {
        return nativeAd.title
    }

    public func body() -> String? {
        return nativeAd.title
    }

    public func images() -> [Any]? {
        var gadImage: GADNativeAdImage?

        if let image = nativeAd.image {
            gadImage = GADNativeAdImage(image: image)
        } else if let imageURL = nativeAd.imageURL {
            gadImage = GADNativeAdImage(url: URL(string: imageURL)!, scale: 1)
        }
        return gadImage != nil ? [gadImage!] : nil
    }

    public func logo() -> GADNativeAdImage? {
        var gadImage: GADNativeAdImage?

        if let image = nativeAd.icon {
            gadImage = GADNativeAdImage(image: image)
        } else if let imageURL = nativeAd.iconURL {
            gadImage = GADNativeAdImage(url: URL(string: imageURL)!, scale: 1)
        }
        return gadImage != nil ? gadImage : nil
    }

    public func callToAction() -> String? {
        return nativeAd.callToActionTitle
    }

    public func advertiser() -> String? {
        return nativeAd.sponsored
    }

    public func extraAssets() -> [AnyHashable : Any]? {
        return nil
    }

    public func mediatedNativeAdDelegate() -> GADMediatedNativeAdDelegate? {
        return self
    }

}

extension AvocarrotMediatedNativeContentAd: GADMediatedNativeAdDelegate {
    public func mediatedNativeAd(_ mediatedNativeAd: GADMediatedNativeAd, didRenderIn view: UIView, viewController: UIViewController) {
        nativeAd.registerView(forInteraction: view, forClickableSubviews: nil)
    }

}
