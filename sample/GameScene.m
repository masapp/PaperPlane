//
//  GameScene.m
//  sample
//
//  Created by 石川 雅之 on 12/01/01.
//  Copyright 2012 専修大学. All rights reserved.
//

#import "GameScene.h"
#import "TitleLayer.h"
#import "InterfaceLayer.h"
#define highscore @"high"
#define second @"sec"
#define thrd @"thr"

@implementation GameScene

float _value;

+(id)node:(float)v{
    _value = v;
    return [super node];
}

-(id)init{
    self = [super init];
    if(self){
        CGSize winSize = [[CCDirector sharedDirector]winSize];
        time = 0.0;
        time1 = 0.0;
        value1 = 0.0;
        
        CCSprite *background = [CCSprite spriteWithFile:@"background.png"];
        background.position = ccp(winSize.width/2,winSize.height/2);
        [self addChild:background z:-1];
        
        tree1 = [[CCSprite alloc]initWithFile:@"tree.png"];
        tree1.position = ccp(0,winSize.height/2.2);
        [self addChild:tree1];
        tree2 = [[CCSprite alloc]initWithFile:@"tree.png"];
        tree2.position = ccp(winSize.width/4,winSize.height/2.2);
        [self addChild:tree2];
        tree3 = [[CCSprite alloc]initWithFile:@"tree.png"];
        tree3.position = ccp(winSize.width/2,winSize.height/2.2);
        [self addChild:tree3];
        tree4 = [[CCSprite alloc]initWithFile:@"tree.png"];
        tree4.position = ccp(winSize.width/4*3,winSize.height/2.2);
        [self addChild:tree4];
        tree5 = [[CCSprite alloc]initWithFile:@"tree.png"];
        tree5.position = ccp(winSize.width,winSize.height/2.2);
        [self addChild:tree5];
        
        human1 = [[CCSprite alloc]initWithFile:@"human1.png"];
        human1.position = ccp(winSize.width/5,winSize.height/2.9);
        [self addChild:human1];
        human2 = [[CCSprite alloc]initWithFile:@"human2.png"];
        human2.position = ccp(winSize.width/5,winSize.height/2.9);
        
        plane1 = [[CCSprite alloc]initWithFile:@"icon4.PNG"];
        plane1.position = ccp(80,167);
        [self addChild:plane1];
        
        end = [[CCSprite alloc]initWithFile:@"end.png"];
        end.position = ccp(winSize.width/2,winSize.height/2);
        [end setOpacity:0];
        [self addChild:end];
        
        high = [[NSUserDefaults standardUserDefaults]floatForKey:highscore];
        NSString *str = [NSString stringWithFormat:@"Highscore: %.1f m",high];
        CCLabelTTF *label = [CCLabelTTF labelWithString:str fontName:@"Helvetica" fontSize:20];
        label.color = ccc3(0,0,0);
        label.position = ccp(winSize.width/5*4,winSize.height/16);
        [self addChild:label];
        
        NSString *str2 = [NSString stringWithFormat:@"%.1f m",value1];
        label4 = [CCLabelTTF labelWithString:str2 fontName:@"Courier" fontSize:36];
        label4.color = ccc3(0,0,0);
        label4.position = ccp(winSize.width/2,winSize.height/8*7);
        [self addChild:label4];
        
        [self schedule:@selector(throw:)];
    }
    return self;
}

-(void)throw:(ccTime)dt{
    if(time > 0.5 && time <= 0.51){
        [human1 removeFromParentAndCleanup:YES];
        [self addChild:human2];
        plane1.position = ccp(110,167);
        [self schedule:@selector(next:)];
    }
    time += 0.01;
}

-(void)next:(ccTime)dt{
    CGSize winSize = [[CCDirector sharedDirector]winSize];
    [self unschedule:@selector(throw:)];
    
    value1 = time1*20;
    NSString *str2 = [NSString stringWithFormat:@"%.1f m",value1];
    [label4 setString:str2];
    
    if(plane1.position.x < winSize.width/2){
        plane1.position = ccp(plane1.position.x + 100*dt, plane1.position.y + 30*dt);
    }else if(time1 < _value/20){
        human2.position = ccp(human2.position.x - 100*dt, human2.position.y);
        tree1.position = ccp(tree1.position.x - 100*dt, tree1.position.y);
        if(tree1.position.x < 0 - tree1.contentSize.width/2){
            CGPoint p = tree1.position;
            p.x = winSize.width + tree1.contentSize.width/2;
            tree1.position = p;
        }
        tree2.position = ccp(tree2.position.x - 100*dt, tree2.position.y);
        if(tree2.position.x < 0 - tree2.contentSize.width/2){
            CGPoint p = tree2.position;
            p.x = winSize.width + tree2.contentSize.width/2;
            tree2.position = p;
        }
        tree3.position = ccp(tree3.position.x - 100*dt, tree3.position.y);
        if(tree3.position.x < 0 - tree3.contentSize.width/2){
            CGPoint p = tree3.position;
            p.x = winSize.width + tree3.contentSize.width/2;
            tree3.position = p;
        }
        tree4.position = ccp(tree4.position.x - 100*dt, tree4.position.y);
        if(tree4.position.x < 0 - tree4.contentSize.width/2){
            CGPoint p = tree4.position;
            p.x = winSize.width + tree4.contentSize.width/2;
            tree4.position = p;
        }
        tree5.position = ccp(tree5.position.x - 100*dt, tree5.position.y);
        if(tree5.position.x < 0 - tree5.contentSize.width/2){
            CGPoint p = tree5.position;
            p.x = winSize.width + tree5.contentSize.width/2;
            tree5.position = p;
        }
    }else if(plane1.position.y > winSize.height/5){
        plane1.position = ccp(plane1.position.x + 100*dt, plane1.position.y - 70*dt);
    }else{
        [self schedule:@selector(end:)];
    }
    time1 += 0.01;
    }

-(void)end:(ccTime)dt{
    CGSize winSize = [[CCDirector sharedDirector]winSize];
    [self unschedule:@selector(next:)];
    [end setOpacity:160];
    CCLabelTTF *label1 = [CCLabelTTF labelWithString:@"Title" fontName:@"Helvetica" fontSize:36];
    label1.color = ccc3(0,0,0);
    CCMenuItemLabel *item1 = [CCMenuItemLabel itemWithLabel:label1 target:self selector:@selector(title:)];
    CCLabelTTF *label2 = [CCLabelTTF labelWithString:@"Retry" fontName:@"Helvetica" fontSize:36];
    label2.color = ccc3(0,0,0);
    CCMenuItemLabel *item2 = [CCMenuItemLabel itemWithLabel:label2 target:self selector:@selector(retry:)];
    CCLabelTTF *label3 = [CCLabelTTF labelWithString:@"Tweet" fontName:@"Helvetica" fontSize:36];
    label3.color = ccc3(0, 0, 0);
    CCMenuItemLabel *item3 = [CCMenuItemLabel itemWithLabel:label3 target:self selector:@selector(tweet:)];
    menu = [CCMenu menuWithItems:item1, item2, item3, nil];
    menu.position = ccp(winSize.width/2,winSize.height/2);
    [menu alignItemsHorizontallyWithPadding:50];
    
    high = [[NSUserDefaults standardUserDefaults]floatForKey:highscore];
    float sec = [[NSUserDefaults standardUserDefaults]floatForKey:second];
    float thr = [[NSUserDefaults standardUserDefaults]floatForKey:thrd];
    if(value1 > high){
        thr = [[NSUserDefaults standardUserDefaults]floatForKey:second];
        sec = [[NSUserDefaults standardUserDefaults]floatForKey:highscore];
        [[NSUserDefaults standardUserDefaults]setFloat:value1 forKey:highscore];
        [[NSUserDefaults standardUserDefaults]setFloat:sec forKey:second];
        [[NSUserDefaults standardUserDefaults]setFloat:thr forKey:thrd];
    }else if(value1 > sec){
        thr = [[NSUserDefaults standardUserDefaults]floatForKey:second];
        [[NSUserDefaults standardUserDefaults]setFloat:value1 forKey:second];
        [[NSUserDefaults standardUserDefaults]setFloat:thr forKey:thrd];
    }else if(value1 > thr){
        [[NSUserDefaults standardUserDefaults]setFloat:value1 forKey:thrd];
    }
    
    [self addChild:menu];
    [self unschedule:@selector(end:)];
}

-(void)title:(id)sender{
    [[CCDirector sharedDirector]replaceScene:[TitleLayer node]];
}

-(void)retry:(id)sender{
    [[CCDirector sharedDirector]replaceScene:[InterfaceLayer node]];
}

-(void)tweet:(id)sender{
    NSLog(@"tweet!!");
}

-(void)dealloc{
    [plane1 release];
    [tree1 release];
    [tree2 release];
    [tree3 release];
    [tree4 release];
    [tree5 release];
    [human1 release];
    [human2 release];
    [end release];
    [super dealloc];
}

@end
