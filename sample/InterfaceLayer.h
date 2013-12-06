//
//  InterfaceLayer.h
//  sample
//
//  Created by 石川 雅之 on 11/12/29.
//  Copyright 2011 専修大学. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface InterfaceLayer : CCLayer {
    UIAccelerometer *accelerometer;
    float thr;
}


@end
