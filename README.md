# Growth Message SDK for iOS

[Growth Message](https://message.growthbeat.com/) in-app message service for mobile apps.

## Usage 

1. Install [Growthbeat Core SDK](https://github.com/SIROK/growthbeat-core-ios).

1. Install [Growth Analytics SDK](https://github.com/SIROK/growthanalytics-ios).

1. Add GrowthMessage.framework into your project. 

1. Link SystemConfiguration.framework and AdSupport.framework

1. Import the framework header.

	```objc
	#import <GrowthMessage/GrowthMessage.h>
	```

1. Write initialization code

	```objc
	[[GrowthMessage sharedInstance] initializeWithApplicationId:@"APPLICATION_ID" credentialId:@"CREDENTIAL_ID"];
	```

1. Write following code in the place to display a message. You can choose the event to make a message on the Growth Message dashboard.

	```objc
	[[GrowthAnalytics sharedInstance] track:@"EVENT_NAME"];
	```

## Growthbeat Full SDK

You can use Growthbeat SDK instead of this SDK. Growthbeat is growth hack tool for mobile apps. You can use full functions include Growth Push when you use the following SDK.

* [Growthbeat SDK for iOS](https://github.com/SIROK/growthbeat-ios/)
* [Growthbeat SDK for Android](https://github.com/SIROK/growthbeat-android/)

# Building framework

1. Set build target to GrowthMessageFramework and iOS Device.
1. Run.

## License

Apache License, Version 2.0
