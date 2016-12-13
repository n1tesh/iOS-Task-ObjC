//
//  MapViewController.h
//  iOS-Task-ObjC
//
//  Created by Nitesh I on 12/12/16.
//  Copyright © 2016 n1tesh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <MessageUI/MessageUI.h>

NSString *userCity;

@interface MapViewController : UIViewController<MKMapViewDelegate, CLLocationManagerDelegate, MFMailComposeViewControllerDelegate>
- (IBAction)sendMailButton:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) CLLocationManager *locationManager;


@end
