

#import "DataModel.h"
#import "GameHUD.h"
#import "MainMenuCocosLayer.h"
#import "MapDirectionsViewController.h"
#import "VariableStore.h"
#import "WaveCreationLayer.h"

#import "SimpleAudioEngine.h"
@implementation MainMenuCocosLayer


static MainMenuCocosLayer *_sharedMainMenuCocosLayer = nil;

+ (MainMenuCocosLayer *)sharedMainMenuCocosLayer
{
	@synchronized([MainMenuCocosLayer class])
	{
		if (!_sharedMainMenuCocosLayer)
			[[self alloc] init];
		return _sharedMainMenuCocosLayer;
	}
	// to avoid compiler warning
	return nil;
}

+(id)alloc
{
	@synchronized([MainMenuCocosLayer class])
	{
		NSAssert(_sharedMainMenuCocosLayer == nil, @"Attempted to allocate a second instance of a singleton.");
		_sharedMainMenuCocosLayer = [super alloc];
		return _sharedMainMenuCocosLayer;
	}
	// to avoid compiler warning
	return nil;
}

-(id) init
{
	if ((self=[super init]) ) {
            
        background = [CCSprite spriteWithFile:@"Treehouse.png"];
        background.anchorPoint = ccp(0,0);
       //  background.position = ccp(-130, -100);
        background.scale=0.5;
        [self addChild:background z:0];

        [self BuildStartMenu];  
        
//        //---Rau scroll menu
        
//        one = [CCSprite spriteWithFile:@"Enemy1.png"];
//        one.position = ccp(250,200);
//        [self addChild:one];
//        
        //----
        
    }
	return self;
}


- (void) dealloc
{
    
	[super dealloc];
}


- (void) addHomeBaseUI{
    DataModel *m = [DataModel getModel];
    GameHUD * myGameHUD = [GameHUD sharedHUD];
    [m._cocosScene addChild:myGameHUD z:2];
    m._gameHUDLayer = myGameHUD;
    [self removeChild:upBG cleanup:YES];
    upBG = nil; 
    [self removeChild:confirmButton cleanup:YES];
    confirmButton = nil;  
    [self removeChild:buttonSearch cleanup:YES];
    buttonSearch = nil; 
}

- (void) add_removeConfirmButton{
     if(confirmBaseButton==nil){
        confirmBaseButton = [CCSprite spriteWithFile:@"btn_confirm_base.png"];
        confirmBaseButton.scale=.2;
        confirmBaseButton.position = ccp(150, 225);
        [self addChild:confirmBaseButton z:0];
     }else{
         [self removeChild:confirmBaseButton cleanup:YES];
         confirmBaseButton = nil; 
     }
}

//- (void) add_removeRefreshButton{
//    if(!refreshButton){
//        refreshButton = [CCSprite spriteWithFile:@"btn_refresh.png"];
//        refreshButton.scale=.2;
//        refreshButton.position = ccp(150, 100);
//        [self addChild:refreshButton z:0];
//    }else{
//        [self removeChild:refreshButton cleanup:YES];
//        refreshButton = nil;         
//    }
//}

- (void) add_removeEndTurnButton{
    DataModel *m=[DataModel getModel];
    NSLog(@"gameover%d",m.gameover);
    if(EndTurnButton==nil && m.gameover==false){
        EndTurnButton = [CCSprite spriteWithFile:@"btn_end_turn.png"];
        EndTurnButton.scale=.2;
        EndTurnButton.position = ccp(100, 415); 
        [self addChild:EndTurnButton z:0];
        NSLog(@"yesIF");
    }
    else{
          NSLog(@"NoIF");
        [self removeChild:EndTurnButton cleanup:YES];
        EndTurnButton = nil; 
    }
}
- (void) add_removeOkButton{
    DataModel *m=[DataModel getModel];
    if(EndTurnButton==nil && m.gameover==false){
        EndTurnButton = [CCSprite spriteWithFile:@"btn_end_placing_towers1.png"];
        EndTurnButton.scale=.2;
        EndTurnButton.position = ccp(100, 395); //100 415
        [self addChild:EndTurnButton z:0];
    }
    else{
        [self removeChild:EndTurnButton cleanup:YES];
        EndTurnButton = nil; 
    }
}

- (void) add_removesendWaveButton{
    if(sendWaveButton==nil){
        sendWaveButton = [CCSprite spriteWithFile:@"btn_sendWave1.png"];
        sendWaveButton.scale=.2;
        sendWaveButton.position = ccp(100, 415);
        [self addChild:sendWaveButton z:0];
    }
    else{
        [self removeChild:sendWaveButton cleanup:YES];
        sendWaveButton = nil; 
    }
}



//-------------------------Touches-------------------------------------------------

- (void)t_Begin:(UITouch *)touch withEvent:(UIEvent *)event;  
{ 
    DataModel *m = [DataModel getModel];
    CGPoint temp_touchLocation = [touch  locationInView:m.cocos_view];
    CGPoint touchLocation = [[CCDirector sharedDirector] convertToGL:temp_touchLocation];
    [m._MapDirectionsViewController hideKeyboard];
    
    if (CGRectContainsPoint(one.boundingBox, touchLocation)) { 
        //[self fadeInOutText];
//        m.routeMapView.scrollEnabled=NO;
//        //m.towerMenuView.userInteractionEnabled=YES;
//        WaveCreationLayer * myWaveCreationLayer = [WaveCreationLayer sharedWaveCreationLayer];
//        [m._cocosScene addChild:myWaveCreationLayer z:3];
//        m._WaveCreationUIlayer = myWaveCreationLayer;
//        m.VIP=1;
//        [m._WaveCreationUIlayer init];
        //[m._gameHUDLayer winWindow];
    }

  
    
    if (CGRectContainsPoint(buttonNewGame.boundingBox, touchLocation)) { 
         [self ChangeToBtn_create_game2];
        [[SimpleAudioEngine sharedEngine] playEffect:@"ButtonSound.mp3"];
    }
    if (CGRectContainsPoint(buttonJoinGame.boundingBox, touchLocation)) { 
      
         [self ChangeToBtn_join_game2];
        [[SimpleAudioEngine sharedEngine] playEffect:@"ButtonSound.mp3"];
    }
   // if (CGRectContainsPoint(buttonContinueGame.boundingBox, touchLocation)) { 
   //      [self ChangeToBtn_continue2];
   // }
    if (CGRectContainsPoint(buttonStart.boundingBox, touchLocation)) { 
        [self ChangeToBtn_start2];
        [[SimpleAudioEngine sharedEngine] playEffect:@"ButtonSound.mp3"];
    }
    if (CGRectContainsPoint(buttonOptions.boundingBox, touchLocation)) { 
        [self ChangeToBtn_options2];
    }
    if (CGRectContainsPoint(buttonCredits.boundingBox, touchLocation)) { 
         [self ChangeToBtn_credits2];
        [[SimpleAudioEngine sharedEngine] playEffect:@"ButtonSound.mp3"];
    }
    if (CGRectContainsPoint(buttonBackCredit.boundingBox, touchLocation)) { 
        [self ChangeToBtn_backCredit2];
        [[SimpleAudioEngine sharedEngine] playEffect:@"ButtonSound.mp3"];
    }
    if (CGRectContainsPoint(buttonBackfromCreate.boundingBox, touchLocation)) { 
        [self ChangeToBtn_backfromCreate2];
        [[SimpleAudioEngine sharedEngine] playEffect:@"ButtonSound.mp3"];
    }
    
    if (CGRectContainsPoint(buttonBack.boundingBox, touchLocation)) { 
        [self ChangeToBtn_back2];
        [[SimpleAudioEngine sharedEngine] playEffect:@"ButtonSound.mp3"];
    }
    if (CGRectContainsPoint(buttonQuit.boundingBox, touchLocation)) { 
        [self ChangeToBtn_quit2];
        [[SimpleAudioEngine sharedEngine] playEffect:@"ButtonSound.mp3"];
    }
    if (CGRectContainsPoint(buttonQuitH.boundingBox, touchLocation)) { 
        [self ChangeToBtn_quitH2];
        [[SimpleAudioEngine sharedEngine] playEffect:@"ButtonSound.mp3"];
    }
    if (CGRectContainsPoint( buttonGoToMap.boundingBox, touchLocation)) { 
        [self ChangeToBtn_search2];
        [[SimpleAudioEngine sharedEngine] playEffect:@"ButtonSound.mp3"];
    }
    
    if (CGRectContainsPoint( buttonSearch.boundingBox, touchLocation)) { 
        [self AddressSearch2];
        [[SimpleAudioEngine sharedEngine] playEffect:@"ButtonSound.mp3"];
        
        confirmButton = [CCSprite spriteWithFile:@"btn_choose_area.png"];
        confirmButton.scale=.2;
        confirmButton.position = ccp(150, 50);//450
        [self addChild:confirmButton z:0];
        
    }    
    if (CGRectContainsPoint(buttonBackfromJoin.boundingBox, touchLocation)) { 
        [self ChangeToBtn_backfromJoin2];
        [[SimpleAudioEngine sharedEngine] playEffect:@"ButtonSound.mp3"];
    }
    
//    if (CGRectContainsPoint(zoomIn.boundingBox, touchLocation)) { 
//        [m._MapDirectionsViewController zoomIn];
//        [self disableZoomBtn];
//        // [self disableZoomOutBtn];
//        
//    }
//    
//    if (CGRectContainsPoint(zoomOut.boundingBox, touchLocation)) { 
//        [m._MapDirectionsViewController zoomOut];
//        [self disableZoomBtn];
//       // [self disableZoomOutBtn];
//    }
    
    if (CGRectContainsPoint(confirmButton.boundingBox, touchLocation)) { 
              NSLog(@"Confirm btn was pressed");
        [[SimpleAudioEngine sharedEngine] playEffect:@"ButtonSound.mp3"];
        [m._MapDirectionsViewController choosingArea];
    }
    
    if (CGRectContainsPoint(EndTurnButton.boundingBox, touchLocation)) { 
         [self add_removeEndTurnButton];
        [[SimpleAudioEngine sharedEngine] playEffect:@"ButtonSound.mp3"];
        [m._MapDirectionsViewController endTurn];
    }
    
    if (CGRectContainsPoint(confirmBaseButton.boundingBox, touchLocation)) { 
        [m._MapDirectionsViewController confirmBase];
        // NSLog(@"ConfirmBase btn was pressed");
         
        [[SimpleAudioEngine sharedEngine] playEffect:@"ButtonSound.mp3"];
    }
    
    if (CGRectContainsPoint(refreshButton.boundingBox, touchLocation)) { 
        [m._MapDirectionsViewController refresh];
    }
    if (CGRectContainsPoint(sendWaveButton.boundingBox, touchLocation)) {
        [[SimpleAudioEngine sharedEngine] playEffect:@"ButtonSound.mp3"];
        [m._MainMenuCocosLayer add_removesendWaveButton];

        if(!m._WaveCreationUIlayer){
            WaveCreationLayer * myWaveCreationLayer = [WaveCreationLayer sharedWaveCreationLayer];
            [m._cocosScene addChild:myWaveCreationLayer z:3];
            m._WaveCreationUIlayer = myWaveCreationLayer;
            m.VIP=1;
            [m._WaveCreationUIlayer init];
        }
        else{
            m._WaveCreationUIlayer.visible=true;            
        }
        
    }
    
//    if (CGRectContainsPoint(search.boundingBox, touchLocation)) { 
//        [m._MapDirectionsViewController enableInputText];
//        [self NewGameFunc];
//    }
    
}


- (void)t_Moved:(UITouch *)touch withEvent:(UIEvent *)event;
{
    //DataModel *m = [DataModel getModel];
    CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
    
    CGPoint oldTouchLocation = [touch previousLocationInView:touch.view];
    oldTouchLocation = [[CCDirector sharedDirector] convertToGL:oldTouchLocation];
    oldTouchLocation = [self convertToNodeSpace:oldTouchLocation];
    CGPoint translation = ccpSub(touchLocation, oldTouchLocation);    
	
    
}


- (void)t_Ended:(UITouch *)touch withEvent:(UIEvent *)event;
{
    DataModel *m = [DataModel getModel];
    CGPoint temp_touchLocation = [touch  locationInView:m.cocos_view];
    CGPoint touchLocation = [[CCDirector sharedDirector] convertToGL:temp_touchLocation];
    m.routeMapView.scrollEnabled=YES;
}

- (void)t_Cancelled:(NSSet *)touches withEvent:(UIEvent *)event;
{
    
}
//-------------------------END--Touches-------------------------------------------------
- (void) createGame{
    
    DataModel *m = [DataModel getModel];
    [m._MapDirectionsViewController enableInputText];
    
    [self CleanMainMenu];
    
    buttonGoToMap = [CCSprite spriteWithFile:@"btn_gotoMap1.png"];
    buttonGoToMap.scale=.3;
    buttonGoToMap.position = ccp(150, 100);
    [self addChild:buttonGoToMap z:0];
  
    BGnewGameLabel = [CCSprite spriteWithFile:@"BGnewGameLabel.png"];
    BGnewGameLabel.scale=1;
    BGnewGameLabel.position = ccp(150,310);
    [self addChild:BGnewGameLabel z:0];
    
    // Create a label for display purposes
    _labelGameName = [[CCLabelTTF labelWithString:@"Enter Game Name" 
                               dimensions:CGSizeMake(320, 550) alignment:UITextAlignmentCenter 
                                 fontName:@"Arial" fontSize:20.0] retain];
    _labelGameName.position = ccp(150,50);
    _labelGameName.color = ccc3(255,255,255);
    [self addChild:_labelGameName]; 
    
//    _labelAddress = [[CCLabelTTF labelWithString:@"Enter address" 
//                               dimensions:CGSizeMake(320, 550) alignment:UITextAlignmentCenter 
//                                 fontName:@"Arial" fontSize:16.0] retain];
//    _labelAddress.position = ccp(150,-20);
//    [self addChild:_labelAddress]; 
    
    buttonBackfromCreate = [CCSprite spriteWithFile:@"btn_back1.png"];
    buttonBackfromCreate.scale = .4;
    buttonBackfromCreate.position = ccp(50, 30);
    [self addChild:buttonBackfromCreate z:0];  
    
}


- (void) NewGameFunc{    
    DataModel *m = [DataModel getModel];
//    [m._MapDirectionsViewController enableInputText ];
    
    //TODO
    //create game sends the game name to the server
   
    
    
    [m._MapDirectionsViewController startDelegate];
    NSString *gameName = m._MapDirectionsViewController.inputF.text; //gameName read in from text field
    
    NSArray *msg = [gameName componentsSeparatedByString:@">"];
    NSArray *msg2 = [gameName componentsSeparatedByString:@","];
    
    if(msg.count > 1 || msg2.count>1){
        //tell player it is not a legit game name
        NSLog(@"not a legit game name");
        m._MapDirectionsViewController.inputF.text = @"";
        //[self NewGameFunc];
        [self performSelector:@selector(ChangeBackToNormalBtn_search1) withObject:nil afterDelay:(1.3)];
    }else{
        
        NSLog(@"game name is %@",gameName);
        NSString *create = [NSString stringWithFormat:@"createGame>%@", gameName];
        [m._server sendData:create];
    }
    
  //  DataModel *m = [DataModel getModel];
    
}

-(void) actualNewGameFunc{
    
    DataModel *m = [DataModel getModel];
    background.visible=false;
    [m._MapDirectionsViewController enableInputText ];
    [self CleanUpLayer];
    [m._MapDirectionsViewController runSearchAddress];
   
    [self removeChild:buttonBackfromCreate cleanup:YES];
    buttonBackfromCreate = nil;
    
    upBG = [CCSprite spriteWithFile:@"hud2.png"];
    upBG.scale=1;
    upBG.position = ccp(120,460);
    [self addChild:upBG z:-3];
    
    buttonSearch = [CCSprite spriteWithFile:@"btn_search1.png"];
    buttonSearch.scale = .2;
    buttonSearch.position = ccp(255, 455);//260
    [self addChild:buttonSearch z:0];
    
    //talgat
//    zoomIn = [CCSprite spriteWithFile:@"add.png"];
//    zoomIn.position = ccp(300, 465);
//    [self addChild:zoomIn z:0];
//    
//    zoomOut = [CCSprite spriteWithFile:@"remove.png"];
//    zoomOut.position = ccp(300, 435);
//    [self addChild:zoomOut z:0];
    
    //quit hud
    buttonQuitH= [CCSprite spriteWithFile:@"btn_quit.png"];
    buttonQuitH.scale = .1;
    buttonQuitH.position = ccp(20, 455);
    [self addChild:buttonQuitH z:0]; 
}

-(void) clearGameisOver
{    [self removeChild:zoomOut cleanup:YES];
    zoomOut = nil;  
    [self removeChild:zoomIn cleanup:YES];
    zoomIn = nil; 
    [self removeChild:buttonQuitH cleanup:YES];
    buttonQuitH = nil; 
}

//- (void)  enableZoomInBtn{
//    zoomIn = [CCSprite spriteWithFile:@"add.png"];
//    zoomIn.position = ccp(300, 400);
//    [self addChild:zoomIn z:0];
//}
//- (void)  disableZoomInBtn{
//    [self removeChild:zoomIn cleanup:YES];
//    zoomIn = nil;   
//     [self performSelector:@selector(enableZoomInBtn) withObject:nil afterDelay:(0.7)];
//    [self performSelector:@selector(enableZoomOutBtn) withObject:nil afterDelay:(0.7)];
//}

- (void)  enableZoomBtn{
    zoomOut = [CCSprite spriteWithFile:@"remove.png"];
    zoomOut.position = ccp(300, 435);
    [self addChild:zoomOut z:0];
    zoomIn = [CCSprite spriteWithFile:@"add.png"];
    zoomIn.position = ccp(300, 465);
    [self addChild:zoomIn z:0];

}
- (void)  disableZoomBtn{
    [self removeChild:zoomOut cleanup:YES];
    zoomOut = nil;   
    [self removeChild:zoomIn cleanup:YES];
    zoomIn = nil;  
    [self performSelector:@selector(enableZoomBtn) withObject:nil afterDelay:(0.9)];
    // [self performSelector:@selector(enableZoomInBtn) withObject:nil afterDelay:(0.7)];
}



- (void) AddressSearch{
    DataModel *m = [DataModel getModel];
    [m._MapDirectionsViewController goToAddress];

}


- (void) JoinGameFunc{
    DataModel *m = [DataModel getModel];
     [m._MapDirectionsViewController startDelegate];
    //TODO
    //join game should lead to a list of games currently on the server that aren't full
    NSString *gameList = @"gameList>";
    [m._server sendData:gameList];
    
    
//    [m._MapDirectionsViewController callJoinViewController];
    [self CleanUpLayer];
    background.visible=false;
    
    backgroundJoin=[CCSprite spriteWithFile:@"bgJoin.png"];
    backgroundJoin.anchorPoint = ccp(0,0);
    [self addChild:backgroundJoin z:-1]; 
    
    buttonBackfromJoin = [CCSprite spriteWithFile:@"btn_back1.png"];
    buttonBackfromJoin.scale = .4;
    buttonBackfromJoin.position = ccp(50, 30);
    [self addChild:buttonBackfromJoin z:0];  
    
    buttonQuit= [CCSprite spriteWithFile:@"btn_quit.png"];
    buttonQuit.scale = .2;
    buttonQuit.position = ccp(285, 35);
    [self addChild:buttonQuit z:0]; 
    
//    DataModel *m = [DataModel getModel];
//    m._MapDirectionsViewController.startPoint = nil;
//    m._MapDirectionsViewController.endPoint = nil;
//    m._MapDirectionsViewController.wayPoints = nil;
//    m._MapDirectionsViewController.travelMode = UICGTravelModeDriving;
  

    
    //----Rau
    //set array of names
//    NSArray *names=[NSArray arrayWithObjects:
//                    @"Choose 0", @"Choose 1", @"Choose 2",
//                    @"Choose 3", @"Choose 4", @"Choose 5",
//                    @"Choose 6", @"Choose 7", @"Choose 8",
//                    @"Choose 9", @"Choose 10", @"Choose 11", nil];
//    
//    // create the menu
//    [CCMenuItemFont setFontSize:23];
//    NSMutableArray *items = [[NSMutableArray alloc] init];
//    for (int i=0; i<12; i++) {
//        NSString *name=[names objectAtIndex:i];
//      item=[CCMenuItemFont itemFromString:name];
//                                                    
//        item.anchorPoint=ccp(0,0.5);
//        item.tag=i;
//        [items addObject:item];
//    }
//    
//    menu=[CCMenu menuWithItems:[items objectAtIndex:0],
//                  [items objectAtIndex:1], [items objectAtIndex:2],
//                  [items objectAtIndex:3], [items objectAtIndex:4],
//                  [items objectAtIndex:5], [items objectAtIndex:6],
//                  [items objectAtIndex:7], [items objectAtIndex:8],
//                  [items objectAtIndex:9], [items objectAtIndex:10],
//                  [items objectAtIndex:11],nil];
//   [items release];
//    
//    [menu alignItemsVerticallyWithPadding:6];
//    menu.position=ccp(120,256);
//    [self addChild:menu];
    
    //----
    
//    [m._MapDirectionsViewController GettingStarted];
//    
//    
//    
//    
//    [self removeChild:buttonNewGame cleanup:YES];
//    buttonNewGame = nil;        
//    [self removeChild:buttonJoinGame cleanup:YES];
//    buttonJoinGame = nil;  
//    [self removeChild:buttonContinueGame cleanup:YES];
//    buttonContinueGame = nil;  
}

- (void) ActualJoinGameFunc{
    DataModel *m = [DataModel getModel];
    [m._MapDirectionsViewController deactivateMapView];
    [m._MapDirectionsViewController startDelegate];
    [m._MainMenuCocosLayer addHomeBaseUI];

    [self removeChild:buttonBackfromJoin cleanup:YES];
    buttonBackfromJoin = nil;
    [self removeChild:backgroundJoin cleanup:YES];
    backgroundJoin = nil;
    [self removeChild:buttonQuit cleanup:YES];
    buttonQuit = nil;
    
//    zoomIn = [CCSprite spriteWithFile:@"add.png"];
//    zoomIn.position = ccp(300, 465);
//    [self addChild:zoomIn z:0];
//
//    zoomOut = [CCSprite spriteWithFile:@"remove.png"];
//    zoomOut.position = ccp(300, 435);
//    [self addChild:zoomOut z:0];
    
    //quit hud
    buttonQuitH= [CCSprite spriteWithFile:@"btn_quit.png"];
    buttonQuitH.scale = .1;
    buttonQuitH.position = ccp(20, 455);
    [self addChild:buttonQuitH z:0]; 

}

- (void) ContinueGameFunc{
    DataModel *m = [DataModel getModel];
    NSString *contList = @"continueList>";
//    [m._server sendData:setSetup];
}
- (void)CleanUpLayer{
    
    [self removeChild:BGnewGameLabel cleanup:YES];
    BGnewGameLabel = nil; 
    [self removeChild:buttonGoToMap cleanup:YES];
    buttonGoToMap = nil; 
    [self removeChild:buttonGoToMap2 cleanup:YES];
    buttonGoToMap2 = nil; 
    [self removeChild:_labelGameName cleanup:YES];
    _labelGameName = nil; 
    [self removeChild:titleGlobalTD cleanup:YES];
    titleGlobalTD = nil;  
    [self removeChild:buttonNewGame cleanup:YES];
    buttonNewGame = nil;        
    [self removeChild:buttonJoinGame cleanup:YES];
    buttonJoinGame = nil;  
    [self removeChild:buttonNewGame2 cleanup:YES];
    buttonNewGame2 = nil;        
    [self removeChild:buttonJoinGame2 cleanup:YES];
    buttonJoinGame2 = nil; 
    [self removeChild:buttonContinueGame cleanup:YES];
    buttonContinueGame = nil;  
    [self removeChild:buttonQuit cleanup:YES];
    buttonQuit = nil;  
}
- (void) BuildStartMenu{
    [self removeChild:titleGlobalTD cleanup:YES];
    titleGlobalTD = nil; 
    [self removeChild:buttonQuit cleanup:YES];
    buttonQuit = nil;  
    titleGlobalTD = [CCSprite spriteWithFile:@"Title.png"];
    titleGlobalTD.scale = .15;
    titleGlobalTD.position = ccp(150, 400);
    [self addChild:titleGlobalTD z:0];
    
    buttonStart = [CCSprite spriteWithFile:@"btn_start1.png"];
    buttonStart.scale = .3;
    buttonStart.position = ccp(150, 300);
    [self addChild:buttonStart z:0];
    
//    buttonOptions = [CCSprite spriteWithFile:@"btn_options1.png"];
//    buttonOptions.scale = .3;
//    buttonOptions.position = ccp(150, 200);
//    [self addChild:buttonOptions z:0];
    
    buttonCredits = [CCSprite spriteWithFile:@"btn_credits1.png"];
    buttonCredits.scale = .3;
    buttonCredits.position = ccp(150, 200);
    [self addChild:buttonCredits z:0];  
    
 
    buttonQuit= [CCSprite spriteWithFile:@"btn_quit.png"];
    buttonQuit.scale = .2;
    buttonQuit.position = ccp(285, 35);
    [self addChild:buttonQuit z:0]; 

    
}
- (void)CleanStartMenu{
     [self removeChild:buttonStart2 cleanup:YES];
    buttonStart2 = nil;        
    [self removeChild:buttonOptions cleanup:YES];
    buttonOptions = nil;  
    [self removeChild:buttonCredits2 cleanup:YES];
    buttonCredits2 = nil; 
    [self removeChild:buttonCredits cleanup:YES];
    buttonCredits = nil;  
    [self removeChild:buttonStart cleanup:YES];
    buttonStart = nil;  
    
   
}

- (void) StartFunc{
   [self CleanStartMenu];
   [self BuildMainMenu];
}

- (void) BuildMainMenu{
    if (background.visible==false){
        background.visible=true;
    }
    
    [self removeChild:titleGlobalTD cleanup:YES];
    titleGlobalTD = nil; 
    [self removeChild:buttonQuit cleanup:YES];
    buttonQuit = nil;  
    
    titleGlobalTD = [CCSprite spriteWithFile:@"Title.png"];
    titleGlobalTD.scale = .15;
    titleGlobalTD.position = ccp(150, 400);
    [self addChild:titleGlobalTD z:0];
    
    buttonQuit= [CCSprite spriteWithFile:@"btn_quit.png"];
    buttonQuit.scale = .2;
    buttonQuit.position = ccp(285, 35);
    [self addChild:buttonQuit z:0]; 
    
    buttonNewGame = [CCSprite spriteWithFile:@"btn_create_game1.png"];
    buttonNewGame.scale = .3;
    buttonNewGame.position = ccp(150, 300);
    [self addChild:buttonNewGame z:0];
    
    buttonJoinGame = [CCSprite spriteWithFile:@"btn_join_game1.png"];
    buttonJoinGame.scale = .3;
    buttonJoinGame.position = ccp(150, 200);
    [self addChild:buttonJoinGame z:0];
    
//    buttonContinueGame = [CCSprite spriteWithFile:@"btn_continue.png"];
//    buttonContinueGame.scale = .3;
//    buttonContinueGame.position = ccp(150, 100);
//    [self addChild:buttonContinueGame z:0];
//    
    buttonBack = [CCSprite spriteWithFile:@"btn_back1.png"];
    buttonBack.scale = .4;
    buttonBack.position = ccp(50, 30);
    [self addChild:buttonBack z:0];  
}
- (void) CleanMainMenu{
    [self removeChild:buttonBack cleanup:YES];
    buttonBack = nil;
    [self removeChild:buttonNewGame cleanup:YES];
    buttonNewGame = nil;        
    [self removeChild:buttonJoinGame cleanup:YES];
    buttonJoinGame = nil;  
   // [self removeChild:buttonContinueGame cleanup:YES];
   // buttonContinueGame = nil;  
    [self removeChild:buttonBack2 cleanup:YES];
    buttonBack2 = nil;
    [self removeChild:buttonNewGame2 cleanup:YES];
    buttonNewGame2 = nil;        
    [self removeChild:buttonJoinGame2 cleanup:YES];
    buttonJoinGame2 = nil;  
   // [self removeChild:buttonContinueGame cleanup:YES];
   // buttonContinueGame = nil;  
    
}
- (void) OptionsFunc{
      NSLog(@"options");
}
- (void) CreditsFunc{
    [self CleanStartMenu];
    [self BuildCreditsMenu];
}
- (void) BuildCreditsMenu{
    backgroundCredit = [CCSprite spriteWithFile:@"towerDescBG.png"];
    backgroundCredit.scale=0.5;
    backgroundCredit.position = ccp(150, 200);
    [self addChild:backgroundCredit z:0];

    // Create a label for display purposes
    _label = [[CCLabelTTF labelWithString:@"Engineers: \n Sam Danesis \n Talgat Duisenov \n Matthew Ein \n Raushan Karayeva \n Amol Khedkar \n Jide Wen" 
                               dimensions:CGSizeMake(320, 550) alignment:UITextAlignmentCenter 
                                 fontName:@"Arial" fontSize:16.0] retain];
    _label.position = ccp(150,20);
    [self addChild:_label]; 
    
    
    buttonBackCredit = [CCSprite spriteWithFile:@"btn_back1.png"];
    buttonBackCredit.scale = .4;
    buttonBackCredit.position = ccp(50, 30);
    [self addChild:buttonBackCredit z:0];  
    
}
- (void) CleanCreditsMenu{
    [self removeChild:backgroundCredit cleanup:YES];
    backgroundCredit = nil;
    [self removeChild:buttonBackCredit cleanup:YES];
    buttonBackCredit = nil;
    [self removeChild:buttonBackCredit2 cleanup:YES];
    buttonBackCredit2 = nil;
    [self removeChild:_label cleanup:YES];
    _label = nil;
    [_label release];
    _label = nil;
}
- (void) CleanCreateMenu{
    DataModel *m = [DataModel getModel];
    [self removeChild:buttonGoToMap cleanup:YES];
    buttonGoToMap = nil;
    [self removeChild:buttonGoToMap2 cleanup:YES];
    buttonGoToMap2 = nil;
    [self removeChild:buttonBackfromCreate cleanup:YES];
    buttonBackfromCreate = nil;
    [self removeChild:_labelGameName cleanup:YES];
    _labelGameName = nil;
    [_labelGameName release];
    _labelGameName = nil;
    [m._MapDirectionsViewController removeInputText];
    [self removeChild:BGnewGameLabel cleanup:YES];
    BGnewGameLabel = nil; 
      
}
- (void) CleanJoinMenu{
    DataModel *m = [DataModel getModel];

    [self removeChild:buttonBackfromJoin cleanup:YES];
    buttonBackfromJoin = nil;
    [m._joinViewController removeJoin];
    [m._MapDirectionsViewController removeJoinViewController];
    [m._MapDirectionsAppDelegate cleanView];
    
    [self removeChild:backgroundJoin cleanup:YES];
    backgroundJoin = nil;
  
    
}


//--------------Animate Buttons----------------------------------------------



- (void) ChangeToBtn_start2{
    [self removeChild:buttonStart cleanup:YES];
    buttonStart = nil; 
    
    buttonStart2 = [CCSprite spriteWithFile:@"btn_start2.png"];
    buttonStart2.scale = .3;
    buttonStart2.position = ccp(150, 300);
    [self addChild:buttonStart2 z:0];
    [self performSelector:@selector(StartFunc) withObject:nil afterDelay:(0.3)];
    //[self CleanStartMenu];
}
- (void) ChangeToBtn_options2{
    [self removeChild:buttonOptions cleanup:YES];
    buttonOptions = nil; 
    
    buttonOptions = [CCSprite spriteWithFile:@"btn_options2.png"];
    buttonOptions.scale = .3;
    buttonOptions.position = ccp(150, 200);
    [self addChild:buttonOptions z:0];
    [self performSelector:@selector(OptionsFunc) withObject:nil afterDelay:(0.3)];
}
- (void) ChangeToBtn_credits2{
    [self removeChild:buttonCredits cleanup:YES];
    buttonCredits = nil; 
    
    buttonCredits2 = [CCSprite spriteWithFile:@"btn_credits2.png"];
    buttonCredits2.scale = .3;
    buttonCredits2.position = ccp(150, 200);
    [self addChild:buttonCredits2 z:0];
    [self performSelector:@selector(CreditsFunc) withObject:nil afterDelay:(0.3)];
   // [self removeChild:buttonCredits2 cleanup:YES];
   // buttonCredits2 = nil; 
}
- (void) ChangeToBtn_backCredit2{
    [self removeChild:buttonBackCredit cleanup:YES];
    buttonBackCredit = nil;
    buttonBackCredit2 = [CCSprite spriteWithFile:@"btn_back2.png"];
    buttonBackCredit2.scale = .4;
    buttonBackCredit2.position = ccp(50, 30);
    [self addChild:buttonBackCredit2 z:0]; 
    [self performSelector:@selector(CleanCreditsMenu) withObject:nil afterDelay:(0.2)]; 
    [self performSelector:@selector(BuildStartMenu) withObject:nil afterDelay:(0.3)];
   // [self removeChild:buttonBackCredit2 cleanup:YES];
   // buttonBackCredit2 = nil; 
}
- (void) ChangeToBtn_backfromCreate2{
    [self removeChild:buttonBackfromCreate cleanup:YES];
    buttonBackfromCreate = nil;
    buttonBackfromCreate = [CCSprite spriteWithFile:@"btn_back2.png"];
    buttonBackfromCreate.scale = .4;
    buttonBackfromCreate.position = ccp(50, 30);
    [self addChild:buttonBackfromCreate z:0]; 
    [self performSelector:@selector(CleanCreateMenu) withObject:nil afterDelay:(0.2)]; 
    [self performSelector:@selector(BuildMainMenu) withObject:nil afterDelay:(0.3)];
}
- (void) ChangeToBtn_backfromJoin2{
    [self removeChild:buttonBackfromJoin cleanup:YES];
    buttonBackfromJoin = nil;
    buttonBackfromJoin = [CCSprite spriteWithFile:@"btn_back2.png"];
    buttonBackfromJoin.scale = .4;
    buttonBackfromJoin.position = ccp(50, 30);
    [self addChild:buttonBackfromJoin z:0]; 
    [self performSelector:@selector(CleanJoinMenu) withObject:nil afterDelay:(0.2)]; 
    [self performSelector:@selector(BuildMainMenu) withObject:nil afterDelay:(0.2)];
}

- (void) ChangeToBtn_back2{
    [self removeChild:buttonBack cleanup:YES];
    buttonBack = nil;
    buttonBack2 = [CCSprite spriteWithFile:@"btn_back2.png"];
    buttonBack2.scale = .4;
    buttonBack2.position = ccp(50, 30);
    [self addChild:buttonBack2 z:0]; 
    [self performSelector:@selector(CleanMainMenu) withObject:nil afterDelay:(0.2)]; 
    [self performSelector:@selector(BuildStartMenu) withObject:nil afterDelay:(0.3)];
  //  [self removeChild:buttonBack2 cleanup:YES];
  //  buttonBack2 = nil; 
}
- (void) ChangeToBtn_quit2{
    [self removeChild:buttonQuit cleanup:YES];
    buttonQuit = nil;
    buttonQuit = [CCSprite spriteWithFile:@"btn_quit2.png"];
    buttonQuit.scale = .2;
    buttonQuit.position = ccp(285, 35);
    [self addChild:buttonQuit z:0]; 
    
  [self performSelector:@selector(exitApp) withObject:nil afterDelay:(0.3)];
}
- (void) ChangeToBtn_quitH2{
    [self removeChild:buttonQuitH cleanup:YES];
    buttonQuitH = nil;
    buttonQuitH = [CCSprite spriteWithFile:@"btn_quit2.png"];
    buttonQuitH.scale = .1;
    buttonQuitH.position = ccp(20, 455);
    [self addChild:buttonQuitH z:0]; 
    
    [self performSelector:@selector(exitApp) withObject:nil afterDelay:(0.3)];
}
- (IBAction)exitApp {
    exit(0);
}

- (void) ChangeToBtn_create_game2{
    [self removeChild:buttonNewGame cleanup:YES];
    buttonNewGame = nil; 
    
    buttonNewGame2 = [CCSprite spriteWithFile:@"btn_create_game2.png"];
    buttonNewGame2.scale = .3;
    buttonNewGame2.position = ccp(150, 295);
    [self addChild:buttonNewGame2 z:0];
    [self performSelector:@selector(createGame) withObject:nil afterDelay:(0.3)];
    //[self removeChild:buttonNewGame2 cleanup:YES];
   // buttonNewGame2 = nil; 
}
- (void) ChangeToBtn_join_game2{
    [self removeChild:buttonJoinGame cleanup:YES];
    buttonJoinGame = nil; 
    
    buttonJoinGame2 = [CCSprite spriteWithFile:@"btn_join_game2.png"];
    buttonJoinGame2.scale = .3;
    buttonJoinGame2.position = ccp(150, 200);
    [self addChild:buttonJoinGame2 z:0];
     [self performSelector:@selector(CleanMainMenu) withObject:nil afterDelay:(0.2)];
    [self performSelector:@selector(JoinGameFunc) withObject:nil afterDelay:(0.3)];
 //   [self removeChild:buttonJoinGame2 cleanup:YES];
   // buttonJoinGame2 = nil; 
}
- (void) ChangeToBtn_continue2 {
    [self removeChild:buttonContinueGame cleanup:YES];
    buttonContinueGame = nil; 
    
    buttonContinueGame = [CCSprite spriteWithFile:@"btn_continue2.png"];
    buttonContinueGame.scale = .3;
    buttonContinueGame.position = ccp(150, 100);
    [self addChild:buttonContinueGame z:0];
    [self performSelector:@selector(ContinueGameFunc) withObject:nil afterDelay:(0.3)];
}
- (void) ChangeToBtn_search2{
[self removeChild:buttonGoToMap cleanup:YES];
buttonGoToMap = nil; 

buttonGoToMap2 = [CCSprite spriteWithFile:@"btn_gotoMap2.png"];
buttonGoToMap2.scale = .3;
buttonGoToMap2.position = ccp(150, 100);
[self addChild:buttonGoToMap2 z:0];
[self performSelector:@selector(NewGameFunc) withObject:nil afterDelay:(0.3)];
    
//
    
   // [self removeChild:buttonGoToMap2 cleanup:YES];
   // buttonGoToMap2 = nil; 
    
    
}
- (void) ChangeBackToNormalBtn_search1{
    [self removeChild:buttonGoToMap2 cleanup:YES];
    buttonGoToMap2 = nil; 
    
    buttonGoToMap = [CCSprite spriteWithFile:@"btn_gotoMap1.png"];
    buttonGoToMap.scale = .3;
    buttonGoToMap.position = ccp(150, 100);
    [self addChild:buttonGoToMap z:0];
 
    
    
}

- (void) AddressSearch2{
    [self removeChild:buttonSearch cleanup:YES];
    buttonSearch = nil; 
    
    buttonSearch = [CCSprite spriteWithFile:@"btn_search2.png"];
    buttonSearch.scale = .2;
    buttonSearch.position = ccp(255, 455);
    [self addChild:buttonSearch z:0];
    [self performSelector:@selector(AddressSearch) withObject:nil afterDelay:(0.3)];
}
//-------------------------------------------------------

@end
