//
//  RootViewController.m
//  MapDirections
//
//  Created by KISHIKAWA Katsumi on 09/08/10.
//  Copyright KISHIKAWA Katsumi 2009. All rights reserved.
//

#import "CreateGameViewController.h"
#import "MapDirectionsViewController.h"

@implementation CreateGameViewController

- (void)dealloc {
//    [wayPointFields release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	
//	wayPointFields = [[NSMutableArray alloc] init];
	
//	UIBarButtonItem *space = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil] autorelease];
//	addButton = [[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"add.png"] style:UIBarButtonItemStylePlain target:self action:@selector(addRow:)] autorelease];
//	removeButton = [[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"remove.png"] style:UIBarButtonItemStylePlain target:self action:@selector(removeRow:)] autorelease];
//    removeButton.enabled = NO;
//	self.toolbarItems = [NSArray arrayWithObjects:space, addButton, removeButton, nil];
//	[self.navigationController setToolbarHidden:NO animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)done:(id)sender {
	if ([startField canResignFirstResponder]) {
		[startField resignFirstResponder];
	}
//	if ([endField canResignFirstResponder]) {
//		[endField resignFirstResponder];
//	}
	[self.navigationItem setRightBarButtonItem:nil animated:YES];
}

//- (void)addRow:(id)sender {
//	[wayPointFields addObject:[[[UITextField alloc] initWithFrame:CGRectMake(66.0f, 11.0f, 236.0f, 22.0f)] autorelease]];
//	[self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:[wayPointFields count] inSection:0]] withRowAnimation:UITableViewRowAnimationTop];
//    
//    removeButton.enabled = YES;
//}
//
//- (void)removeRow:(id)sender {
//	if ([wayPointFields count] <= 0) {
//		return;
//	}
//	[wayPointFields removeLastObject];
//	[self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:[wayPointFields count] + 1 inSection:0]] withRowAnimation:UITableViewRowAnimationBottom];
//    
//    if ([wayPointFields count] == 0) {
//        removeButton.enabled = NO;
//    }
//}

#pragma mark UITextFieldDelegate Methods

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
	UIBarButtonItem *doneButton = [[[UIBarButtonItem alloc] 
									initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done:)] autorelease];
	[self.navigationItem setRightBarButtonItem:doneButton animated:YES];
	return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
	[self.navigationItem setRightBarButtonItem:nil animated:YES];
	return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	if ([textField resignFirstResponder] && textField == startField) {
//		[endField becomeFirstResponder];
	}
	return YES;
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if (section == 0) {
		//return 2 + [wayPointFields count];
        return 3;
	} else {
		return 1;
	} 
//    else {
//		return 1;
	
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	if (section == 0) {
		//return NSLocalizedString(@"Directions", nil);
        return NSLocalizedString(@"Game Area", nil);
	} else if (section == 1) {
		//return NSLocalizedString(@"Travel Mode", nil);
        return NSLocalizedString(@"Current Location",nil);
	} else {
		return nil;
	}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%d%d", indexPath.section, indexPath.row];
    UITableViewCell *cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    
	if (indexPath.section == 0 && indexPath.row == 1) {
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		cell.accessoryType = UITableViewCellAccessoryNone;
		
		UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 13.0f, 100.0f, 20.0f)];
		[cell addSubview:textLabel];
		[textLabel release];
		textLabel.text = NSLocalizedString(@"City/State/Zip:", nil);
		textLabel.font = [UIFont boldSystemFontOfSize:14.0f];
		textLabel.textAlignment = UITextAlignmentRight;
		textLabel.textColor = [UIColor lightGrayColor];
		
		UITextField *inputField = [[UITextField alloc] initWithFrame:CGRectMake(126.0f, 11.0f, 186.0f, 22.0f)];
		inputField.delegate = self;
		[cell addSubview:inputField];
		[inputField release];
		
		[inputField setBorderStyle:UITextBorderStyleNone];
		[inputField setAdjustsFontSizeToFitWidth:NO];
		[inputField setClearButtonMode:UITextFieldViewModeWhileEditing];
		[inputField setClearsOnBeginEditing:NO];
		[inputField setPlaceholder:nil];
		[inputField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
		[inputField setAutocorrectionType:UITextAutocorrectionTypeNo];
		[inputField setEnablesReturnKeyAutomatically:YES];
		[inputField setKeyboardType:UIKeyboardTypeDefault];
		[inputField setReturnKeyType:UIReturnKeyNext];
		[inputField setEnablesReturnKeyAutomatically:YES];
		
		[inputField setContentVerticalAlignment:UIControlContentVerticalAlignmentBottom];
		[inputField setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
		
		[inputField setText:[NSString stringWithUTF8String:"USC McCarthy Way"]];
		
		startField = inputField;
        
    } else if (indexPath.section == 0 && indexPath.row == 0) {
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
		cell.accessoryType = UITableViewCellAccessoryNone;
		
		UILabel *textL = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 13.0f, 100.0f, 20.0f)];
		[cell addSubview:textL];
		[textL release];
		textL.text = NSLocalizedString(@"Game Name:", nil);
		textL.font = [UIFont boldSystemFontOfSize:14.0f];
		textL.textAlignment = UITextAlignmentRight;
		textL.textColor = [UIColor lightGrayColor];
		
		UITextField *inputF = [[UITextField alloc] initWithFrame:CGRectMake(126.0f, 11.0f, 186.0f, 22.0f)];
		inputF.delegate = self;
		[cell addSubview:inputF];
		[inputF release];
			
//        [inputF setBorderStyle:UITextBorderStyleNone];
//        [inputF setAdjustsFontSizeToFitWidth:NO];
//        [inputF setClearButtonMode:UITextFieldViewModeWhileEditing];
//        [inputF setClearsOnBeginEditing:NO];
//        [inputF setPlaceholder:nil];
//        [inputF setAutocapitalizationType:UITextAutocapitalizationTypeNone];
//        [inputF setAutocorrectionType:UITextAutocorrectionTypeNo];
//        [inputF setEnablesReturnKeyAutomatically:YES];
//        [inputF setKeyboardType:UIKeyboardTypeDefault];
//        [inputF setReturnKeyType:UIReturnKeyNext];
//        [inputF setEnablesReturnKeyAutomatically:YES];
//        
//        [inputF setContentVerticalAlignment:UIControlContentVerticalAlignmentBottom];
//        [inputF setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
//        
		[inputF setText:[NSString stringWithUTF8String:"Trojan Game"]];
		
		//startField = inputF;
    
//	} else if (indexPath.section == 0 && indexPath.row == 1 + [wayPointFields count]) {
//		cell.selectionStyle = UITableViewCellSelectionStyleNone;
//		cell.accessoryType = UITableViewCellAccessoryNone;
//		
//		UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 13.0f, 40.0f, 20.0f)];
//		[cell addSubview:textLabel];
//		[textLabel release];
//		textLabel.text = NSLocalizedString(@"End:", nil);
//		textLabel.font = [UIFont boldSystemFontOfSize:14.0f];
//		textLabel.textAlignment = UITextAlignmentRight;
//		textLabel.textColor = [UIColor lightGrayColor];
//		
//		UITextField *inputField = [[UITextField alloc] initWithFrame:CGRectMake(66.0f, 11.0f, 236.0f, 22.0f)];
//		inputField.delegate = self;
//		[cell addSubview:inputField];
//		[inputField release];
//		
//		[inputField setBorderStyle:UITextBorderStyleNone];
//		[inputField setAdjustsFontSizeToFitWidth:NO];
//		[inputField setClearButtonMode:UITextFieldViewModeWhileEditing];
//		[inputField setClearsOnBeginEditing:NO];
//		[inputField setPlaceholder:nil];
//		[inputField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
//		[inputField setAutocorrectionType:UITextAutocorrectionTypeNo];
//		[inputField setEnablesReturnKeyAutomatically:YES];
//		[inputField setKeyboardType:UIKeyboardTypeDefault];
//		[inputField setReturnKeyType:UIReturnKeyDone];
//		[inputField setEnablesReturnKeyAutomatically:YES];
//		
//		[inputField setContentVerticalAlignment:UIControlContentVerticalAlignmentBottom];
//		[inputField setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
//		
//		[inputField setText:[NSString stringWithUTF8String:"東京ディズニーランド"]];
//		
//		endField = inputField;
//	} else if (indexPath.section == 0) {
//		cell.selectionStyle = UITableViewCellSelectionStyleNone;
//		cell.accessoryType = UITableViewCellAccessoryNone;
//		
//		UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 13.0f, 40.0f, 20.0f)];
//		[cell addSubview:textLabel];
//		[textLabel release];
//		textLabel.text = NSLocalizedString(@"via:", nil);
//		textLabel.font = [UIFont boldSystemFontOfSize:14.0f];
//		textLabel.textAlignment = UITextAlignmentRight;
//		textLabel.textColor = [UIColor lightGrayColor];
//		
//		UITextField *inputField = [wayPointFields objectAtIndex:indexPath.row - 1];
//		inputField.delegate = self;
//		[cell addSubview:inputField];
//		
//		[inputField setBorderStyle:UITextBorderStyleNone];
//		[inputField setAdjustsFontSizeToFitWidth:NO];
//		[inputField setClearButtonMode:UITextFieldViewModeWhileEditing];
//		[inputField setClearsOnBeginEditing:NO];
//		[inputField setPlaceholder:nil];
//		[inputField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
//		[inputField setAutocorrectionType:UITextAutocorrectionTypeNo];
//		[inputField setEnablesReturnKeyAutomatically:YES];
//		[inputField setKeyboardType:UIKeyboardTypeDefault];
//		[inputField setReturnKeyType:UIReturnKeyDone];
//		[inputField setEnablesReturnKeyAutomatically:YES];
//		
//		[inputField setContentVerticalAlignment:UIControlContentVerticalAlignmentBottom];
//		[inputField setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
//	} else if (indexPath.section == 1 && indexPath.row == 0) {
//		cell.selectionStyle = UITableViewCellSelectionStyleNone;
//		cell.accessoryType = UITableViewCellAccessoryNone;
//		
//		travelModeSegment = [[UISegmentedControl alloc] initWithItems:
//							 [NSArray arrayWithObjects:NSLocalizedString(@"Driving", nil), 
//							  /*NSLocalizedString(@"Train", nil), */
//							  NSLocalizedString(@"Walking", nil), nil]];
//		[travelModeSegment setFrame:CGRectMake(9.0f, 0.0f, 302.0f, 45.0f)];
//		travelModeSegment.selectedSegmentIndex = 0;
//		[cell addSubview:travelModeSegment];
//		[travelModeSegment release];
        
	} else {
		cell.selectionStyle = UITableViewCellSelectionStyleBlue;
		cell.accessoryType = UITableViewCellAccessoryNone;
		cell.textLabel.text = NSLocalizedString(@"Search", nil);
		cell.textLabel.textAlignment = UITextAlignmentCenter;
		cell.textLabel.textColor = [UIColor colorWithRed:0.20f green:0.30f blue:0.49f alpha:1.0f];
	}
	
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if ((indexPath.section == 0 && indexPath.row == 2)) {
        //zoom to that place on map 
        NSLog(@"zoom to city/state/zip");
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        MapDirectionsViewController *controller = [[MapDirectionsViewController alloc] init];
        controller.startPoint = startField.text;
        //controller.endPoint = nil;
        //Sam
        controller.endPoint = startField.text;//@"2825 Ellendale Place, Los Angeles, CA";
        controller.wayPoints = nil;
        controller.travelMode = UICGTravelModeDriving;
        controller.continueGame = NO;
        
        [self.navigationController pushViewController:controller animated:YES];
        
//		MapDirectionsViewController *controller = [[MapDirectionsViewController alloc] init];
//		
//		controller.startPoint = startField.text;
//		//controller.endPoint = endField.text;
//		//NSMutableArray *wayPoints = [NSMutableArray arrayWithCapacity:[wayPointFields count]];
//		//for (UITextField *pointField in wayPointFields) {
//          //  if ([pointField.text length] > 0) {
//          //      [wayPoints addObject:pointField.text];
//           // }
//		//}
//		//controller.wayPoints = wayPoints;
////		
////		if (travelModeSegment.selectedSegmentIndex == 0) {
////			controller.travelMode = UICGTravelModeDriving;
////		} else {
////			controller.travelMode = UICGTravelModeWalking;
////		}
//        controller.travelMode = UICGTravelModeDriving;
//		
//		[self.navigationController pushViewController:controller animated:YES];
//		[controller release];
//		
		[tableView deselectRowAtIndexPath:indexPath animated:YES];
	}else if(indexPath.section == 1 && indexPath.row ==0){
        //zoom to current location
        NSLog(@"zoom to current location");
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        MapDirectionsViewController *controller = [[MapDirectionsViewController alloc] init];
        controller.startPoint = nil;
        //controller.endPoint = nil;
        controller.wayPoints = nil;
        controller.travelMode = UICGTravelModeDriving;
        controller.continueGame = NO;
        [self.navigationController pushViewController:controller animated:YES];
                
    }
}

@end
