//
//  MapViewController.m
//  iOS-Task-ObjC
//
//  Created by Nitesh I on 12/12/16.
//  Copyright © 2016 n1tesh. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    _mapView.delegate = self;
    _mapView.showsUserLocation = YES;
    
    self.locationManager = [[CLLocationManager alloc]init];
    
    self.locationManager = [[CLLocationManager alloc] init];
    
    [[self locationManager] setDelegate:self];
    
    // we have to setup the location manager with permission in later iOS versions
    if ([[self locationManager] respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [[self locationManager] requestWhenInUseAuthorization];
    }
    
    [[self locationManager] setDesiredAccuracy:kCLLocationAccuracyBest];
    [[self locationManager] startUpdatingLocation];

    
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    span.latitudeDelta = 0.005;
    span.longitudeDelta = 0.005;
    CLLocationCoordinate2D location;
    
    location.latitude = userLocation.coordinate.latitude;
    location.longitude = userLocation.coordinate.longitude;
    
    region.center = location;
    
    [mapView setRegion:region animated:YES];
    
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    [self.locationManager stopUpdatingLocation];
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init] ;
    [geocoder reverseGeocodeLocation:self->_locationManager.location
                   completionHandler:^(NSArray *placemarks, NSError *error) {
                       NSLog(@"reverseGeocodeLocation:completionHandler: Completion Handler called!");
                       
                       if (error){
                           NSLog(@"Geocode failed with error: %@", error);
                           return;
                           
                       }
                       
                       
                       CLPlacemark *placemark = [placemarks objectAtIndex:0];
                       
//                       NSLog(@"placemark.ISOcountryCode %@",placemark.ISOcountryCode);
//                       NSLog(@"placemark.country %@",placemark.country);
//                       NSLog(@"placemark.locality %@",placemark.locality );
//                       NSLog(@"placemark.postalCode %@",placemark.postalCode);
//                       NSLog(@"placemark.administrativeArea %@",placemark.administrativeArea);
//                       NSLog(@"placemark.locality %@",placemark.locality);
                       NSLog(@"placemark.subLocality %@",placemark.subLocality);
                       //NSLog(@"placemark.subThoroughfare %@",placemark.subThoroughfare);

                       userCity = [[NSString alloc] initWithString:placemark.subLocality];

                   }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)sendMailButton:(UIButton *)sender {
    NSLog(@"USer city is........ %@",userCity);
    
    NSString *emailTitle = @"Inscripts Task";
    NSString *messageBody = [NSString stringWithFormat:@"Candidate Name : Nitesh Isave \n I have completed my task and my location is %@ .",userCity];
    NSString *messageSubject = @"Inscripts Task";
    NSArray *toRecipents = [NSArray arrayWithObject:@"xxxx@inscripts.in"];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setTitle:emailTitle];
    [mc setSubject:messageSubject];
    [mc setMessageBody:messageBody isHTML:NO];
    [mc setToRecipients:toRecipents];
    
    
    [self presentViewController:mc animated:YES completion:NULL];
}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    
    switch (result) {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
        case MFMailComposeResultSent:
            NSLog(@"Mail send");
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
        default:
            break;
    }
    [self dismissViewControllerAnimated:YES completion:NULL];
}


@end
