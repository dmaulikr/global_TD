//
//  HelloWorldLayer.m
//  MobMenu
//
//  Created by Matthew Ein on 2/21/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//


// Import the interfaces
#import "WaveCreationLayer.h"
#import "GameHUD.h"
#import "VariableStore.h"
#import <MapKit/MapKit.h>
#import "MKMapView_ZoomLevel.h"
#import "UICRouteOverlayMapView.h"
#import "HelloWorldScene.h"
#import "SimpleAudioEngine.h"
int mobWidth = 40;
int mobHeight = 30;
int maxMobCount = 100;
int maxMobsPerRow = 10;
int mobsInRow = 0;
int rows = 0;
int numMobs = 0;
int myMoney;
int busCost =30;
int doctorCost = 10;
int grandmaCost = 5;
int busNum = 0;
int docNum = 0;
int grandmaNum = 0;
int rowEnd =320;
int incomeBus=10;
int incomeDoc=4;
int incomeGrandma=1;
//int TotalIncome=10;
CCLabelTTF *scoreLabel;
// HelloWorldLayer implementation
@implementation WaveCreationLayer


static WaveCreationLayer *_sharedWaveCreationLayer = nil;

+ (WaveCreationLayer *)sharedWaveCreationLayer
{
	@synchronized([WaveCreationLayer class])
	{
		if (!_sharedWaveCreationLayer)
			[[self alloc] init];
		return _sharedWaveCreationLayer;
	}
	// to avoid compiler warning
	return nil;
}

+(id)alloc
{
	@synchronized([WaveCreationLayer class])
	{
		NSAssert(_sharedWaveCreationLayer== nil, @"Attempted to allocate a second instance of a singleton.");
		_sharedWaveCreationLayer = [super alloc];
		return _sharedWaveCreationLayer;
	}
	// to avoid compiler warning
	return nil;
}



// on "init" you need to initialize your instance
-(id) init
{ DataModel *m=[DataModel getModel];
    NSLog(@"wavevreationLayer");
    
    //myMoney=m.gold;
 if( (self=[super init]) && m.VIP==1) {
     
		// ask director the the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
        movableSpritesUI = [[NSMutableArray alloc] init];
        
		CCSprite * bg = [CCSprite spriteWithFile:@"BgWaveCreationLayer.png"];
        bg.anchorPoint = ccp(0,0);
       // bg.scale=1;
        [self addChild:bg];

     addBus_text = [CCSprite spriteWithFile:@"btn_addBuses1.png"];
     addBus_text.scale=.45;
     addBus_text.position = ccp(50,305);
     [self addChild:addBus_text];

      addDoctors_text = [CCSprite spriteWithFile:@"btn_addDoctors1.png"];
      addDoctors_text.scale=.45;
      addDoctors_text.position = ccp(50,205);
     [self addChild: addDoctors_text];
    
     addGrandma_text = [CCSprite spriteWithFile:@"btn_addGrandma.png"];
     addGrandma_text.scale=.45;
     addGrandma_text.position = ccp(50,105);
     [self addChild: addGrandma_text];
     
     SendWave_text = [CCSprite spriteWithFile:@"btn_send.png"];
     SendWave_text.scale=.4;
     SendWave_text.position = ccp(250,55);//1250
     [self addChild:SendWave_text];
     
     CCSprite * coinBus_TD = [CCSprite spriteWithFile:@"coinTD.png"];
     coinBus_TD.scale=1;
     coinBus_TD.position = ccp(50,285);
     [self addChild:coinBus_TD z:1];
     
     //Set up and place busCost labels
     CCLabelTTF *busCostl = [CCLabelTTF labelWithString:@"" fontName:@"Marker Felt" fontSize:12];
     busCostl.position =  ccp(50,285);
     busCostl.color = ccc3(0, 0, 0);
     [busCostl setString:[NSString stringWithFormat:@"-%i",busCost]];
     [self addChild:busCostl z:1];
     //Set up and place busCost labels
     CCLabelTTF *busIncomel = [CCLabelTTF labelWithString:@"income" fontName:@"Marker Felt" fontSize:13];
     busIncomel.position =  ccp(50,325);
     busIncomel.color = ccc3(1, 0, 0);
     [busIncomel setString:[NSString stringWithFormat:@"income+%i",incomeBus]];
     [self addChild:busIncomel z:1];
     
     
     CCSprite * coinDoc_TD = [CCSprite spriteWithFile:@"coinTD.png"];
     coinDoc_TD.scale=1;
     coinDoc_TD.position = ccp(50,185);
     [self addChild:coinDoc_TD z:1];
     
     //Set up and place docotrCost labels
     CCLabelTTF *doctorCostl = [CCLabelTTF labelWithString:@"" fontName:@"Marker Felt" fontSize:12];
     doctorCostl.position =  ccp(50,185);
     doctorCostl.color = ccc3(0, 0, 0);
     [doctorCostl setString:[NSString stringWithFormat:@"-%i",doctorCost]];
     [self addChild:doctorCostl z:1];
     //Set up and place busCost labels
     CCLabelTTF *docIncomel = [CCLabelTTF labelWithString:@"income" fontName:@"Marker Felt" fontSize:13];
     docIncomel.position =  ccp(50,225);
     docIncomel.color = ccc3(1, 0, 0);
     [docIncomel setString:[NSString stringWithFormat:@"income+%i",incomeDoc]];
     [self addChild:docIncomel z:1];
     
     
     CCSprite * coinGrandma_TD = [CCSprite spriteWithFile:@"coinTD.png"];
     coinGrandma_TD.scale=1;
     coinGrandma_TD.position = ccp(50,90);
     [self addChild:coinGrandma_TD z:1];
     
     //Set up and place grandmaCost labels
     CCLabelTTF *grandmaCostl = [CCLabelTTF labelWithString:@"" fontName:@"Marker Felt" fontSize:12];
     grandmaCostl.position =  ccp(50,90);
     grandmaCostl.color = ccc3(0, 0, 0);
     [grandmaCostl setString:[NSString stringWithFormat:@"-%i",grandmaCost]];
     [self addChild:grandmaCostl z:1];
     //Set up and place busCost labels
     CCLabelTTF *grandmaIncomel = [CCLabelTTF labelWithString:@"income" fontName:@"Marker Felt" fontSize:13];
     grandmaIncomel.position =  ccp(50,120);
     grandmaIncomel.color = ccc3(0, 0, 0);
     [grandmaIncomel setString:[NSString stringWithFormat:@"income+%i",incomeGrandma]];
     [self addChild:grandmaIncomel z:1];
          
     //Set up and place grandmaCost labels
     TotalIncomel = [CCLabelTTF labelWithString:@"" fontName:@"Marker Felt" fontSize:16];
     TotalIncomel.position =  ccp( size.width /2+100 , size.height - 2*size.height/8);
     TotalIncomel.color = ccc3(0, 0, 0);
     [TotalIncomel setString:[NSString stringWithFormat:@"Income= %i",m.totalIncome]];
     [self addChild:TotalIncomel z:1];
     
     
   CCSprite *waveLabel = [CCSprite spriteWithFile:@"wavecreation_title.png"];
     waveLabel.scale=.5;
     waveLabel.position = ccp(180,415);
     [self addChild:waveLabel];
     
     CCSprite * coin_TD = [CCSprite spriteWithFile:@"coinTD.png"];
     coin_TD.scale=1;
     coin_TD.position = ccp( size.width /2-50 , size.height - 2*size.height/8);
     [self addChild:coin_TD z:1];
     
         scoreLabel = [CCLabelTTF labelWithString:@"0" fontName:@"Copperplate" fontSize:32];
     NSString *str = [NSString stringWithFormat:@"%i", m.gold];//myMoney];
         [scoreLabel setString:str];
         scoreLabel.position =  ccp( size.width /2 , size.height - 2*size.height/8);
         scoreLabel.color = ccc3(1,0,0);
         [self addChild: scoreLabel];
         //[waveLabel setRGB:21,96,221]; how do I set colors?
        
         
         // add the label as a child to this Layer
         [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
     
     myWave=nil;
     
     if (movableSpritesUI == nil)
     {
         SendWave_text.position = ccp(250,55);//1250
     }

     
     }
     return self;
 }


-(void) updateIncomes:(int)amount{
    DataModel *m=[DataModel getModel];
    m.totalIncome += amount;
    [self->TotalIncomel setString:[NSString stringWithFormat: @"Income= %i",m.totalIncome]];
}

- (void) onBus
{[[SimpleAudioEngine sharedEngine] playEffect:@"ButtonSound.mp3"];

  
    
    
    SendWave_text.position = ccp(250,55);
    DataModel *m=[DataModel getModel];

    if(m.gold >= busCost && numMobs < maxMobCount)
    {
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        if (numMobs % maxMobsPerRow == 0) {
            rows += 1;
            mobsInRow = 0;
        }
        int y = 3*winSize.height/4 - rows*mobHeight;
        CCSprite *busSprite = [CCSprite spriteWithFile:@"bus_top.png" 
                                                  rect:CGRectMake(0, 0, 50, 40)];
        
        busSprite.position = ccp(winSize.width - ((mobsInRow+1)*20),y);
        
       // NSLog(@"winSize.width,%f",winSize.width);
      //  busSprite.position = ccp(rowEnd-0.5,y);
        busSprite.scale=0.4;
        busSprite.tag = 5;//0
        [self addChild:busSprite];
        [movableSpritesUI addObject:busSprite];
        mobsInRow += 1;
        numMobs += 1;
        m.gold-= busCost;
        NSString *str = [NSString stringWithFormat:@"%i", m.gold];
        [scoreLabel setString:str];
         [self updateIncomes:+incomeBus];
    }
    //}
}
- (void) onDoctors
{    [[SimpleAudioEngine sharedEngine] playEffect:@"ButtonSound.mp3"];

      
      SendWave_text.position = ccp(250,55);
    DataModel *m=[DataModel getModel];
    NSLog(@"adding doctor");
    if(m.gold >= doctorCost && numMobs < maxMobCount)
    {
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        if (numMobs % maxMobsPerRow == 0) {
            rows += 1;
            mobsInRow = 0;
        }
        int y = 3*winSize.height/4 - rows*mobHeight;
        CCSprite *docSprite = [CCSprite spriteWithFile:@"doctor.png" 
                                          //        rect:CGRectMake(0, 0, mobWidth, mobHeight)];
                                       rect:CGRectMake(0, 0, 40, 40)];
        //docSprite.position = ccp(winSize.width - ((mobsInRow+1)*docSprite.contentSize.width), y);
       docSprite.position = ccp(winSize.width - ((mobsInRow+1)*20), y);
        docSprite.scale=0.5;
        
         NSLog(@"WINSIZE!!=%f",winSize.height);
        
        
        [self addChild:docSprite];
        docSprite.tag = 1;
        [movableSpritesUI addObject:docSprite];
        mobsInRow += 1;
        numMobs += 1;
        m.gold-= doctorCost;
        NSString *str = [NSString stringWithFormat:@"%i", m.gold];
        [scoreLabel setString:str];
        [self updateIncomes:+incomeDoc];
    }
}

- (void) onGrandma
{    [[SimpleAudioEngine sharedEngine] playEffect:@"ButtonSound.mp3"];
    

    
     SendWave_text.position = ccp(250,55);
    DataModel *m=[DataModel getModel];
    NSLog(@"adding grandma");
    if(m.gold >= grandmaCost && numMobs < maxMobCount)
    {
        NSLog(@"enough money");
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        if (numMobs % maxMobsPerRow == 0) {
            rows += 1;
            mobsInRow = 0;
        }
        int y = 3*winSize.height/4 - rows*mobHeight;
        CCSprite *grandmaSprite = [CCSprite spriteWithFile:@"grandma.png" 
                               //        rect:CGRectMake(0, 0, mobWidth, mobHeight)];
                                                  rect:CGRectMake(0, 0, 40, 40)];
        //docSprite.position = ccp(winSize.width - ((mobsInRow+1)*docSprite.contentSize.width), y);
        grandmaSprite.position = ccp(winSize.width - ((mobsInRow+1)*20), y);
        grandmaSprite.scale=0.5;
       // grandmaSprite.opacity=0.2;
        
             
        [self addChild:grandmaSprite];
        grandmaSprite.tag = 2;
        [movableSpritesUI addObject:grandmaSprite];
        mobsInRow += 1;
        numMobs += 1;
        m.gold-= grandmaCost;
        NSString *str = [NSString stringWithFormat:@"%i", m.gold];
        [scoreLabel setString:str];
        [self updateIncomes:+incomeGrandma];
    }
}




- (void)onSend
{ DataModel *m=[DataModel getModel];
   
  myWave = [self waveFormatter]; //This is an array of -1(empty slots), 0s (bus) and 1s (doctors) 2s grandmas. It's the same order as movableSpritesUI.
[[SimpleAudioEngine sharedEngine] playEffect:@"ButtonSound.mp3"];
  //  m._creepsOrder=myWave;
   // m._WaveCreationUIlayer.visible=false;
   // [m._WaveCreationUIlayer removeAllChildrenWithCleanup:YES];
	
     NSLog(@"myWavecount=%d",myWave.count);
    //1$ per creep
    [m._gameHUDLayer updateResources:0];// income per creep
    m.totalIncome=m.totalIncome;
    
    
    //send creeps to the server
    NSString *c_type = nil;
    NSString *c_player = nil;
    NSString *begType;
    NSString *begPlayer;
    bool first = YES;
    NSLog(@"creep count = %d",myWave.count);
    for (int i =0; i < myWave.count; i++) {
        NSString *type = [NSString stringWithFormat:@"%d", [[myWave objectAtIndex:i] intValue] ];
        
        if(first){
            c_type = [NSString stringWithFormat:@"%@", type];
            c_player = [NSString stringWithFormat:@"%@", m.playerID];
            
            first = NO;
        }else{
            c_type = [c_type stringByAppendingFormat:@",%@",type];
            c_player = [c_player stringByAppendingFormat:@",%@", m.playerID];
        }
    }
    
    if(c_type !=nil){
        begType = @"set>c_type:";
        begPlayer = @"c_player:";
        
        c_type = [begType stringByAppendingString:c_type];
        c_player = [begPlayer stringByAppendingString:c_player];
        c_type = [c_type stringByAppendingFormat:@" %@",c_player];
        NSLog(@"c_typePlayer = %@",c_type);
        [m._server sendData:[NSString stringWithFormat:@"%@ gold:%d", c_type, m.gold]];
    }else{
        //player is not sending any creeps
        [m._server sendData:[NSString stringWithFormat:@"set>c_type: c_player: gold:%d", m.gold]];
    }
    
    
    m._WaveCreationUIlayer.visible=false;
    for (CCSprite *removeSprite in movableSpritesUI) {
     [self removeChild:removeSprite cleanup:YES];}
    numMobs=0;
    NSMutableArray *discardedItems = [NSMutableArray array];
    
    for (CCSprite *removeSprite in movableSpritesUI) {
        [discardedItems addObject:removeSprite];
    }
    [movableSpritesUI removeObjectsInArray:discardedItems];
    SendWave_text.position = ccp(250,55);//1250
    
    m.routeMapView.scrollEnabled=NO;
    
 
    
}



- (void)selectSpriteForTouch:(CGPoint)touchLocation {
    CCSprite * newSprite= nil;
    DataModel *m=[DataModel getModel];
    //first remove the touched one
    for (CCSprite *sprite in movableSpritesUI) {
        if (CGRectContainsPoint(sprite.boundingBox, touchLocation)) {            
            newSprite = sprite;
           // NSLog(@"touched a sprite");
           // NSString* myNewString = [NSString stringWithFormat:@"%d", sprite.tag];
          //  NSLog(myNewString);
            if(newSprite.tag == 5)
            {
                //bus case
              //  myMoney+=busCost;
                  m.gold+=busCost;
                  [self updateIncomes:-incomeBus];
            }
            else if (newSprite.tag == 1)
            {
                //doctor case
                //myMoney+=doctorCost;
                m.gold+=doctorCost;
                   [self updateIncomes:-incomeDoc];
            }
            else if (newSprite.tag == 2)
            {
                //doctor case
                //myMoney+=doctorCost;
                m.gold+=grandmaCost;
                   [self updateIncomes:-incomeGrandma];
            }
            
            [self removeChild:newSprite cleanup:YES];
            [movableSpritesUI removeObject:newSprite];
            numMobs -= 1;
            break;
        }
    }
    
    for (CCSprite *removeSprite in movableSpritesUI) {
        [self removeChild:removeSprite cleanup:YES];
        numMobs -=1;
    }
    //reset row vals to redo sprites
    mobsInRow = 0;
    rows = 0;    
    for (CCSprite *addSprite in movableSpritesUI) {
        
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        if (numMobs % maxMobsPerRow == 0) {
            rows += 1;
            mobsInRow = 0;
        }
        int y = 3*480/4 - rows*mobHeight;
        //addSprite.position = ccp(winSize.width - ((mobsInRow+1)*addSprite.contentSize.width), y);
      
       addSprite.position = ccp(320- ((mobsInRow+1)*20), y);
        [self addChild:addSprite];
        mobsInRow += 1;
        numMobs += 1;
    }  
    NSString *str = [NSString stringWithFormat:@"%i", m.gold];//myMoney];
    [scoreLabel setString:str];
    NSLog(@"numMobs=%d",numMobs);
    
    
    
 
    if (numMobs <= 0)
    {
        SendWave_text.position = ccp(250,55);//1250
    }
}


- (NSMutableArray *) waveFormatter
{
	
     myWave = [[NSMutableArray alloc] initWithCapacity:maxMobCount];
  
    for (CCSprite *addSprite in movableSpritesUI)
    {
        NSNumber *num = [[NSNumber alloc] initWithInt:-1];
        if(addSprite.tag == 5)
        { //bus case
            num = [[NSNumber alloc] initWithInt:5];
            busNum++;
        }
        else if (addSprite.tag == 1)
        { //doctor case
            num = [[NSNumber alloc] initWithInt:1];
            docNum++;
        }
        else if (addSprite.tag == 2)
        { //grandma case
            num = [[NSNumber alloc] initWithInt:2];
            grandmaNum++;
        }
        [myWave addObject:num];
        
    }
    return myWave;
}
  
-(void) changetoAddBusesBtn2{
    [self removeChild:addBus_text cleanup:YES];
    addBus_text = nil; 
    addBus_text2 = [CCSprite spriteWithFile:@"btn_addBuses1.png"];
    addBus_text2.scale=.4;
    addBus_text2.position = ccp(50,305);
    [self addChild:addBus_text2];
  
    [self performSelector:@selector(backToNormalBusBtn) withObject:nil afterDelay:(0.2)];
     [self performSelector:@selector(onBus) withObject:nil afterDelay:(0.3)];
}
-(void) changetoAddDoctorsBtn2{
    [self removeChild:addDoctors_text cleanup:YES];
    addDoctors_text = nil; 
    
    addDoctors_text2 = [CCSprite spriteWithFile:@"btn_addDoctors1.png"];
    addDoctors_text2.scale=.4;
    addDoctors_text2.position = ccp(50,205);
    [self addChild: addDoctors_text2];
    [self performSelector:@selector(backToNormalDoctorBtn) withObject:nil afterDelay:(0.2)];
    [self performSelector:@selector(onDoctors) withObject:nil afterDelay:(0.3)];
    
}
-(void) changetoAddGrandmaBtn2{
    NSLog(@"Touched Grandma 2");
    [self removeChild:addGrandma_text cleanup:YES];
    addGrandma_text = nil; 
      //  NSLog(@"Touched Grandma 2.1");
    
    addGrandma_text2 = [CCSprite spriteWithFile:@"btn_addGrandma.png"];
    addGrandma_text2.scale=.4;
    addGrandma_text2.position = ccp(50,105);
    [self addChild: addGrandma_text2];
    [self performSelector:@selector(backToNormalGrandmaBtn) withObject:nil afterDelay:(0.2)];
    [self performSelector:@selector(onGrandma) withObject:nil afterDelay:(0.3)];
    
}



-(void) backToNormalBusBtn {
    [self removeChild:addBus_text2 cleanup:YES];
    addBus_text2 = nil; 
    addBus_text = [CCSprite spriteWithFile:@"btn_addBuses1.png"];
    addBus_text.scale=.45;
    addBus_text.position = ccp(50,305);
    [self addChild:addBus_text];
}
-(void) backToNormalDoctorBtn {
    [self removeChild:addDoctors_text2 cleanup:YES];
    addDoctors_text2 = nil; 
    
    addDoctors_text = [CCSprite spriteWithFile:@"btn_addDoctors1.png"];
    addDoctors_text.scale=.45;
    addDoctors_text.position = ccp(50,205);
    [self addChild: addDoctors_text];
}
-(void) backToNormalGrandmaBtn {
  //  NSLog(@"Touched Grandma 3");
    [self removeChild:addGrandma_text2 cleanup:YES];
    addGrandma_text2 = nil; 
    
    addGrandma_text = [CCSprite spriteWithFile:@"btn_addGrandma.png"];
    addGrandma_text.scale=.45;
    addGrandma_text.position = ccp(50,105);
    [self addChild: addGrandma_text];
}

//-----------------------------------------touches----------------------------------------------
- (void)t_Begin:(UITouch *)touch withEvent:(UIEvent *)event{
    DataModel *m = [DataModel getModel];
    CGPoint temp_touchLocation = [touch  locationInView:m.cocos_view];
    CGPoint touchLocation = [[CCDirector sharedDirector] convertToGL:temp_touchLocation];
   
	
   // CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
    [self selectSpriteForTouch:touchLocation];   
       
    //---add bus
    
    CCSprite * sprite = addBus_text;
    
          if (CGRectContainsPoint(sprite.boundingBox, touchLocation)) 
          {     
              
              [self changetoAddBusesBtn2];
              //[self onBus];
          }
    //---add Doctors
    
    CCSprite * sprite2 = addDoctors_text;
    
    if (CGRectContainsPoint(sprite2.boundingBox, touchLocation)) 
    {               
        [self changetoAddDoctorsBtn2];
        //[self onDoctors];
    }
    
    CCSprite * sprite3 = addGrandma_text;
    
    if (CGRectContainsPoint(sprite3.boundingBox, touchLocation)) 
    {   
        NSLog(@"Touched Grandma...");
        [self changetoAddGrandmaBtn2];
    }
    
    //---send Waves
    
    CCSprite * sprite4 = SendWave_text;
    
    if (CGRectContainsPoint(sprite4.boundingBox, touchLocation)) 
    {               
        [self onSend];
    }
      
}


// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)

    [movableSpritesUI release];
    movableSpritesUI = nil;
	// don't forget to call "super dealloc"
    [myWave release];
    myWave = nil;
	[super dealloc];
}
@end
