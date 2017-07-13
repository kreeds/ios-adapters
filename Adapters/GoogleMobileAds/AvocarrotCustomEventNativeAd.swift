import UIKit
import AvocarrotSDK
import GoogleMobileAds

@objc(AvocarrotCustomEventNativeAd)
class AvocarrotCustomEventNativeAd: NSObject, GADCustomEventNativeAd {
    weak var delegate: GADCustomEventNativeAdDelegate?

    func request(withParameter serverParameter: String,
                 request: GADCustomEventRequest,
                 adTypes: [Any],
                 options: [Any],
                 rootViewController: UIViewController) {

        AvocarrotSDK.shared.loadNativeAd(withAdUnitId: serverParameter,
                                      success: { (nativeAssers) -> UIView? in
                                        let mediatedAd = AvocarrotMediatedNativeContentAd(nativeAd: nativeAssers)
                                        self.delegate?.customEventNativeAd(self, didReceive: mediatedAd)
            return nil
        }) { (error) in
            self.delegate?.customEventNativeAd(self, didFailToLoadWithError: error)
        }

    }

    func handlesUserClicks() -> Bool {
        return false
    }

    func handlesUserImpressions() -> Bool {
        return false
    }

}
