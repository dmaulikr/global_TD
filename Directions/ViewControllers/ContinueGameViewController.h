//
//  RootViewController.h
//  MapDirections
//
//  Created by KISHIKAWA Katsumi on 09/08/10.
//  Copyright KISHIKAWA Katsumi 2009. All rights reserved.
//

@interface ContinueGameViewController : UITableViewController<UITextFieldDelegate> {
	 NSMutableArray *_NamesOfGames;
}

@property (nonatomic, retain) NSMutableArray * _NamesOfGames;

@end
