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

1. Write following code in AppDelegate's applicationDidBecomeActive:

	```objc
    [[GrowthAnalytics sharedInstance] open];
	```

1. Write following code in AppDelegate's applicationWillResignActive:

	```objc
	[[GrowthAnalytics sharedInstance] close];
	```

1. Import the ViewController header.
	```objc
	#import <GrowthMessage/GrowthMessage.h>
	```

1. Write following code in viewDidAppear
	```objc
	[[GrowthMessage sharedInstance] setDelegate:self];
	```

1. Add following method code in ViewController.m
	```objc
	- (BOOL)shouldShowMessage:(GMMessage *)message manager:(GrowthMessage *)manager {
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
