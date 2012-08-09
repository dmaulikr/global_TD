//
//  TowerSelectMenu.h
//  MapDirections
//
//  Created by Raushan Karayeva on 4/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#import "cocos2d.h"

@interface TowerSelectMenu : UITableViewController<UITextFieldDelegate> {
	//int NumberOfGames;
    NSMutableArray *list;
   
}

@property (nonatomic, retain) NSMutableArray *list;

@end
