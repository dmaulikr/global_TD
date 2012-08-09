//
//  MapDirectionsViewController.m
//  MapDirections
//
//  Created by KISHIKAWA Katsumi on 09/08/10.
//  Copyright 2009 KISHIKAWA Katsumi. All rights reserved.
//

#import "MapDirectionsViewController.h"
#import "UICRouteOverlayMapView.h"
#import "UICRouteAnnotation.h"
#import "RouteListViewController.h"
#import "MKMapView_ZoomLevel.h"
#import "VariableStore.h"
#import "ServerTalk.h"
#import "cocos2d.h"
#import "HelloWorldScene.h"
#import "GameHUD.h"
#import  <MapKit/MapKit.h>
#import "ServerTalk.h"


bool booReady = NO;
bool firstTime = YES;
CLLocationCoordinate2D toLe;
CLLocationCoordinate2D boRi;
CLLocationCoordinate2D sP;
//NSArray *hb_lat;
//NSArray *hb_lon;
//NSArray *hb_player;
//NSArray *t_lat; 
//NSArray *t_lon;
//NSArray *t_player; 

@implementation MapDirectionsViewController

@synthesize continueGame;
@synthesize startPoint;
@synthesize endPoint;
@synthesize wayPoints;
@synthesize travelMode;
@synthesize rPoints;
@synthesize diretions;
@synthesize address;
@synthesize inputF;
@synthesize searchTouched;
//@synthesize cocos_view;
//NSUInteger zoom = 12;
//NSUInteger zoom2 = [[VariableStore vStore] zoom];
 
- (void) viewDidLoad{
    inputF=nil;
     inputAddress =nil;
 NSLog(@"getting started");
    

    [super viewDidLoad];
}

-(void) startDelegate{
    [NetworkController sharedInstance].delegate = self;
}

- (void)GettingStarted {
    DataModel *m = [DataModel getModel];
    searchTouched = false;
    startPoint = @"USA";
    endPoint = @"USA";
    wayPoints = nil;
    travelMode = UICGTravelModeDriving;
    
//    playerNumber = 1;
//    m._PlayerNum = playerNumber;

    routeMapView = [[LimitedMapView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//  routeMapView = [[MKMapView alloc] initWithFrame:contentView.frame];
    routeMapView.topLeft = CLLocationCoordinate2DMake(0, 0);
    routeMapView.botRight = routeMapView.topLeft;
	routeMapView.delegate = self;
	routeMapView.showsUserLocation = YES;
	[self.view addSubview:routeMapView];
    [self.view sendSubviewToBack:routeMapView];
	[routeMapView release];
	//routeMapView.autoresizesSubviews=YES;
	routeOverlayView = [[UICRouteOverlayMapView alloc] initWithMapView:routeMapView];
    
    UICGDirectionsOptions *options = [[[UICGDirectionsOptions alloc] init] autorelease];
	options.travelMode = UICGTravelModeDriving;
    
    
    [diretions loadWithStartPoint:startPoint endPoint:endPoint options:options];
    
   // [m.cocos_view removeFromSuperview];
   // [routeOverlayView addSubview: m.cocos_view];
    
    //routeMapView.zoomEnabled=NO;
    
    m.routeMapView =  routeMapView;
//    [NetworkController sharedInstance].delegate = self;
	
//	UIBarButtonItem *space = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil] autorelease];
//	UIBarButtonItem *currentLocationButton = [[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"reticle.png"] style:UIBarButtonItemStylePlain target:self action:@selector(moveToCurrentLocation:)] autorelease];
//    //Sam
//    UIBarButtonItem *zoomPlus = [[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"add.png"] style:UIBarButtonItemStylePlain target:self action:@selector(zoomIn:)] autorelease];
//    UIBarButtonItem *zoomMinus = [[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"remove.png"] style:UIBarButtonItemStylePlain target:self action:@selector(zoomOut:)] autorelease];
    
	//UIBarButtonItem *mapPinButton = [[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"map_pin.png"] style:UIBarButtonItemStylePlain target:self action:@selector(addPinAnnotation:)] autorelease];
	//UIBarButtonItem *routesButton = [[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"list.png"] style:UIBarButtonItemStylePlain target:self action:@selector(showRouteListView:)] autorelease];
    
    
    //[m._server connect];
    
    
//    if(playerNumber==1 && m.game_state == 1){
//        chooseAreaButton = [[[UIBarButtonItem alloc] initWithTitle:@"Choose Area" style:UIBarButtonItemStyleBordered target:self action:@selector(choosingArea:)] autorelease];
//    }
//    else if(playerNumber ==2 && m.game_state ==1) {
//        chooseAreaButton = [[[UIBarButtonItem alloc] initWithTitle:@"Confirm Base" style:UIBarButtonItemStyleBordered target:self action:@selector(choosingArea:)] autorelease];
//    }
////    else if(continueGame ==YES &&playerNumber==1 ) {
////        chooseAreaButton = [[[UIBarButtonItem alloc] initWithTitle:@"End Turn" style:UIBarButtonItemStyleBordered target:self action:@selector(choosingArea:)] autorelease];
////    }    
//	self.toolbarItems = [NSArray arrayWithObjects:currentLocationButton, space,zoomMinus,zoomPlus,space, chooseAreaButton, nil];
//	[self.navigationController setToolbarHidden:NO animated:NO];
    
	diretions = [UICGDirections sharedDirections];
	diretions.delegate = self;
    

    
    
    
//    if(playerNumber ==2){
//        
////        NSString *name = @"iam>P2";
////        [m._server sendData:name];
//        NSString *getSetup = @"get>GS tL bR cC hb1";
//        [m._server sendData:getSetup];
//    }
    
}



- (void) readString:(NSString*)str{
   // NSLog(@"in readString, the str is: %@",str);
    
    DataModel *m = [DataModel getModel];
    NSString * sessionID;
    NSString * playerID;

    bool ready2ndPlayer = false;
    bool goldRead = false;
    
    NSArray *all = [str componentsSeparatedByString:@">"];
    //cat>msg
    NSString *cat = [all objectAtIndex:0];
    NSString *msg = [all objectAtIndex:1];
    NSArray *info;
    
    if([cat isEqualToString:@"gameList"]){
        //parse all game names and send to function _________
        info = [msg componentsSeparatedByString:@","];
        //info now has all the game names broken up
        m.joinList = info;
        
        if([[m.joinList objectAtIndex:0] isEqualToString:@""]){
            m.joinList = nil;
        }
        NSLog(@"%@",m.joinList);
        NSLog(@"joinList count %d",m.joinList.count);
        [m._MapDirectionsViewController callJoinViewController];
        
    }else if([cat isEqualToString:@"continueList"]){
        info = [msg componentsSeparatedByString:@","];
        m.continueList = info;
        
        if([[m.continueList objectAtIndex:0] isEqualToString:@""]){
            m.continueList = nil;
        }
        NSLog(@"%@",m.continueList);
//        [m._MapDirectionsViewController 
        
    }else if([cat isEqualToString:@"createGame"]){
        //sends session id and playerid (createGame>sessionID:info playerID:info)
        //sends INVALID if game name already exists
        //NSLog(@"msg is %@",msg);
        info = [msg componentsSeparatedByString:@" "];
        
        if([[info objectAtIndex:0] isEqualToString:@"INVALID"]){
            NSLog(@"invalid game name, already exists");
            //call up screen to say that the game name already exist
            UIAlertView* areaAlert = [[UIAlertView alloc] initWithTitle:@"Game name exists. Rename Game." message:@"" delegate:self cancelButtonTitle:@"OK!" otherButtonTitles: nil];
            [areaAlert show];
            
            [m._MainMenuCocosLayer ChangeBackToNormalBtn_search1];

            
        }else{
            for(int i =0; i < info.count; i++){
                NSArray *a = [[info objectAtIndex:i] componentsSeparatedByString:@":"];
                NSString *before = [a objectAtIndex:0];
                NSString *after = [a objectAtIndex:1];
            
                if([before isEqualToString:@"sessionID"]){
                    sessionID = after;
                    m.sessionID = sessionID;
                }else if([before isEqualToString:@"playerID"]){
                    playerID = after;
                    m.playerID = playerID;
                }
            }
            
          //  NSLog(@"session ID = %@,    playerID = %@",sessionID, playerID);
            
            [m._MainMenuCocosLayer actualNewGameFunc];
        }
        
        
    }else if([cat isEqualToString:@"joinGame"]){
        info = [msg componentsSeparatedByString:@" "];
        for(int i =0; i < info.count; i++){
            NSArray *a = [[info objectAtIndex:i] componentsSeparatedByString:@":"];
            NSString *before = [a objectAtIndex:0];
            NSString *after = [a objectAtIndex:1];
            
            if([before isEqualToString:@"sessionID"]){
                sessionID = after;
                m.sessionID = sessionID;
            }else if([before isEqualToString:@"playerID"]){
                playerID = after;
                m.playerID = playerID;
            }
        }
        
      //  NSLog(@"session ID = %@,    playerID = %@",sessionID, playerID);
        //TODO immediatley call for bR, tL, and cC and hb
      //  NSLog(@"setting up player 2's game");
        NSString *setup = @"get>tL bR cC hb_lat hb_lon hb_player";
        [m._server sendData:setup];
        
        
    }else if([cat isEqualToString:@"refresh"]){
        [self refresh];
        
    }else if([cat isEqualToString:@"stats"]){
        info = [msg componentsSeparatedByString:@" "];
        for(int i =0; i < info.count; i++){
            NSArray *chunk = [[info objectAtIndex:i] componentsSeparatedByString:@":"];
            NSString *varName = [chunk objectAtIndex:0];
            NSString *varVal = [chunk objectAtIndex:1];
            
            if([varName isEqualToString:@"gold_value"]){
                m.gold_value = [varVal componentsSeparatedByString:@","];
                goldRead = true;
                
            }else if([varName isEqualToString:@"gold_player"]){
                m.gold_player = [varVal componentsSeparatedByString:@","];
            
            }else if([varName isEqualToString:@"c_type"]){
                m.c_type = [varVal componentsSeparatedByString:@","];
            
            }else if([varName isEqualToString:@"c_player"]){
                m.c_player = [varVal componentsSeparatedByString:@","];
            }
        }
        //call putting the stats in the end screen
        //all info for stats should be in the variables above
        if(m.baseHealth <=0){
            [m._gameHUDLayer loseWindow];
  
            
        }else{
            [m._gameHUDLayer winWindow];
          
        }
        
        
    
    }else if([cat isEqualToString:@"get"]){
        //get>variableName:something,something varname2:blah 
        
        
        info = [msg componentsSeparatedByString:@" "];
        for(int i =0; i < info.count; i++){
            NSArray *chunk = [[info objectAtIndex:i] componentsSeparatedByString:@":"];
            NSString *varName = [chunk objectAtIndex:0];
            NSString *varVal = [chunk objectAtIndex:1];
            
            //go through all possible variable names
            if([varName isEqualToString:@"tL"]){
                NSArray *latlong = [varVal componentsSeparatedByString:@","];
                toLe = CLLocationCoordinate2DMake([[latlong objectAtIndex:0] floatValue] , [[latlong objectAtIndex:1] floatValue]); 
                         
            }else if([varName isEqualToString:@"bR"]){
                NSArray *latlong = [varVal componentsSeparatedByString:@","];
                boRi = CLLocationCoordinate2DMake([[latlong objectAtIndex:0] floatValue] , [[latlong objectAtIndex:1] floatValue]); 
            
            }else if([varName isEqualToString:@"cC"]){
                NSArray *latlong = [varVal componentsSeparatedByString:@","];
                sP = CLLocationCoordinate2DMake([[latlong objectAtIndex:0] floatValue] , [[latlong objectAtIndex:1] floatValue]);
                ready2ndPlayer = true;
            }
            else if([varName isEqualToString:@"hb_lat"]){
                m.hb_lat = [varVal componentsSeparatedByString:@","];
            
            }else if([varName isEqualToString:@"hb_lon"]){
                m.hb_lon = [varVal componentsSeparatedByString:@","];
            
            }else if([varName isEqualToString:@"hb_player"]){
                m.hb_player = [varVal componentsSeparatedByString:@","];
                NSLog(@"hb_player.count %d",m.hb_player.count);
                
            }else if([varName isEqualToString:@"t_lat"]){
                m.t_lat= [varVal componentsSeparatedByString:@","];
                
            }else if([varName isEqualToString:@"t_lon"]){
                m.t_lon = [varVal componentsSeparatedByString:@","];
           
            }else if([varName isEqualToString:@"t_type"]){
                m.t_type = [varVal componentsSeparatedByString:@","];
                
            }else if([varName isEqualToString:@"t_player"]){
                m.t_player = [varVal componentsSeparatedByString:@","];
            
            }else if([varName isEqualToString:@"c_type"]){
                m.c_type = [varVal componentsSeparatedByString:@","];
                
            }else if([varName isEqualToString:@"c_player"]){
                m.c_player = [varVal componentsSeparatedByString:@","];
                
            }else if([varName isEqualToString:@"GS"]){
                m.game_state = [varVal intValue];          
                NSLog(@"game state = %d",m.game_state);

            }else if([varName isEqualToString:@"gold"]){
                m.gold = [varVal intValue];
                NSLog(@"gold = %d",m.gold);
                goldRead = true;
            }
        }
    }
    
    if(!goldRead){
        //for homebases
        if(m.hb_player.count >0 && m.game_state <=2){
            [self parseHB];
            if(m.game_state ==2){
                
                [self makeRealRoute];
                if(m.tempBoo ==true){
                    
                    //[m._MainMenuCocosLayer add_removeEndTurnButton];
                    [m._MainMenuCocosLayer add_removeOkButton];//????R
                    [m._gameLayer callTowerSelectMenu];
                    m.tempBoo = false;
                    
                }
            }
        }
        NSLog(@"m.game_state==%d",m.game_state);
          NSLog(@"cat==%d",[cat isEqualToString:@"refresh"]);
        
        if(m.game_state ==3 && ![cat isEqualToString:@"refresh"]){
            NSLog(@"GameState3!!!!!");
            
            [m._MainMenuCocosLayer add_removesendWaveButton];
            
            
        }
        
        //for creeps
        if(m.game_state ==4)// && [m._creepsOrder objectAtIndex:0]!=nil)
        {
            NSLog(@"gamestate==4");
            [self parseCreeps];
        }
//        else
//        {NSLog(@"END TURN!!!!");
//        }

        
        //for towers
        if(m.t_lat != nil && m.t_lon != nil && m.t_player !=nil && m.t_type !=nil && m.game_state ==3){
            [self parseTowers];
        }
        
        //setup map b/c 2nd player is ready to join game
        if(ready2ndPlayer){
            [self setupMap];
            ready2ndPlayer=false;
            [self detectingEnemyBasePos];
        }
    }
    
}

//after calling this the server will put entire games worth of creeps and gold in m.gold, m.c_type, and m.c_player
- (void) detectingEnemyBasePos{
    DataModel *m = [DataModel getModel];
    [m._MainMenuCocosLayer add_removeConfirmButton];
    for(int i=0; i<m.hb_player.count;i++){
        if(![m.playerID isEqualToString:[m.hb_player objectAtIndex:i]]){
            CLLocation *loc = [[CLLocation alloc] initWithLatitude:[[m.hb_lat objectAtIndex:i] floatValue] longitude:[[m.hb_lon objectAtIndex:i] floatValue]];
            m._prevEnemyHomeBasePos = loc;
            CGPoint Point = [m.routeMapView convertCoordinate:loc.coordinate toPointToView:m.cocos_view];
            int xPos= [[CCDirector sharedDirector] convertToGL:Point].x;
            int yPos= [[CCDirector sharedDirector] convertToGL:Point].y;
                                   
            float xd1 = xPos - 72;
            float yd1 = yPos - 357;
            float distance1 = xd1*xd1 + yd1*yd1;
            
            float xd2 = xPos - 248;
            float yd2 = yPos - 357;
            float distance2 = xd2*xd2 + yd2*yd2;
            
            float xd3 = xPos - 72;
            float yd3 = yPos - 123;
            float distance3 = xd3*xd3 + yd3*yd3;
            
            float xd4 = xPos - 248;
            float yd4 = yPos - 123;
            float distance4 = xd4*xd4 + yd4*yd4;
            
            if(distance1<distance2 && distance1<distance3 && distance1<distance4){
                [m._gameHUDLayer removeEnemyBaseChoise:1];
            }else if(distance2<distance1 && distance2<distance3 && distance2<distance4){
                [m._gameHUDLayer removeEnemyBaseChoise:2];
            }else if(distance3<distance1 && distance3<distance2 && distance3<distance4){
                [m._gameHUDLayer removeEnemyBaseChoise:3];
            }else if(distance4<distance1 && distance4<distance2 && distance4<distance3){
                [m._gameHUDLayer removeEnemyBaseChoise:4];
            }
            
           // NSLog(@"\nDistance = %f, %f, %f, %f", distance1,distance2,distance3,distance4 );
        }
    }
}

-(void) callStats{
    NSLog(@"callStats");
    DataModel *m = [DataModel getModel];
    [m._server sendData:@"stats>"];
    
}

-(void) setupMap{
    NSLog(@"setupMap");
    DataModel *m = [DataModel getModel];
    

    routeMapView.topLeft = toLe; 
    routeMapView.botRight = boRi;
    
    [routeMapView setCenterCoordinate:sP zoomLevel:16 animated:NO];
    [[VariableStore vStore] setZoom:16];
    [[VariableStore vStore] setGameArea:YES];
}

-(void) parseHB{
    DataModel *m = [DataModel getModel];
    
    [m._gameLayer removeHBs];
   
   // NSLog(@"hb_lat = %@, hb_lon = %@, hb_player = %@",m.hb_lat, m.hb_lon, m.hb_player);

    
    for(int i=0; i<m.hb_player.count;i++){
        if([m.playerID isEqualToString:[m.hb_player objectAtIndex:i]]){
            CLLocation *loc = [[CLLocation alloc] initWithLatitude:[[m.hb_lat objectAtIndex:i] floatValue] longitude:[[m.hb_lon objectAtIndex:i] floatValue]];
            m._prevHomeBasePos = loc;
            CGPoint Point = [m.routeMapView convertCoordinate:loc.coordinate toPointToView:m.cocos_view];
            [m._gameLayer addHomeBase:[[CCDirector sharedDirector] convertToGL:Point]];
           // NSLog(@"my home base");
        }
        else{
            CLLocation *loc2 = [[CLLocation alloc] initWithLatitude:[[m.hb_lat objectAtIndex:i] floatValue] longitude:[[m.hb_lon objectAtIndex:i] floatValue]];
            m._prevEnemyHomeBasePos = loc2;
            CGPoint Point2 = [m.routeMapView convertCoordinate:loc2.coordinate toPointToView:m.cocos_view];
            [m._gameLayer addEnemyHomeBase:[[CCDirector sharedDirector] convertToGL:Point2]];
           // NSLog(@"enemy home base");
        }
    }
}

-(void) parseTowers{
    DataModel *m = [DataModel getModel];
    NSLog(@"parseTowers");
    
    //--Rau
    m.parsingTower=true;
    //--
    NSMutableArray *discardedItems = [[NSMutableArray alloc] init];
    for (Tower *tower1 in m._towers) {
        [discardedItems addObject:tower1];
        [tower1 removeIt];
    }
    [m._towers removeObjectsInArray:discardedItems];
    [discardedItems release];
    
    NSMutableArray *discardedItemsToSend = [[NSMutableArray alloc] init];
    for (Tower *tower1 in m._towersToSend) {
        [discardedItemsToSend addObject:tower1];
        [tower1 removeIt];
    }
    [m._towers removeObjectsInArray:discardedItemsToSend];
    [discardedItemsToSend release];
    
    NSMutableArray *deleteExtraArea = [[NSMutableArray alloc] init];
    for (Tower *tower1 in m.extraArea) {
        [deleteExtraArea addObject:tower1];
    }
    [m._towers removeObjectsInArray:deleteExtraArea];
    [deleteExtraArea release];
    
    if([[m.t_type objectAtIndex:0] intValue]!=0 ){
       for(int i=0; i<m.t_player.count;i++){
        if([m.playerID isEqualToString:[m.t_player objectAtIndex:i]]){
            CLLocation *loc = [[CLLocation alloc] initWithLatitude:[[m.t_lat objectAtIndex:i] floatValue] longitude:[[m.t_lon objectAtIndex:i] floatValue]];
            CGPoint Point = [m.routeMapView convertCoordinate:loc.coordinate toPointToView:m.cocos_view];
            if([m.playerID isEqualToString:[m.hb_player objectAtIndex:0]]){
                [m._gameLayer addTower:[[CCDirector sharedDirector] convertToGL:Point],[[m.hb_player objectAtIndex:0] intValue],[[m.t_type objectAtIndex:i] intValue]];
            }else{
                 [m._gameLayer addTower:[[CCDirector sharedDirector] convertToGL:Point],[[m.hb_player objectAtIndex:1] intValue],[[m.t_type objectAtIndex:i] intValue]];
            }
        }
        else{
            CLLocation *loc = [[CLLocation alloc] initWithLatitude:[[m.t_lat objectAtIndex:i] floatValue] longitude:[[m.t_lon objectAtIndex:i] floatValue]];
            CGPoint Point = [m.routeMapView convertCoordinate:loc.coordinate toPointToView:m.cocos_view];
            if(![m.playerID isEqualToString:[m.hb_player objectAtIndex:0]]){
                [m._gameLayer addTower:[[CCDirector sharedDirector] convertToGL:Point],[[m.hb_player objectAtIndex:0] intValue],[[m.t_type objectAtIndex:i] intValue]];
            }else{
                [m._gameLayer addTower:[[CCDirector sharedDirector] convertToGL:Point],[[m.hb_player objectAtIndex:1] intValue],[[m.t_type objectAtIndex:i] intValue]];
            }
        }
     }
    }
    
    //--Rau
    m.parsingTower=false;
    //--
}

-(void) parseCreeps{
    DataModel *m = [DataModel getModel];
    NSLog(@"parseCreeps");
   //  NSLog(@"%@     %@",m.c_type,      m.c_player);
    
    if([[m.c_player objectAtIndex:0]intValue]!=0){
    
        if(m.stopWave==false){
                    for(int i=0; i<m.c_player.count;i++){
                        if(![m.playerID isEqualToString:[m.c_player objectAtIndex:i]]){
                            [m._creepsOrder addObject:[m.c_type objectAtIndex:i]];
                        }
                        else{
                            [m._creepsEnemyOrder addObject:[m.c_type objectAtIndex:i]];
                        }
                    }
                    [m._gameLayer addWaves: m._creepsOrder.count]; //updatedin waveFormatter
                    [m._gameLayer schedule:@selector(update:)];
                    [m._gameLayer schedule:@selector(gameLogic:) interval:1.0];
            
        }else
        {
                    NSMutableArray *discardedItems = [NSMutableArray array];
                    for (Creep *creep1 in m._creepsOrder) {
                        [discardedItems addObject:creep1];
                    }
                    [m._creepsOrder removeObjectsInArray:discardedItems];
                    
                    
                    NSMutableArray *discardedEnemyItems = [NSMutableArray array];
                    for (Creep *creepEnemy in m._creepsEnemyOrder) {
                        [discardedEnemyItems addObject:creepEnemy];
                    }
                    [m._creepsEnemyOrder removeObjectsInArray:discardedEnemyItems];
                    
                    for(int i=0; i<m.c_player.count;i++){
                        if(![m.playerID isEqualToString:[m.c_player objectAtIndex:i]]){
                            [m._creepsOrder addObject:[m.c_type objectAtIndex:i]];
                        }
                        else{
                            [m._creepsEnemyOrder addObject:[m.c_type objectAtIndex:i]];
                        }
                    }
                    [m._gameLayer resetWaveSystem];
            
        }
    }else{
        [m._MainMenuCocosLayer add_removeEndTurnButton];
    }
    
    
    m.creepsSent += m._creepsOrder.count;
    
}

- (void)dealloc {
	[routeOverlayView release];
	[startPoint release];
	[endPoint release];
    [wayPoints release];
    [rPoints release];
    

    //   [cocos_view release];
    [super dealloc];
}

- (void)GettingStarted2 {  
    
//    if(playerNumber ==1){
    NSLog(@"update-------------");
        [super viewDidLoad];
        if (diretions.isInitialized) {
            NSLog(@"update in viewDidLoad");
            [self update];	
        }
//    }
    
    //[self reverseGeocoder:(MKReverseGeocoder *)geocoder didFindPlacemark:(MKPlacemark *)placemark];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void) goToAddress{
     DataModel *m = [DataModel getModel];
    startPoint = inputAddress.text;
    endPoint = startPoint;
    //NSLog(@"gotoaddress startpoint is %@",startPoint);
    searchTouched=true;
    m.zoom2Region = true;
    [self update];

}


- (void)update {
    NSLog(@"MapDirectionsViewController update()");
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
	  
	UICGDirectionsOptions *options = [[[UICGDirectionsOptions alloc] init] autorelease];
	options.travelMode = UICGTravelModeDriving;
    
    
    [diretions loadWithStartPoint:startPoint endPoint:endPoint options:options];
    [routeMapView setNeedsDisplay];
    [routeOverlayView setNeedsDisplay];
    
//    if(playerNumber ==1 && m.game_state ==1){
//        if(startPoint == nil){
//    //        [routeMapView setCenterCoordinate:[routeMapView.userLocation coordinate] animated:YES];
//            [diretions loadWithStartPoint:[NSString stringWithFormat:@"%1.9f,%1.9f", routeMapView.userLocation.coordinate.latitude, routeMapView.userLocation.coordinate.longitude] endPoint: [NSString stringWithFormat:@"%1.9f,%1.9f", routeMapView.userLocation.coordinate.latitude, routeMapView.userLocation.coordinate.longitude] options:options];
//            NSLog(@"%1.9f,%1.9f", routeMapView.userLocation.coordinate.latitude, routeMapView.userLocation.coordinate.longitude);
//            
//        }else{
////           [diretions loadWithStartPoint:startPoint endPoint:startPoint options:options];
//            [diretions loadWithStartPoint:startPoint endPoint:endPoint options:options];
//        }
//        
//        if ([wayPoints count] > 0) {
//            NSArray *routePoints = [NSArray arrayWithObject:startPoint];
//            routePoints = [routePoints arrayByAddingObjectsFromArray:wayPoints];
//            routePoints = [routePoints arrayByAddingObject:endPoint];
//            [diretions loadFromWaypoints:routePoints options:options];
//          
//        }
//        else {
//            [diretions loadWithStartPoint:startPoint endPoint:endPoint options:options];
//        }
//    }else if(playerNumber ==2){
//        [diretions loadWithStartPoint:nil endPoint:nil options:options];
//        if(booReady == YES){
//            
//            routeMapView.topLeft = toLe;
//            routeMapView.botRight = boRi ;
//            [[VariableStore vStore] setZoom:12];
//            [[VariableStore vStore] setGameArea:YES];
//            
//            [routeMapView setCenterCoordinate:sP zoomLevel:12 animated:YES];
//            booReady = NO;
//        
//        
//            //-----------------------------------------
//            [routeOverlayView init_CocosView];
//            CLLocation *loc = [[CLLocation alloc] initWithLatitude:hb1_coord.latitude longitude:hb1_coord.longitude];
//            m._prevEnemyHomeBasePos = loc;
//        
//            CGPoint Point = [m.routeMapView convertCoordinate:loc.coordinate toPointToView:m.cocos_view];
//            [m._gameLayer addEnemyHomeBase:[[CCDirector sharedDirector] convertToGL:Point]];
//            NSLog(@"hb1 = %@",loc);
//        }
//    
//    }
}



- (void)moveToCurrentLocation:(id)sender {
	[routeMapView setCenterCoordinate:[routeMapView.userLocation coordinate] animated:YES];
   // NSLog(@"%1.9f,%1.9f",routeMapView.userLocation.coordinate.latitude, routeMapView.userLocation.coordinate.longitude);
    DataModel *m=[DataModel getModel];
    //m.VIP=1;
    //[m._WaveCreationUIlayer init]; 
    
}

- (void)addPinAnnotation:(id)sender {
	UICRouteAnnotation *pinAnnotation = [[[UICRouteAnnotation alloc] initWithCoordinate:[routeMapView centerCoordinate]
																				  title:nil
																		 annotationType:UICRouteAnnotationTypeWayPoint] autorelease];
	[routeMapView addAnnotation:pinAnnotation];
}

- (void)zoomIn{
    DataModel *m = [DataModel getModel];
//    NSUInteger zoom = [[VariableStore vStore] getZoom];
//
//    //b4 zooming, get creeps positions and store as CLLocation
//    [m._gameLayer keepPositions:routeMapView];
//    [m._gameLayer keepProjectilesPos:routeMapView];
//    [m._gameLayer keepHomeBasePos:routeMapView];
//    [m._gameLayer keepEnemyHomeBasePos:m.routeMapView];
//       
//    if(zoom == 13){
//        
//    }else{
//        [m._gameLayer getHomeBaseArea].scale*=2;
//        [m._gameLayer getEnemyHomeBaseArea].scale*=2;
//
//        zoom = zoom +1;
//        [routeMapView setCenterCoordinate:routeMapView.centerCoordinate zoomLevel:zoom animated:YES];
//        
//        //--Rau--
//        for (Tower *tower1 in m._towers) {
//            tower1.scale=tower1.scale*2;
//     
//        }
//        [m._gameLayer HomeBaseZoomIn];
//       
//        //[m._gameLayer zoomInCreeps];
//     
//        for (CCSprite *target in m._targets) 
//        {
//            target.scale*=2;
//        }
//        m.moveScale*=2;
//    }
//   // [[VariableStore vStore] setZoom:zoom];
//     NSLog(@"zoom is now: %1.0u",zoom);
}

- (void)zoomOut{
    DataModel *m = [DataModel getModel];
//  
//    NSUInteger zoom = [[VariableStore vStore] getZoom];
//    [m._gameLayer keepPositions:routeMapView];
//    [m._gameLayer keepProjectilesPos:routeMapView];
//    [m._gameLayer keepHomeBasePos:routeMapView];
//    [m._gameLayer keepEnemyHomeBasePos:m.routeMapView];
//    
//    
//    if(zoom == 1){
//        
//    }else{
//        if([[VariableStore vStore] getGameAreaSet] == YES && zoom > 13){
//            [m._gameLayer getHomeBaseArea].scale/=2;
//            [m._gameLayer getEnemyHomeBaseArea].scale/=2;
//            zoom = zoom -1;
//            [routeMapView setCenterCoordinate:routeMapView.centerCoordinate zoomLevel:zoom animated:YES];
//           
//            //--Rau--
//            [m._gameLayer HomeBaseZoomOut];
//            for (Tower *tower1 in m._towers) {
//                tower1.scale=tower1.scale/2;
//            }
//      
//            //  [m._gameLayer zoomOutCreeps];
//            for (CCSprite *target in m._targets) 
//            {
//                target.scale/=2;
//            }
//            
//            m.moveScale/=2;
//            
//            
//        }else if([[VariableStore vStore] getGameAreaSet] == NO){
//            
//            zoom = zoom -1;
//            [routeMapView setCenterCoordinate:routeMapView.centerCoordinate zoomLevel:zoom animated:YES];
//        }
//        [routeMapView scrollViewDidEndDragging:(UIScrollView *) routeMapView willDecelerate:YES];
//       // [routeMapView scrollViewDidEndDragging:routeMapView willDecelerate:YES];
//    }
//   // [[VariableStore vStore] setZoom:zoom];
//    NSLog(@"zoom is now: %1.0u",zoom);
}

- (void)choosingArea{
   // DataModel *m = [DataModel getModel];
    NSLog(@"Choose Area");
    
    if(searchTouched==false){
        CLLocationCoordinate2D loc= CLLocationCoordinate2DMake(34.028407, -118.288808);
        [routeMapView setCenterCoordinate:loc zoomLevel:16 animated:YES];
        [[VariableStore vStore] setZoom:16];
    }else{
        [routeMapView setCenterCoordinate:routeMapView.centerCoordinate zoomLevel:16 animated:YES];
        [[VariableStore vStore] setZoom:16];
    }
    
    //call up screen to confirm or cancel
    UIAlertView* areaAlert = [[UIAlertView alloc] initWithTitle:@"Choose this game area?" message:@"What you see is what you get." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    [areaAlert show];
        
//        startPoint = [NSString stringWithFormat:@"%f, %f",routeMapView.centerCoordinate.latitude,routeMapView.centerCoordinate.longitude];
//        NSLog(@"startpoint = %@",startPoint);
}

- (void)confirmBase{
        DataModel *m = [DataModel getModel];
        NSLog(@"Confirm Base");
    
    if([m._gameHUDLayer chooseHB]==false){
        UIAlertView* areaAlert = [[UIAlertView alloc] initWithTitle:@"Please choose location!" message:@"" delegate:self cancelButtonTitle:@"OK!" otherButtonTitles: nil];
        [areaAlert show];
        
    }else{
        [m._MainMenuCocosLayer add_removeConfirmButton];
        [m._gameLayer keepHomeBasePos:m.routeMapView];
        m.HomeBaseTouchEnable_GameLayer=false;
        
        CLLocation *loc = m._prevHomeBasePos;
        NSString *homeBase_lat = [NSString stringWithFormat:@"%f", loc.coordinate.latitude];
        NSString *homeBase_lon = [NSString stringWithFormat:@"%f", loc.coordinate.longitude];


       NSString *hb = [NSString stringWithFormat:@"set>hb_lat:%@ hb_lon:%@ hb_player:%@",homeBase_lat, homeBase_lon, m.playerID];
        [m._server sendData:hb];
     
    }
    
    //--Rau--
//    for (Tower *tower1 in m._towers) {
//        tower1.scale=tower1.scale*2;
//        
//    }
   // [m._gameLayer HomeBaseZoomIn];
   // m.moveScale*=2;
    
  //  [m._gameLayer getHomeBaseArea].scale*=2;
   // [m._gameLayer getEnemyHomeBaseArea].scale*=2;
    
    //[routeMapView setCenterCoordinate:routeMapView.centerCoordinate zoomLevel:16 animated:YES];
    //[[VariableStore vStore] setZoom:16];

//    [m._gameHUDLayer addTurrets];//???R
        
}

- (void)refresh{
    DataModel *m = [DataModel getModel];
    NSString *game_state;
    //get game state from server
    if(m.game_state ==1){
        NSLog(@"refresh 1");
        game_state = @"get>GS hb_lat hb_lon hb_player";
        
    }else if(m.game_state == 2){
        NSLog(@"refresh 2");
        //get towers
        game_state = @"get>GS t_lat t_lon t_type t_player";
        
    }else if(m.game_state ==3){
        NSLog(@"refresh 3");
        game_state = @"get>GS c_type c_player";
    }
    
    [m._server sendData:game_state];
}
 
//ending tower turns
- (void)endTurn{
    NSLog(@"endTurn");
    DataModel *m = [DataModel getModel];
    NSLog(@"game_state = %d",m.game_state);
    if(m.game_state ==2){
        [m._gameHUDLayer removeTurret];
         NSString *t_lat = nil;
         NSString *t_lon = nil;
         NSString *t_player = nil;
        NSString *t_type = nil;
         NSString *begLat = nil;
         NSString *begLon = nil;
         NSString *begPlayer = nil;
        NSString *begType = nil;
         bool first = YES;
       // NSLog(@"tower count = %d",m._towersToSend.count);
         for (Tower *tower1 in m._towersToSend) {
            NSString *tower_lat = [NSString stringWithFormat:@"%f", tower1.coord.coordinate.latitude];
            NSString *tower_lon = [NSString stringWithFormat:@"%f", tower1.coord.coordinate.longitude];
             NSString *tower_type = [NSString stringWithFormat:@"%d",tower1.type];
            
            if(first){
                t_lat = [NSString stringWithFormat:@"%@", tower_lat];
                t_lon = [NSString stringWithFormat:@"%@", tower_lon];
                t_type = [NSString stringWithFormat:@"%@",tower_type];
                t_player = [NSString stringWithFormat:@"%@", m.playerID];
                
                first = NO;
            }else{
                t_lat = [t_lat stringByAppendingFormat:@",%@",tower_lat];
                t_lon = [t_lon stringByAppendingFormat:@",%@",tower_lon];
                t_type = [t_type stringByAppendingFormat:@",%@",tower_type];
                t_player = [t_player stringByAppendingFormat:@",%@", m.playerID];
            }
         }

        if(t_lat != nil){
             begLat = @"set>t_lat:";
             begLon = @"t_lon:";
             begPlayer = @"t_player:";
            begType = @"t_type:";

             
             t_lat = [begLat stringByAppendingString:t_lat];
             t_lon = [begLon stringByAppendingString:t_lon];
            t_type = [begType stringByAppendingString:t_type];
             t_player = [begPlayer stringByAppendingString:t_player];
             t_lat = [t_lat stringByAppendingFormat:@" %@ %@ %@",t_lon, t_type, t_player];
            // NSLog(@"t_latlonplayer = %@",t_lat);
             [m._server sendData:[NSString stringWithFormat:@"%@ gold:%d", t_lat, m.gold]];
//            [m._server sendData:t_lat];
        }else{
            //player did not setup any towers
            [m._gameHUDLayer removeTurret];
            [m._server sendData:[NSString stringWithFormat:@"set>t_lat: t_lon: t_type: t_player: gold:%d", m.gold]];
        }
        
    }
    
    if(m.game_state ==4){
        m.game_state =2;
        [m._server sendData:@"set>GS:2"];
        
        m.tempBoo=true;
        NSLog(@"Total income is: %d", m.totalIncome);
        [m._gameHUDLayer updateResources:m.totalIncome];// income per turn
       [m._gameHUDLayer updateWaveCount];
        
        //Rau
       // m.gold=m.gold+m.totalIncome;
       // [m._gameHUDLayer updateResources:m.totalIncome];
      //  [resourceLabel setString:[NSString stringWithFormat: @"%i",m.gold]];
        //
        
      //  NSLog(@"m.goldddd=%d",m.gold);
        
    }


}

- (void) makeRealRoute{
    UICGDirectionsOptions *options = [[[UICGDirectionsOptions alloc] init] autorelease];
	options.travelMode = travelMode;
    
    DataModel *m = [DataModel getModel];
    m.zoom2Region = false;
    
    //if([m.playerID isEqualToString:[m.hb_player objectAtIndex:i]]){

    startPoint = [NSString stringWithFormat:@"%@, %@",[m.hb_lat objectAtIndex:0]  ,[m.hb_lon objectAtIndex:0]];
    endPoint = [NSString stringWithFormat:@"%@, %@",[m.hb_lat objectAtIndex:1]  ,[m.hb_lon objectAtIndex:1]];;
    //NSLog(@"in makeRealRoute, sp = %@, ep = %@",startPoint,endPoint);
    [routeMapView setNeedsDisplay];
   
    [diretions loadWithStartPoint:startPoint endPoint:endPoint options:options];
    
    [routeMapView scrollViewDidEndDragging:(UIScrollView *) routeMapView willDecelerate:YES];
    [routeMapView setNeedsDisplay];
    [self update];
    [routeOverlayView setNeedsDisplay];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    DataModel *m = [DataModel getModel];
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    
    if([title isEqualToString:@"OK"]){    
        
    [self disableScrolling];
    [m._MainMenuCocosLayer addHomeBaseUI];
    [self runSearchAddress];
     
        //rau------------------
        // save waypoint pos from map to DataModel
        DataModel *m=[DataModel getModel];
         for(int i = 0; i < rPoints.count; i++) {
            CLLocation* loc= [rPoints objectAtIndex:i];  
              [m._wayPointsFromMap addObject: loc];
        }

        
        //-----------
        //disable the back button on the top of the navigation tab
//       NSString *maybetitle =  [self.navigationController.tabBarController
//                                title];
//        NSLog(@"maybetitle = %@",maybetitle);
        
        
        [[VariableStore vStore] setGameArea:YES];
        NSLog(@"pressed OK, game area chosen");
        
        [m._MainMenuCocosLayer add_removeConfirmButton];
        MKCoordinateRegion gameArea = routeMapView.region;
        routeMapView.topLeft= CLLocationCoordinate2DMake(routeMapView.centerCoordinate.latitude + gameArea.span.latitudeDelta/2, routeMapView.centerCoordinate.longitude - gameArea.span.longitudeDelta/2);
        routeMapView.botRight= CLLocationCoordinate2DMake(routeMapView.centerCoordinate.latitude - gameArea.span.latitudeDelta/2, routeMapView.centerCoordinate.longitude + gameArea.span.longitudeDelta/2);
    
        
        NSString *topLeft_lat = [NSString stringWithFormat:@"%f", routeMapView.topLeft.latitude];
        NSString *topLeft_lon = [NSString stringWithFormat:@"%f", routeMapView.topLeft.longitude];
        
        NSString *botRight_lat = [NSString stringWithFormat:@"%f", routeMapView.botRight.latitude];
        NSString *botRight_lon = [NSString stringWithFormat:@"%f", routeMapView.botRight.longitude];
        
        NSString *centerCoordinate_lat = [NSString stringWithFormat:@"%f", routeMapView.centerCoordinate.latitude];
        NSString *centerCoordinate_lon = [NSString stringWithFormat:@"%f", routeMapView.centerCoordinate.longitude];
        
        NSString *tL = [NSString stringWithFormat:@"tL:%@,%@",topLeft_lat,topLeft_lon];
        NSString *bR = [NSString stringWithFormat:@"bR:%@,%@",botRight_lat,botRight_lon];
        NSString *cC = [NSString stringWithFormat:@"cC:%@,%@",centerCoordinate_lat,centerCoordinate_lon];
        
        NSString *send = [NSString stringWithFormat:@"set>%@ %@ %@",tL,bR,cC];
       // NSLog(@"sending ... %@",send);
        [m._server sendData:send];
        
        [self deactivateMapView];
    }
}

-(void)deactivateMapView{
    routeMapView.userInteractionEnabled=NO;
    routeOverlayView.userInteractionEnabled=NO;
}


- (void)showRouteListView:(id)sender {
	RouteListViewController *controller = [[RouteListViewController alloc] initWithStyle:UITableViewStyleGrouped];
	controller.routes = diretions.routes;
	UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
	[self presentModalViewController:navigationController animated:YES];
	[controller release];
	[navigationController release];
}


#pragma mark <UICGDirectionsDelegate> Methods

- (void)directionsDidFinishInitialize:(UICGDirections *)directions {
    NSLog(@"update in directionsDidFinishInitialize");
	[self update];
}

- (void)directions:(UICGDirections *)directions didFailInitializeWithError:(NSError *)error {
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Map Directions" message:[error localizedFailureReason] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
	[alertView show];
	[alertView release];
}


- (void)directionsDidUpdateDirections:(UICGDirections *)directions {
   // NSLog(@"directionsDidUpdateDirections");
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	
	// Overlay polylines
	UICGPolyline *polyline = [directions polyline];
	NSArray *routePoints = [polyline routePoints];
	[routeOverlayView setRoutes:routePoints];
    
    
    //-- writing array to rpoints and calling function CalculateRoutePoints to draw waypoints 
   rPoints=routePoints;
    
    
    
          
        
    // [self   CalculateRoutePoints:6000];
    //-----
    
    //KEEPKEEPKEEPKEEPKEEPKEEPKEEPKEEP KEEP KEEP KEEP KEEP KEEP KEEP
//	// Add annotations
//	UICRouteAnnotation *startAnnotation = [[[UICRouteAnnotation alloc] initWithCoordinate:[[routePoints objectAtIndex:0] coordinate]
//																					title:startPoint
//																		   annotationType:UICRouteAnnotationTypeStart] autorelease];
//	UICRouteAnnotation *endAnnotation = [[[UICRouteAnnotation alloc] initWithCoordinate:[[routePoints lastObject] coordinate]
//																					title:endPoint
//																		   annotationType:UICRouteAnnotationTypeEnd] autorelease];
//	if ([wayPoints count] > 0) {
//		NSInteger numberOfRoutes = [directions numberOfRoutes];
//		for (NSInteger index = 0; index < numberOfRoutes; index++) {
//			UICGRoute *route = [directions routeAtIndex:index];
//			CLLocation *location = [route endLocation];
//			UICRouteAnnotation *annotation = [[[UICRouteAnnotation alloc] initWithCoordinate:[location coordinate]
//																					   title:[[route endGeocode] objectForKey:@"address"]
//																			  annotationType:UICRouteAnnotationTypeWayPoint] autorelease];
//			[routeMapView addAnnotation:annotation];
//		}
//	}
		
	//[routeMapView addAnnotations:[NSArray arrayWithObjects:startAnnotation, endAnnotation, nil]];
}

- (void)directions:(UICGDirections *)directions didFailWithMessage:(NSString *)message {
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Map Directions" message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
	[alertView show];
	[alertView release];
}

#pragma mark <MKMapViewDelegate> Methods

- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated {
	routeOverlayView.hidden =  YES;
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
	routeOverlayView.hidden = NO;    
	[routeOverlayView setNeedsDisplay];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
	static NSString *identifier = @"RoutePinAnnotation";
	
	if ([annotation isKindOfClass:[UICRouteAnnotation class]]) {
		MKPinAnnotationView *pinAnnotation = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
		if(!pinAnnotation) {
			pinAnnotation = [[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier] autorelease];
		}
		
		if ([(UICRouteAnnotation *)annotation annotationType] == UICRouteAnnotationTypeStart) {
			pinAnnotation.pinColor = MKPinAnnotationColorGreen;
		} else if ([(UICRouteAnnotation *)annotation annotationType] == UICRouteAnnotationTypeEnd) {
			pinAnnotation.pinColor = MKPinAnnotationColorRed;
		} else {
			pinAnnotation.pinColor = MKPinAnnotationColorPurple;
		}
		
		pinAnnotation.animatesDrop = YES;
		pinAnnotation.enabled = YES;
		pinAnnotation.canShowCallout = YES;
		return pinAnnotation;
	} else {
		return [routeMapView viewForAnnotation:routeMapView.userLocation];
	}
}

- (NSString *) saveFilePath
{
	NSArray *path =
	NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
	return [[path objectAtIndex:0] stringByAppendingPathComponent:@"savefile.plist"];
    
}

- (NSString *) saveFilePathForHomeBase
{
	NSArray *path =
	NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
	return [[path objectAtIndex:0] stringByAppendingPathComponent:@"saveFilePathForHomeBase.plist"];
    
}
- (void) hideKeyboard {
[inputF resignFirstResponder];
[inputAddress resignFirstResponder];
}

- (void) enableInputText {
    DataModel *m = [DataModel getModel];
    
    if(!inputF){
        inputF = [[UITextField alloc] //initWithFrame:CGRectMake(126.0f, 11.0f, 186.0f, 22.0f) ];
                  initWithFrame:CGRectMake(70.0f, 190.0f, 180.0f, 30.0f) ];

        [inputF setDelegate:self];
        [m.windowT addSubview:inputF];
        
        [inputF release];
        [inputF setText:[NSString stringWithUTF8String:"Trojan Game"]];
		[inputF setBorderStyle:UITextBorderStyleRoundedRect];
		[inputF setAdjustsFontSizeToFitWidth:NO];
		//[inputF setClearButtonMode:UITextFieldViewModeWhileEditing];
		//[inputF setClearsOnBeginEditing:NO];
		[inputF setPlaceholder:nil];
		[inputF setAutocapitalizationType:UITextAutocapitalizationTypeNone];
		[inputF setAutocorrectionType:UITextAutocorrectionTypeNo];
		[inputF setEnablesReturnKeyAutomatically:YES];
		[inputF setKeyboardType:UIKeyboardTypeDefault];
		[inputF setReturnKeyType:UIReturnKeyNext];
		[inputF setEnablesReturnKeyAutomatically:YES];
		
		[inputF setContentVerticalAlignment:UIControlContentVerticalAlignmentBottom];
		[inputF setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    }
    else{
        //address = inputF.text;
        [inputF resignFirstResponder];
        [inputF removeFromSuperview];
        inputF=nil;
    }
}

- (void) runSearchAddress {
    DataModel *m = [DataModel getModel];
    
    if(!inputAddress){
        inputAddress=[[UITextField alloc] //initWithFrame:CGRectMake(126.0f, 11.0f, 186.0f, 22.0f) ];
                      initWithFrame:CGRectMake(40.0f, 10.0f, 180.0f, 30.0f)  ]; //430
        [inputAddress setDelegate:self];
        [m.windowT addSubview:inputAddress];
        
        
        [inputAddress release];
        [inputAddress setText:[NSString stringWithUTF8String:"3025 Ellendale Place, Los Angeles, CA"]];
        [inputAddress setBorderStyle:UITextBorderStyleRoundedRect];
        //[inputF setAdjustsFontSizeToFitWidth:NO];
       // [inputAddress setClearButtonMode:UITextFieldViewModeWhileEditing];
        
        
        //    [inputF setClearsOnBeginEditing:NO];
        //    [inputF setPlaceholder:nil];
        //    [inputF setAutocapitalizationType:UITextAutocapitalizationTypeNone];
        //    [inputF setAutocorrectionType:UITextAutocorrectionTypeNo];
        //    [inputF setEnablesReturnKeyAutomatically:YES];
        //    [inputF setKeyboardType:UIKeyboardTypeDefault];
        //    [inputF setReturnKeyType:UIReturnKeyNext];
        //    [inputF setEnablesReturnKeyAutomatically:YES];
    }
    else{
        [inputAddress resignFirstResponder];
        [inputAddress removeFromSuperview];
        inputAddress=nil;

    }
}

- (void) removeInputText{
    [inputF resignFirstResponder];
    [inputF removeFromSuperview];
    inputF=nil;
}

- (NSString*) returnAddress {
    return address;
    NSLog(@"text = %@",address);
}

- (void) callJoinViewController{
    NSLog(@"joinVIEWCONTROLLER!");
    DataModel *m = [DataModel getModel];
   controller = [[JoinGameViewController alloc] init];
    UIView *towerMenuView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 400.0f)];
	[m.windowT addSubview:towerMenuView];
    m.towerMenuView = towerMenuView;
    [m.towerMenuView addSubview:[controller view]];
    [m.towerMenuView bringSubviewToFront:[controller view]];    
    m.towerMenuView.userInteractionEnabled= YES;
   }

- (void) removeJoinViewController{
    [controller removeFromParentViewController];
    DataModel *m = [DataModel getModel];
    [m.towerMenuView removeFromSuperview];//eta detka delaet svoe delo!
}

//// Override to allow orientations other than the default portrait orientation.
//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
//	return ( UIInterfaceOrientationIsLandscape( interfaceOrientation ) );
//}
//
//
//-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
//{
//	CGRect screenRect = [[UIScreen mainScreen] bounds];
//	CGRect rect = CGRectZero;
//    
//    rect.size = CGSizeMake( screenRect.size.height, screenRect.size.width );
//	
//	EAGLView *glView = [[CCDirector sharedDirector] openGLView];
//	float contentScaleFactor = [[CCDirector sharedDirector] contentScaleFactor];
//	
//	if( contentScaleFactor != 1 ) {
//		rect.size.width *= contentScaleFactor;
//		rect.size.height *= contentScaleFactor;
//	}
//	glView.frame = rect;
//}
//
-(void) disableScrolling{
routeMapView.userInteractionEnabled=NO;
routeOverlayView.userInteractionEnabled=NO;
}
//-(void) restoreState{
//    NSLog(@"restoreState");
//    
//    NSMutableArray *aFrames = [[NSMutableArray alloc] init];
//    aFrames = [[NSUserDefaults standardUserDefaults] objectForKey:@"redRects"];
//    
//    int count = aFrames.count;
//    
//    for (int i = 0; i < count; i++) {
//        UIView *theView = [[UIView alloc] initWithFrame:CGRectFromString([aFrames objectAtIndex:i])];
//        [super.view addSubview:theView];
//    }
//    
//}

@end
