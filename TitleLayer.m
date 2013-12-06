//
//  TitleLayer.m
//  sample
//
//  Created by 石川 雅之 on 11/12/29.
//  Copyright 2011 専修大学. All rights reserved.
//

#import "TitleLayer.h"
#import "InterfaceLayer.h"
#import "ScoreScene.h"
#define highscore @"high"


@implementation TitleLayer

-(id)init{
    self = [super init];
    if(self){
        CGSize winSize = [[CCDirector sharedDirector]winSize];
        CCSprite *background = [CCSprite spriteWithFile:@"Top.png"];
        background.rotation = -90;
        background.position = ccp(winSize.width/2,winSize.height/2);
        [self addChild:background z:-1];
        
        CCLabelTTF *label1 = [CCLabelTTF labelWithString:@"Start" fontName:@"Helvetica" fontSize:36];
        label1.color = ccc3(0,0,0);
        CCMenuItemLabel *item1 = [CCMenuItemLabel itemWithLabel:label1 target:self selector:@selector(started:)];
        CCLabelTTF *label2 = [CCLabelTTF labelWithString:@"Score" fontName:@"Helvetica" fontSize:36];
        label2.color = ccc3(0,0,0);
        CCMenuItemLabel *item2 = [CCMenuItemLabel itemWithLabel:label2 target:self selector:@selector(scored:)];
        menu = [CCMenu menuWithItems:item1, item2, nil];
        menu.position = ccp(winSize.width/2,winSize.height/4);
        [menu alignItemsVertically];
        [self addChild:menu];
        
        high = [[NSUserDefaults standardUserDefaults]floatForKey:highscore];
        NSString *str = [NSString stringWithFormat:@"%.1f m",high];
        CCLabelTTF *label3 = [CCLabelTTF labelWithString:str fontName:@"Courier" fontSize:45];
        label3.color = ccc3(0,0,0);
        label3.position = ccp(winSize.width/2,winSize.height/2);
        [self addChild:label3];

        plane = [[CCSprite alloc]initWithFile:@"icon4.PNG"];
        plane.position = ccp(0,320/2);
        [self addChild:plane];
        
        [self schedule:@selector(nextFrame:)];
        
        twitter = [CCSprite spriteWithFile:@"twitter.png"];
        CCSprite *selectedSprite = [CCSprite spriteWithFile:@"twitter.png"];
        selectedSprite.opacity = 0x7f;
        CCSprite *disabledSprite = [CCSprite spriteWithFile:@"twitter.png"];
        CCMenuItemSprite *item3 = [CCMenuItemSprite itemFromNormalSprite:twitter selectedSprite:selectedSprite disabledSprite:disabledSprite target:self selector:@selector(reseted:)];
        menu1 = [CCMenu menuWithItems:item3, nil];
        menu1.position = ccp(winSize.width/15,winSize.height/13);
        [self addChild:menu1];
        
        reset = [[CCSprite alloc]initWithFile:@"end.png"];
        reset.position = ccp(winSize.width/2,winSize.height/2);
        [reset setOpacity:0];
        [self addChild:reset];
    }
    return self;
}

-(void)started:(id)sender{
    [[CCDirector sharedDirector]replaceScene:[InterfaceLayer node]];
}

-(void)scored:(id)sender{
    [[CCDirector sharedDirector]replaceScene:[ScoreScene node]];
}

-(void)reseted:(id)sender{
    CGSize winSize = [[CCDirector sharedDirector]winSize];
    [reset setOpacity:230];
    CCLabelTTF *label4 = [CCLabelTTF labelWithString:@"Reset" fontName:@"Helvetica" fontSize:36];
    label4.color = ccc3(0,0,0);
    CCMenuItemLabel *item2 = [CCMenuItemLabel itemWithLabel:label4 target:self selector:@selector(resetTwitter:)];
    CCLabelTTF *label5 = [CCLabelTTF labelWithString:@"Cancel" fontName:@"Helvetica" fontSize:36];
    label5.color = ccc3(0,0,0);
    CCMenuItemLabel *item3 = [CCMenuItemLabel itemWithLabel:label5 target:self selector:@selector(non:)];
    menu2 = [CCMenu menuWithItems:item2, item3, nil];
    menu2.position = ccp(winSize.width/2,winSize.height/2);
    [menu2 alignItemsHorizontallyWithPadding:50];
    [self addChild:menu2];
    CCLabelTTF *label6 = [CCLabelTTF labelWithString:@"Reset Twitter Account" fontName:@"Helvetica" fontSize:36];
    label6.color = ccc3(0, 0, 0);
    label6.position = ccp(winSize.width/2,winSize.height/8*6);
    [self addChild:label6];
    [menu removeFromParentAndCleanup:YES];
    [menu1 removeFromParentAndCleanup:YES];
}

-(void)resetTwitter:(id)sender{
    [[CCDirector sharedDirector]replaceScene:[TitleLayer node]];
}

-(void)non:(id)sender{
    [reset setOpacity:0];
    [menu2 removeFromParentAndCleanup:YES];
    [[CCDirector sharedDirector]replaceScene:[TitleLayer node]];
}


- (void) nextFrame:(ccTime)dt{
    CGSize winSize = [[CCDirector sharedDirector]winSize];
    plane.position = ccp(plane.position.x + 100*dt, plane.position.y);
    
    if(plane.position.x > winSize.width + plane.contentSize.width/2){
        CGPoint p = plane.position;
        p.x = 0 - plane.contentSize.width/2;
        plane.position = p;
    }
}


-(void)dealloc{
    [plane release];
    [super dealloc];
}

@end
