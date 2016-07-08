<img width="300" src="https://cloud.githubusercontent.com/assets/1907604/7618436/f8c371de-f9a9-11e4-8846-772f67f53513.jpg"/>


# ios-adapters
Example project on how to use the Avocarrot SDK with other Ad Networks, in your iOS projects.

For any technical help or questions, please get in touch with [support](https://app.avocarrot.com/#/docs/contact)

## Contents
* [Mopub](#mopub)
  * [1. Setup SDKs](#1-setup-sdks)
  * [2. Setup Mopub Dashboard](#2-setup-mopub-dashboard)
  * [3. Native ad Units](#3-native-ad-units)
  * [4. Ready to GO!](#4-ready-to-go)
* [Troubleshooting](#troubleshooting)

===

### Mopub
You can use **Avocarrot** as a `Network` in **Mopub's** Mediation platform.

===

#### 1. Setup SDKs

* Integrate with Mopub SDK (https://github.com/mopub/mopub-ios-sdk/wiki/Getting-Started)
* Install Avocarrot SDK  [(Download SDK)](http://s3.amazonaws.com/avocarrot_ios/Avocarrot-iOS-sdk.zip) <br/>
*More info how to install Avocarrot SDK on [Document Section](https://app.avocarrot.com/#/docs/getting-started/ios)*   

===

#### 2. Setup Mopub Dashboard

Create an "Avocarrot" `Network` in Mopub's dashboard and connect it to your Ad Units.

* In Mopub's dashboard select `Networks`  > `Add New network`

![_networks](https://cloud.githubusercontent.com/assets/1907604/8231788/d78cf0dc-15c2-11e5-9bce-ed3e1e056325.png)

* Then select `Custom Native Network`

![_add-new-network](https://cloud.githubusercontent.com/assets/1907604/8231640/d721a6ac-15c1-11e5-892e-a317787adc9e.png)

* Complete the fields accordingly to the Ad Unit that you want to use

![_setup](https://cloud.githubusercontent.com/assets/13979135/16683207/4c79cb30-4507-11e6-8c3c-e235da3f2f8b.png)

===


#### 3) Native ad Units
For Native Ad Units you need to :

- Complete the following in Mopub Dashboard:

**Custom Event Class**
```javascript
AvoNativeCustomEvent
```

**Custom Event Class Data**
```javascript
{"apiKey":"<AvocarrotApiKey>","placementKey":"<AvocarrotPlacementKey>"}
```

Get your api & placement keys from the [Avocarrot Dashboard](https://app.avocarrot.com/#/apps/overview).
Please note that for `Mopub Native` you should create an `Avocarrot "Create your own"` placement.

- Include [`AvoNativeCustomEvent`](https://github.com/Avocarrot/ios-adapters/blob/master/ios-adapters/AvoNativeCustomEvent.swift) and [`AvoCustomAdapter`](https://github.com/Avocarrot/ios-adapters/blob/master/ios-adapters/AvoCustomAdapter.swift) in your project.

===

#### 4. Ready to GO!

Congratulations! You have now successfully integrated **Avocarrot** and you should have received your first ad.

#### Troubleshooting

- Please have in mind, that any time you make a change to the Mopub dashboard, try to fetch an ad a couple times and then wait a few minutes for Mopub's cache to clear.
- You can also try cloning the example project below to make sure everything is running ok
- If at any point you need any technical help, please get in touch with [support] (https://app.avocarrot.com/#/docs/contact)

### Clone the Example Project
* git clone https://github.com/Avocarrot/ios-adapters.git
