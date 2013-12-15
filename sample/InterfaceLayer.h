//
//  InterfaceLayer.h
//  sample
//
//  Created by masapp on 11/12/17.
//  Copyright (c) 2011 masapp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface InterfaceLayer : CCLayer {
    UIAccelerometer *accelerometer;
    float thr;
}


@end
