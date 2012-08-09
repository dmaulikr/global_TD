//
//  MKMapView_ZoomLevel.h
//  gMap
//
//  Created by Lion User on 03/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface MKMapView (ZoomLevel)

- (void)setCenterCoordinate:(CLLocationCoordinate2D)centerCoordinate
                zoomLevel:(NSUInteger)zoomLevel
                animated:(BOOL)animated;



@end




