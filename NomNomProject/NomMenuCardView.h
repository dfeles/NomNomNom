//
//  NomDatabase.h
//  NomNomNom
//
//  Created by Daniel Feles on 15/10/2015.
//  Copyright © 2015 Daniel Feles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <pop/POP.h>
#import "NomNomHelper.h"
#import "NomNom-Swift.h"

@interface NomMenuCardView:UIView{
    UIView *frontView;
    UIView *backView;
    
    BOOL frontViewOpened;
    
    //front view
    UILabel *soup;
    UIImageView *soupIcon;
    UILabel *main;
    UIImageView *mainIcon;
    UILabel *price;
    UILabel *distance;
    UIButton *moreButton;
    
    //back view
    UILabel *hello;
    MapView *mapView;
    
    float moreIconSize;
}

@property CLLocation *currentLocation;

-(void) setCardWithItem :(PFObject*)food;

-(void) switchView;

@end
