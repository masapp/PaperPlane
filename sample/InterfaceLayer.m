//
//  InterfaceLayer.m
//  sample
//
//  Created by 石川 雅之 on 11/12/29.
//  Copyright 2011 専修大学. All rights reserved.
//

#import "InterfaceLayer.h"
#import "GameScene.h"
#import "TitleLayer.h"
#import <AudioToolbox/AudioToolbox.h>


@implementation InterfaceLayer


-(id)init{
    self = [super init];
    if(self){
        self.isAccelerometerEnabled = YES;
        CGSize winSize = [[CCDirector sharedDirector]winSize];
        CCSprite *background1 = [CCSprite spriteWithFile:@"Icon3.png"];
        background1.rotation = -90;
        background1.position = ccp(winSize.width/2,winSize.height/2);
        [self addChild:background1 z:-1];
        
        CCLabelTTF *label = [CCLabelTTF labelWithString:@"Back" fontName:@"Helvetica" fontSize:36];
        label.color = ccc3(0,0,0);
        CCMenuItemLabel *item = [CCMenuItemLabel itemWithLabel:label target:self selector:@selector(backed:)];
        CCMenu *menu = [CCMenu menuWithItems:item, nil];
        menu.position = ccp(winSize.width*7/8,winSize.height/9);
        [self addChild:menu];
    }
    return self;
}

- (void)accelerometer:(UIAccelerometer*)accelerometer didAccelerate:(UIAcceleration*)acceleration{
    const float throw = 1.5;
    float muki = 0;

    BOOL shake = FALSE;  
    
    if (acceleration.y > throw && acceleration.x < muki) {
        shake = TRUE;
    }
    if (shake) {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        if(acceleration.x < -1.0){
            muki = 1.0;
        }else{
            muki = acceleration.x * -1;
        }
        float kaku = fabs(0.5 - muki);
        thr = (muki * 10) * (acceleration.y * 10) - kaku*10;
        [[CCDirector sharedDirector]replaceScene:[GameScene node:thr]];
    }
    
}

-(void) InitializeAccelerometer {
 	accelerometer = [UIAccelerometer sharedAccelerometer];
 	accelerometer.updateInterval = 1.0/15;
 	accelerometer.delegate = self;
}

-(void)backed:(id)sender{
    [[CCDirector sharedDirector]replaceScene:[TitleLayer node]];
}


@end
