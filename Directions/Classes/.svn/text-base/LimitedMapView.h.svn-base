//
//  LimitedMapView.h
//  MapDirections
//
//  Created by Lion User on 16/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface LimitedMapView : MKMapView <UIScrollViewDelegate>{
    
    
}
- (void)scrollViewDidZoom:(UIScrollView *)scrollView;

@property (nonatomic,assign) CLLocationCoordinate2D topLeft;
@property (nonatomic,assign) CLLocationCoordinate2D botRight;
//@property (nonatomic,assign) MKCoordinateRegion boundRegion;

-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView;

@end
