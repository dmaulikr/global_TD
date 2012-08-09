//
//  SaveAndRestoreViewController.m
//  MapDirections
//
//  Created by Lion User on 21/03/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SaveAndRestoreViewController.h"

@implementation SaveAndRestoreViewController

@synthesize hb1;
@synthesize hb2;
@synthesize topLeft;
@synthesize botRight;



-(void) saveState{
    NSMutableArray *aFrames = [[NSMutableArray alloc] init];
    for(UIView *theView in [super.view subviews]){
        [aFrames addObject:NSStringFromCGRect([theView frame])];
    }
         
    [[NSUserDefaults standardUserDefaults] setObject:aFrames forKey:@"redRects"];
    [aFrames release];
}


-(void) restoreState{
    NSLog(@"restoreState");
    
    NSMutableArray *aFrames = [[NSMutableArray alloc] init];
    aFrames = [[NSUserDefaults standardUserDefaults] objectForKey:@"redRects"];
    
    int count = aFrames.count;
    
    for (int i = 0; i < count; i++) {
        UIView *theView = [[UIView alloc] initWithFrame:CGRectFromString([aFrames objectAtIndex:i])];
        [super.view addSubview:theView];
    }
    
}

@end
