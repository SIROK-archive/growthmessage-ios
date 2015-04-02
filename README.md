# Growth Message SDK for iOS

[Growth Message](https://message.growthbeat.com/) in-app message service for mobile apps.

## Usage 

1. Install [Growthbeat Core SDK](https://github.com/SIROK/growthbeat-core-ios).

1. Add GrowthMessage.framework into your project. 

1. Import the framework header.

	```objc
	#import <GrowthMessage/GrowthMessage.h>
	```

1. Write initialization code

	```objc
	[[GrowthMessage sharedInstance] initializeWithApplicationId:@"APPLICATION_ID" credentialId:@"CREDENTIAL_ID"];
	```

1. Write following code in the place to display a message.

	```objc
    [[GrowthAnalytics sharedInstance] track:@"EVENT_ID"];
	```

1. (Optional) You can use GrowthMessageDelegate to prevent message from being shown in game screen.

	```objc
	[[GrowthMessage sharedInstance] setDelegate:self];
	```

	```objc
	- (BOOL)shouldShowMessage:(GMMessage *)message {
		return YES;
	}
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
