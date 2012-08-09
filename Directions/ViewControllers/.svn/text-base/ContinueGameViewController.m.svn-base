//
//  RootViewController.m
//  MapDirections
//
//  Created by KISHIKAWA Katsumi on 09/08/10.
//  Copyright KISHIKAWA Katsumi 2009. All rights reserved.
//


#import "ContinueGameViewController.h"
#import "MapDirectionsViewController.h"
#import "CreateGameViewController.h"

@implementation ContinueGameViewController

@synthesize _NamesOfGames;

- (void)dealloc {
    [_NamesOfGames release];
    [super dealloc];
    
}

- (void)viewDidLoad {
    DataModel *m = [DataModel getModel];
    //todo - get a list of the games that a player can join to and write it to _nameOfGames;
    
    //     _NamesOfGames = [[NSMutableArray alloc] init];
    //    //NSString *game=@"Talgat's game";
    //    //[_NamesOfGames addObject:game]; 
    //   
    //    NSString *game1=@"Trojan game";
    //    [_NamesOfGames addObject:game1]; 
    
    _NamesOfGames = m.joinList;
    
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _NamesOfGames.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	if (section == 0) {
        return NSLocalizedString(@"Choose a game", nil);
    }
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%d%d", indexPath.section, indexPath.row];
    UITableViewCell *cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    
    for (int i=0; i<_NamesOfGames.count; i++) {
        
        if (indexPath.section == 0 && indexPath.row == i) {
            cell.selectionStyle = UITableViewCellSelectionStyleBlue;
            cell.accessoryType = UITableViewCellAccessoryNone;
            NSString *temp = [_NamesOfGames objectAtIndex:i];
            cell.textLabel.text = NSLocalizedString(temp , nil);
            cell.textLabel.textAlignment = UITextAlignmentCenter;
            cell.textLabel.textColor = [UIColor colorWithRed:0.20f green:0.30f blue:0.49f alpha:1.0f];
            
            
            //            NSLog(@"_namesOfGames at index %d is %@",i, temp);
        }
	}
    
    //  tableView.backgroundColor = [UIColor clearColor];
    
    //   cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hud.png"]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    for (int i=0; i<_NamesOfGames.count; i++) {
        
        if (indexPath.section == 0 && indexPath.row == i) {
            DataModel *m = [DataModel getModel];
            //            m._MapDirectionsViewController.startPoint = @"2825 Ellendale Place, Los Angeles, CA";
            //            m._MapDirectionsViewController.endPoint = @"2825 Ellendale Place, Los Angeles, CA";
            //            m._MapDirectionsViewController.wayPoints = nil;
            //            m._MapDirectionsViewController.travelMode = UICGTravelModeDriving;
            //            [m._MapDirectionsViewController GettingStarted];
            
            //TODO: send game name to the server and get base and area info
            //joinGame>gameName 
            NSString *join = @"joinGame>";
            join = [join stringByAppendingString:[_NamesOfGames objectAtIndex:i] ];
            NSLog(@"%@",join);
            [m._server sendData:join];
            [m._MainMenuCocosLayer ActualJoinGameFunc];
            [self.view removeFromSuperview];
            
        }
    }
    
    
}

@end
