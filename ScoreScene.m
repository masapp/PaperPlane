//
//  ScoreScene.m
//  sample
//
//  Created by masapp on 11/12/17.
//  Copyright (c) 2011 masapp. All rights reserved.
//

#import "ScoreScene.h"
#import "TitleLayer.h"
#define highscore @"high"
#define second @"sec"
#define thrd @"thr"

@implementation ScoreScene

-(id)init{
    self = [super init];
    if(self){
        CGSize winSize = [[CCDirector sharedDirector]winSize];
        CCSprite *background = [CCSprite spriteWithFile:@"score.png"];
        background.position = ccp(winSize.width/2,winSize.height/2);
        [self addChild:background z:-1];
        
        CCLabelTTF *label = [CCLabelTTF labelWithString:@"Back" fontName:@"Helvetica" fontSize:36];
        label.color = ccc3(0,0,0);
        CCMenuItemLabel *item = [CCMenuItemLabel itemWithLabel:label target:self selector:@selector(backed:)];
        CCMenu *menu = [CCMenu menuWithItems:item, nil];
        menu.position = ccp(winSize.width*7/8,winSize.height/9);
        [self addChild:menu];
        
        float first = [[NSUserDefaults standardUserDefaults]floatForKey:highscore];
        NSString *str = [NSString stringWithFormat:@"%.1f m",first];
        CCLabelTTF *label1 = [CCLabelTTF labelWithString:str fontName:@"Courier" fontSize:40];
        label1.color = ccc3(0,0,0);
        label1.position = ccp(130,155);
        [self addChild:label1];
        
        float sec = [[NSUserDefaults standardUserDefaults]floatForKey:second];
        NSString *str1 = [NSString stringWithFormat:@"%.1f m",sec];
        CCLabelTTF *label2 = [CCLabelTTF labelWithString:str1 fontName:@"Courier" fontSize:35];
        label2.color = ccc3(0,0,0);
        label2.position = ccp(350,112);
        [self addChild:label2];
        
        float thr = [[NSUserDefaults standardUserDefaults]floatForKey:thrd];
        NSString *str2 = [NSString stringWithFormat:@"%.1f m",thr];
        CCLabelTTF *label3 = [CCLabelTTF labelWithString:str2 fontName:@"Courier" fontSize:30];
        label3.color = ccc3(0,0,0);
        label3.position = ccp(130,70);
        [self addChild:label3];
        
        resetButton = [CCSprite spriteWithFile:@"reset.png"];
        CCSprite *selectedSprite = [CCSprite spriteWithFile:@"reset.png"];
        selectedSprite.opacity = 0x7f;
        CCSprite *disabledSprite = [CCSprite spriteWithFile:@"reset.png"];

        CCMenuItemSprite *item1 = [CCMenuItemSprite itemFromNormalSprite:resetButton selectedSprite:selectedSprite disabledSprite:disabledSprite target:self selector:@selector(kakunin:)];
        menu1 = [CCMenu menuWithItems:item1, nil];
        menu1.position = ccp(winSize.width/15,winSize.height/13);
        [self addChild:menu1];
        
        kakunin = [[CCSprite alloc]initWithFile:@"end.png"];
        kakunin.position = ccp(winSize.width/2,winSize.height/2);
        [kakunin setOpacity:0];
        [self addChild:kakunin];
    }
    return self;
}

-(void)backed:(id)sender{
    [[CCDirector sharedDirector]replaceScene:[TitleLayer node]];
}

-(void)kakunin:(id)sender{
    CGSize winSize = [[CCDirector sharedDirector]winSize];
    [kakunin setOpacity:230];
    CCLabelTTF *label4 = [CCLabelTTF labelWithString:@"Reset" fontName:@"Helvetica" fontSize:36];
    label4.color = ccc3(0,0,0);
    CCMenuItemLabel *item2 = [CCMenuItemLabel itemWithLabel:label4 target:self selector:@selector(reseted:)];
    CCLabelTTF *label5 = [CCLabelTTF labelWithString:@"Cancel" fontName:@"Helvetica" fontSize:36];
    label5.color = ccc3(0,0,0);
    CCMenuItemLabel *item3 = [CCMenuItemLabel itemWithLabel:label5 target:self selector:@selector(non:)];
    menu2 = [CCMenu menuWithItems:item2, item3, nil];
    menu2.position = ccp(winSize.width/2,winSize.height/2);
    [menu2 alignItemsHorizontallyWithPadding:50];
    [self addChild:menu2];
    [menu1 removeFromParentAndCleanup:YES];
}

-(void)reseted:(id)sender{
    [[NSUserDefaults standardUserDefaults]setFloat:0.0 forKey:highscore];
    [[NSUserDefaults standardUserDefaults]setFloat:0.0 forKey:second];
    [[NSUserDefaults standardUserDefaults]setFloat:0.0 forKey:thrd];
    [[CCDirector sharedDirector]replaceScene:[ScoreScene node]];
}

-(void)non:(id)sender{
    [kakunin setOpacity:0];
    [menu2 removeFromParentAndCleanup:YES];
    [[CCDirector sharedDirector]replaceScene:[ScoreScene node]];
}

-(void)dealloc{
    [kakunin release];
    [super dealloc];
}


@end
