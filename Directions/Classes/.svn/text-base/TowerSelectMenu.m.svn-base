//
//  TowerSelectMenu.m
//  MapDirections
//
//  Created by Raushan Karayeva on 4/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TowerSelectMenu.h"
#import "MapDirectionsViewController.h"
#import "CreateGameViewController.h"
#define FONT_SIZE 14.0f
#define CELL_CONTENT_WIDTH 100.0f
#define CELL_CONTENT_MARGIN 5.0f

@implementation TowerSelectMenu
@synthesize list;

- (id) init
{
	if ((self = [super init])) {
       
        list = [[NSMutableArray alloc] init];

	}
	return self;
}


- (void)dealloc {
    
    [list release];
    
    [super dealloc];
}

- (void)viewDidLoad {
    

   list = [[NSMutableArray alloc] init];
    
   NSMutableArray *towers = [NSMutableArray arrayWithObjects:@"", @"", @"", nil];
    [list addObjectsFromArray:towers];
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
    
   return list.count;
      
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	if (section == 0) {
      return NSLocalizedString(@"Towers", nil);
         
    } else{
        
		return nil;
	}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   // NSLog(@"list.count=%d", list.count);
     
	NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%d%d", indexPath.section];
    UITableViewCell *cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    
    for (int i=0; i<list.count; i++) {
      //   NSLog(@"list obj=%@", [list objectAtIndex:i]); 
        if (indexPath.section == 0 && indexPath.row == i) {
          

            cell.selectionStyle = UITableViewCellSelectionStyleBlue;
            cell.accessoryType = UITableViewCellAccessoryNone;
           NSString *temp = [list objectAtIndex:i];
            cell.textLabel.text = NSLocalizedString(temp , nil);
           cell.textLabel.textAlignment = UITextAlignmentLeft;
            cell.textLabel.textColor = [UIColor colorWithRed:0.90f green:0.0f blue:0.0f alpha:1.0f];
           //image
            NSString *RowImage = [NSString stringWithFormat:@"a%d.jpg", i+1];
            cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:RowImage]]; 
        }
	}	
    tableView.backgroundColor = [UIColor clearColor];
    UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"towerSelectBG.png"]];
    [tempImageView setFrame:self.tableView.frame]; 
    
    self.tableView.backgroundView = tempImageView;
    [tempImageView release];
       return cell;
}

//
//- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    UITableViewCell *cell;
//    UILabel *label = nil;
//    
//    cell = [tv dequeueReusableCellWithIdentifier:@"Cell"];
//    if (cell == nil)
//    {
//        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"Cell"] autorelease];
//        
//        label = [[UILabel alloc] initWithFrame:CGRectZero];
//        [label setLineBreakMode:UILineBreakModeWordWrap];
//        [label setMinimumFontSize:FONT_SIZE];
//        [label setNumberOfLines:0];
//        [label setFont:[UIFont systemFontOfSize:FONT_SIZE]];
//        [label setTag:1];
//        
//        [[label layer] setBorderWidth:2.0f];
//        
//        [[cell contentView] addSubview:label];
//           //image
//         // for (int i=0; i<list.count; i++) {
//           // NSString *RowImage = [NSString stringWithFormat:@"a%d.jpg", i+1];
//            cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wood.jpg"]]; 
//          //}
//        
//    }
//    NSString *text = [list objectAtIndex:[indexPath row]];
//    
//    CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
//    
//    CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
//    
//    if (!label)
//        label = (UILabel*)[cell viewWithTag:1];
//    
//    [label setText:text];
//    [label setFrame:CGRectMake(CELL_CONTENT_MARGIN, CELL_CONTENT_MARGIN, CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), MAX(size.height, 44.0f))];
//    
//    return cell;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
//{
//    NSString *text = [list objectAtIndex:[indexPath row]];
//    
//    CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
//    
//    CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
//    
//    CGFloat height = MAX(size.height, 44.0f);
//    
//    return height + (CELL_CONTENT_MARGIN * 2);
//}
//


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DataModel *m = [DataModel getModel];
    for (int i=0; i<list.count; i++) {
        
        if (indexPath.section == 0 && indexPath.row == i) {
        
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            MapDirectionsViewController *controller = [[MapDirectionsViewController alloc] init];
          //  NSLog(@"U selected row%d",i);
                     controller.continueGame = YES;
          
            [self.navigationController pushViewController:controller animated:YES];
                 
                      [m._gameHUDLayer addDescription:i];
        }
            
        
        
    }
}
@end
