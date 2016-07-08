import Foundation
//import mopub_ios_sdk
import mopub_ios_sdk
import AvocarrotSDK
@objc(AvoNativeCustomEvent)
public class AvoNativeCustomEvent: MPNativeCustomEvent {

	var avoCustomAdapter: AvoCustomAdapter?

	/** @name Requesting a Native Ad */

	/**
	 * Called when the MoPub SDK requires a new native ad.
	 *
	 * When the MoPub SDK receives a response indicating it should load a custom event, it will send
	 * this message to your custom event class. Your implementation should load a native ad from a
	 * third-party ad network.
	 *
	 * @param info A dictionary containing additional custom data associated with a given custom event
	 * request. This data is configurable on the MoPub website, and may be used to pass dynamic
	 * information, such as publisher IDs.
	 */
	public override func requestAdWithCustomEventInfo(info: [NSObject: AnyObject]!) {

		guard let apiKey = (info["apiKey" as NSObject] as? String) else { reportError("No Api key!"); return }
		guard let placementKey: String = (info["placementKey" as NSObject] as? String) else { reportError("No placement key!"); return }

		let avoCustom = AvocarrotCustom(apiKey: apiKey, placementKey: placementKey, mediationType: .Mopub)
		avoCustom.onAdLoaded { (ads: [AdModel]) in
			let ad = ads.first!
			self.avoCustomAdapter = AvoCustomAdapter(avocarrotCustom: avoCustom, ad: ad)

			let mopubAd = MPNativeAd(adAdapter: self.avoCustomAdapter)

			var images = [NSURL]()
			if !ad.getIcon().isEmpty {
				images.append(NSURL(string: ad.getIcon())!)
			}

			if !ad.getImage().isEmpty {
				images.append(NSURL(string: ad.getImage())!)
			}

			super.precacheImagesWithURLs(images, completionBlock: { (error: [AnyObject]!) in
				if ((error) != nil) {
					self.delegate.nativeCustomEvent(self, didFailToLoadAdWithError: MPNativeAdNSErrorForImageDownloadFailure())
				} else {
					self.delegate.nativeCustomEvent(self, didLoadAd: mopubAd)
				}
			})

		}.onAdError { (error: AdError) in
			if (error.getCode() == StatusCode.NoAdServed.code) {
				self.delegate.nativeCustomEvent(self, didFailToLoadAdWithError: MPNativeAdNSErrorForNoInventory())
			} else {
				self.reportError("Avocarrot ad load error!")
			}
		}.onAdImpression {
			self.avoCustomAdapter?.registerImpressionToMopub()
		}.onAdClickRegistered {
			self.avoCustomAdapter?.registerClickToMopub()
		}.onAdWebViewClosed {
			self.avoCustomAdapter?.registerFinishHandlingClickToMopub()
		}.withLogging(true, logLevel: LogLevel.Debug)
			.withSandbox(false)
			.loadAd()

	}

	func reportError(msg: String) {
		delegate.nativeCustomEvent(self, didFailToLoadAdWithError: MPNativeAdNSErrorForInvalidAdServerResponse(msg))
	}

}