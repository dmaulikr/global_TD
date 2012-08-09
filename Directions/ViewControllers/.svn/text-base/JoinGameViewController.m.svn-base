//
//  RootViewController.m
//  MapDirections
//
//  Created by KISHIKAWA Katsumi on 09/08/10.
//  Copyright KISHIKAWA Katsumi 2009. All rights reserved.
//


#import "JoinGameViewController.h"
#import "MapDirectionsViewController.h"

@implementation JoinGameViewController

@synthesize _NamesOfGames;

- (void)dealloc {
    [_NamesOfGames release];
    [self.view release]; 
    [super dealloc];
    
}

- (void)viewDidLoad {
    DataModel *m = [DataModel getModel];    
    
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
    //return 10;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	if (section == 0) {
        return NSLocalizedString(@"Choose a game", nil);
    }
		return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

	const NSInteger TOP_LABEL_TAG = 1001;
	const NSInteger BOTTOM_LABEL_TAG = 1002;
	UILabel *topLabel;
	UILabel *bottomLabel;

    
	static NSString *CellIdentifier = @"Cell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil)
	{
		//
		// Create the cell.
		//
		cell =
        [[[UITableViewCell alloc]
          initWithFrame:CGRectZero
          reuseIdentifier:CellIdentifier]
         autorelease];
        

		UIImage *indicatorImage = [UIImage imageNamed:@"indicator.png"];
		cell.accessoryView =
        [[[UIImageView alloc]
          initWithImage:indicatorImage]
         autorelease];
		
		const CGFloat LABEL_HEIGHT = 20;
		UIImage *image = [UIImage imageNamed:@"imageA.png"];
        
		//
		// Create the label for the top row of text
		//
		topLabel =
        [[[UILabel alloc]
          initWithFrame:
          CGRectMake(
                     image.size.width + 2.0 * cell.indentationWidth,
                     0.5 * (tableView.rowHeight - 2 * LABEL_HEIGHT),
                     tableView.bounds.size.width -
                     image.size.width - 4.0 * cell.indentationWidth
                     - indicatorImage.size.width,
                     LABEL_HEIGHT)]
         autorelease];
		[cell.contentView addSubview:topLabel];
        
		//
		// Configure the properties for the text that are the same on every row
		//
		topLabel.tag = TOP_LABEL_TAG;
		topLabel.backgroundColor = [UIColor clearColor];
		topLabel.textColor = [UIColor colorWithRed:0.25 green:0.0 blue:0.0 alpha:1.0];
		topLabel.highlightedTextColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.9 alpha:1.0];
		topLabel.font = [UIFont systemFontOfSize:[UIFont labelFontSize]];
        
		//
		// Create the label for the top row of text
		//
		bottomLabel =
        [[[UILabel alloc]
          initWithFrame:
          CGRectMake(
                     image.size.width + 2.0 * cell.indentationWidth,
                     0.5 * (tableView.rowHeight - 2 * LABEL_HEIGHT) + LABEL_HEIGHT,
                     tableView.bounds.size.width -
                     image.size.width - 4.0 * cell.indentationWidth
                     - indicatorImage.size.width,
                     LABEL_HEIGHT)]
         autorelease];
		[cell.contentView addSubview:bottomLabel];
        
		//
		// Configure the properties for the text that are the same on every row
		//
		bottomLabel.tag = BOTTOM_LABEL_TAG;
		bottomLabel.backgroundColor = [UIColor clearColor];
		bottomLabel.textColor = [UIColor colorWithRed:0.25 green:0.0 blue:0.0 alpha:1.0];
		bottomLabel.highlightedTextColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.9 alpha:1.0];
		bottomLabel.font = [UIFont systemFontOfSize:[UIFont labelFontSize] - 2];
        
		//
		// Create a background image view.
		//
		cell.backgroundView =
        [[[UIImageView alloc] init] autorelease];
		cell.selectedBackgroundView =
        [[[UIImageView alloc] init] autorelease];

	}
    

	else
	{
		topLabel = (UILabel *)[cell viewWithTag:TOP_LABEL_TAG];
		bottomLabel = (UILabel *)[cell viewWithTag:BOTTOM_LABEL_TAG];
	}
	
	//topLabel.text = [NSString stringWithFormat:@"Cell at row %ld.", [indexPath row]];

    NSString *temp = [_NamesOfGames objectAtIndex:[indexPath row]];
    topLabel.text = NSLocalizedString(temp , nil);
	
	//
	// Set the background and selected background images for the text.
	// Since we will round the corners at the top and bottom of sections, we
	// need to conditionally choose the images based on the row index and the
	// number of rows in the section.
	//
	UIImage *rowBackground;
	UIImage *selectionBackground;
	NSInteger sectionRows = [tableView numberOfRowsInSection:[indexPath section]];
	NSInteger row = [indexPath row];
	if (row == 0 && row == sectionRows - 1)
	{
		rowBackground = [UIImage imageNamed:@"topAndBottomRow.png"];
		selectionBackground = [UIImage imageNamed:@"topAndBottomRowSelected.png"];
	}
	else if (row == 0)
	{
		rowBackground = [UIImage imageNamed:@"topRow.png"];
		selectionBackground = [UIImage imageNamed:@"topRowSelected.png"];
	}
	else if (row == sectionRows - 1)
	{
		rowBackground = [UIImage imageNamed:@"bottomRow.png"];
		selectionBackground = [UIImage imageNamed:@"bottomRowSelected.png"];
	}
	else
	{
		rowBackground = [UIImage imageNamed:@"middleRow.png"];
		selectionBackground = [UIImage imageNamed:@"middleRowSelected.png"];
	}
	((UIImageView *)cell.backgroundView).image = rowBackground;
	((UIImageView *)cell.selectedBackgroundView).image = selectionBackground;
	
	//
	// Here I set an image based on the row. This is just to have something
	// colorful to show on each row.
	//
	if ((row % 3) == 0)
	{
		cell.image = [UIImage imageNamed:@"imageA.png"];
	}
	else if ((row % 3) == 1)
	{
		cell.image = [UIImage imageNamed:@"imageB.png"];
	}
	else
	{
		cell.image = [UIImage imageNamed:@"imageC.png"];
	}

    
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    for (int i=0; i<_NamesOfGames.count; i++) {
        
        if (indexPath.section == 0 && indexPath.row == i) {
            DataModel *m = [DataModel getModel];
            [m._MapDirectionsViewController disableScrolling];
            
//            m._MapDirectionsViewController.startPoint = @"2825 Ellendale Place, Los Angeles, CA";
//            m._MapDirectionsViewController.endPoint = @"2825 Ellendale Place, Los Angeles, CA";
//            m._MapDirectionsViewController.wayPoints = nil;
//            m._MapDirectionsViewController.travelMode = UICGTravelModeDriving;
//            [m._MapDirectionsViewController GettingStarted];
            
            //TODO: send game name to the server and get base and area info
            //joinGame>gameName 
            NSString *join = @"joinGame>";
            join = [join stringByAppendingString:[_NamesOfGames objectAtIndex:i] ];
            NSLog(@"joinn%@",join);
            [m._server sendData:join];
            [m._MainMenuCocosLayer ActualJoinGameFunc];
            //[self removeJoin];
            [self.view removeFromSuperview];
            m.towerMenuView.userInteractionEnabled= NO;
           
            
        }
    }
    
   
}

- (void)removeJoin:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DataModel *m=[DataModel getModel];
    [self.view removeFromSuperview];
    //[self.view removeFromParentViewController];
    //[m._MapDirectionsAppDelegate cleanView];
    m.towerMenuView.userInteractionEnabled= NO;
}

@end
