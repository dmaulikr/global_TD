//
//  LimitedMapView.m
//  MapDirections
//
//  Created by Lion User on 16/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LimitedMapView.h"

@implementation LimitedMapView

@synthesize topLeft, botRight;
//@synthesize boundRegion;

- (void)scrollViewDidZoom:(UIScrollView *)scrollView{
    if([super respondsToSelector:@selector(scrollViewDidZoom:)]){
        [super scrollViewDidZoom:scrollView];
    }
//    if([self region].span.latitudeDelta > 0.002401f || [self region].span.longitudeDelta > 0.003433f){
//        CLLocationCoordinate2D center = self.centerCoordinate;
//        MKCoordinateSpan span = MKCoordinateSpanMake(0.002401f, 0.003433f);
//        self.region = MKCoordinateRegionMake(center, span);
//    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if(topLeft.latitude != botRight.latitude && topLeft.longitude != botRight.longitude){
//        if([super respondsToSelector:@selector(scrollViewDidEndDragging:)]){
            [super scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
//        }
        MKCoordinateRegion currentRegion = self.region;
        bool changeRegionLong = YES;
        bool changeRegionLat = YES;
        
        // LONGITUDE    
        if((currentRegion.center.longitude - (currentRegion.span.longitudeDelta/2)) < self.topLeft.longitude) {
            
            currentRegion.center.longitude = (topLeft.longitude + (currentRegion.span.longitudeDelta/2));
            
        } else if((currentRegion.center.longitude + (currentRegion.span.longitudeDelta/2)) > self.botRight.longitude) {
            
            currentRegion.center.longitude = (botRight.longitude - (currentRegion.span.longitudeDelta/2));
            
        } else {
            
            changeRegionLong = NO;
            
        }
        
        // LATITUDE    
        if((currentRegion.center.latitude + (currentRegion.span.latitudeDelta/2)) > self.topLeft.latitude) {
            
            currentRegion.center.latitude = (topLeft.latitude - (currentRegion.span.latitudeDelta/2));
            
        } else if((currentRegion.center.latitude - (currentRegion.span.latitudeDelta/2)) < self.botRight.latitude) {
            
            currentRegion.center.latitude = (botRight.latitude + (currentRegion.span.latitudeDelta/2));
            
        } else {
            
            changeRegionLat = NO;
            
        }
        
        if(changeRegionLong || changeRegionLat){
            [self setRegion:currentRegion animated:YES];
            //NSLog(@"limited map view: scrollviewdid end dragging, region must be changed");
        }
    }
    
}

-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    
    [scrollView setContentOffset:scrollView.contentOffset animated:YES];
//    NSLog(@"Begin decelerating");
    
}


@end
