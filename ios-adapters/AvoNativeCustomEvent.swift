import Foundation
import MoPub
import AvocarrotSDK
@objc(AvoNativeCustomEvent)
open class AvoNativeCustomEvent: MPNativeCustomEvent {

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
	open override func requestAd(withCustomEventInfo info: [AnyHashable: Any]!) {

		guard let apiKey = (info["apiKey" as NSObject] as? String) else { reportError("No Api key!"); return }
		guard let placementKey: String = (info["placementKey" as NSObject] as? String) else { reportError("No placement key!"); return }

		let avoCustom = AvocarrotCustom(apiKey: apiKey, placementKey: placementKey, mediationType: .mopub)
		avoCustom.onAdLoaded { (ads: [AdModel]) in
			let ad = ads.first!
			self.avoCustomAdapter = AvoCustomAdapter(avocarrotCustom: avoCustom, ad: ad)

			let mopubAd = MPNativeAd(adAdapter: self.avoCustomAdapter)

			let images = self.getImageUrls(urlStrings: [ad.getIcon(),ad.getImage()])
            

			super.precacheImages(withURLs: images, completionBlock: { (error: [Any]?) in
				if ((error) != nil) {
					self.delegate.nativeCustomEvent(self, didFailToLoadAdWithError: MPNativeAdNSErrorForImageDownloadFailure())
				} else {
					self.delegate.nativeCustomEvent(self, didLoad: mopubAd)
				}
			})

		}.onAdError { (error: AdError) in
			if (error.getCode() == StatusCode.noAdServed.code) {
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
		}.withSandbox(true)
        .loadAd()

	}

	func reportError(_ msg: String) {
		delegate.nativeCustomEvent(self, didFailToLoadAdWithError: MPNativeAdNSErrorForInvalidAdServerResponse(msg))
	}
    
    /**
     Removes escape characters from the `urlString` and return an URL object.
     
     - Parameter urlString: string of the url
     - Returns: URL object
     */
    func escapeUrl(urlString:String) -> URL?  {
        guard let escapedUrl = urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) else {
            return nil
        }
        
        return  URL(string: escapedUrl)
    }
    
    /**
     Transforms string urls to URL objects.
     
     - Parameter urlStrings: array of string urls
     - Returns: URL array object

    */
    func getImageUrls(urlStrings:[String]) -> [URL] {
        var images = [URL]()
        for urlString in urlStrings {
            if urlString.isEmpty {
                continue
            }
            var url = URL(string: urlString)
            
            if url == nil {
                url = escapeUrl(urlString: urlString)
            }
            
            guard let safeUrl = url  else {
                continue
            }
            
            images.append(safeUrl)
            
        }
        return images
    }
    

}
