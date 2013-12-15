//
//  AppDelegate.h
//  sample
//
//  Created by masapp on 11/12/17.
//  Copyright (c) 2011 masapp. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
}

@property (nonatomic, retain) UIWindow *window;

@end
