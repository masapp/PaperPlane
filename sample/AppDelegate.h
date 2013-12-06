//
//  AppDelegate.h
//  sample
//
//  Created by 石川 雅之 on 11/12/17.
//  Copyright 専修大学 2011. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
}

@property (nonatomic, retain) UIWindow *window;

@end
