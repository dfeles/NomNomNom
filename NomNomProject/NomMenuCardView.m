//
//  NomDatabase.m
//  NomNomNom
//
//  Created by Daniel Feles on 15/10/2015.
//  Copyright © 2015 Daniel Feles. All rights reserved.
//

#import "NomMenuCardView.h"

@interface NomMenuCardView ()

@end

@implementation NomMenuCardView

-(id) init
{
    
    self = [super init];
    if(self)
    {
        self.clipsToBounds = YES;
        frontViewOpened = true;
        [self setBackgroundColor:[UIColor whiteColor]];
        frontView = [UIView new];
        backView = [UIView new];
        
        self.layer.masksToBounds = NO;
        self.layer.shadowOffset = CGSizeMake(0, 1);
        self.layer.shadowRadius = 1;
        self.layer.shadowOpacity = 0.25;
        self.layer.cornerRadius = 5;
        
        [self createFrontView];
        [self addSubview:frontView];
        
        
        [self createBackView];
    }
    
    return self;
}

-(void) createFrontView
{
    
    soupIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ICONSIZE, ICONSIZE)];
    [soupIcon setImage:[UIImage imageNamed:@"soup"]];
    [frontView addSubview:soupIcon];
    soup = [NomNomHelper titleLabelWithString:@""];
    [frontView addSubview:soup];
    
    mainIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ICONSIZE, ICONSIZE)];
    [mainIcon setImage:[UIImage imageNamed:@"mainFood"]];
    [frontView addSubview:mainIcon];
    main = [NomNomHelper titleLabelWithString:@""];
    [frontView addSubview:main];
    
    price = [NomNomHelper hugeLabelWithString:@""];
    [frontView addSubview:price];
    
    price = [NomNomHelper hugeLabelWithString:@""];
    [frontView addSubview:price];
    
    distance = [NomNomHelper subTitleLabelWithString:@""];
    [frontView addSubview:distance];
    
    
    moreIconSize = 30;
    moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [moreButton addTarget:self action:@selector(swap:) forControlEvents:UIControlEventTouchUpInside];
    
   
    UIImageView* moreIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, moreIconSize, moreIconSize)];
    [moreIcon setImage:[UIImage imageNamed:@"moreIcon"]];
    [moreButton setImage:[UIImage imageNamed:@"moreIcon"] forState:UIControlStateNormal];
    [frontView addSubview:moreButton];
}

-(void) createBackView
{
    hello = [NomNomHelper titleLabelWithString:@"hellooo"];
    [backView addSubview:hello];
    
    mapView = [MapView new];
    [backView addSubview:mapView];
}

-(void) layoutSubviews
{
    frontView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    
    int actualY = 50;
    soupIcon.frame = CGRectMake(PADDING,actualY-ICONSIZE/2,ICONSIZE,ICONSIZE);
    soup.frame = CGRectMake(2*PADDING+ICONSIZE,actualY-10,self.bounds.size.width-PADDING*2,20);
    actualY+=100;
    mainIcon.frame = CGRectMake(PADDING,actualY-ICONSIZE/2,ICONSIZE,ICONSIZE);
    main.frame = CGRectMake(2*PADDING+ICONSIZE,actualY-10,self.bounds.size.width-PADDING*2,20);
    
    actualY+=100;
    price.frame= CGRectMake(PADDING,actualY-10,self.bounds.size.width-PADDING*2,20);
    actualY+=30;
    distance.frame= CGRectMake(PADDING,actualY-10,self.bounds.size.width-PADDING*2,20);
    
    actualY+=50;
    moreButton.frame= CGRectMake(self.bounds.size.width/2-moreIconSize/2,actualY,moreIconSize,moreIconSize);
    
    
    
    actualY = 50;
    backView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    backView.backgroundColor = [NomNomHelper colorWithHex:0xEFEFEF];

    mapView.frame = CGRectMake(PADDING, PADDING, backView.frame.size.width-PADDING*2,backView.frame.size.width-PADDING*2);
    
    
    
}

-(void) setCardWithItem :(PFObject*)food
{
    [soup setText:food[@"Soup"]];
    [main setText:food[@"Mainfood"]];
    [price setText:[NSString stringWithFormat:@"%@ Ft", food[@"Price"]]];
    
    [self getLocation:@"Kastély utca 18, Törökbálint"];
    
}

-(void) getLocation:(NSString*) address
{
    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
    [geoCoder geocodeAddressString:address completionHandler:^(NSArray* placemarks, NSError* error){
        // This is called later, at some point after view did load is called.
        NSLog(@"Inside completionHandler.");
        
        if(error) {
            NSLog(@"Error");
            return;
        }
        
        CLPlacemark *placemark = [placemarks lastObject];
        
        [mapView goTo:placemark.location currentLocation:[self currentLocation]];
        
        CLLocationDistance meters = [placemark.location distanceFromLocation:[self currentLocation]];
        if(meters < 1000)
        {
            [distance setText:[NSString stringWithFormat:@"%i%@",(int) meters,@" m"]];
        }
        else
        {
            [distance setText:[NSString stringWithFormat:@"%f%@",meters/1000,@" km"]];
        }
    }];
}

-(void) switchView
{
    if(frontViewOpened)
    {
        [UIView transitionWithView:self
                          duration:0.5
                           options:UIViewAnimationOptionTransitionFlipFromLeft
                        animations: ^{
                            [frontView removeFromSuperview];
                            [self addSubview:backView];
                            [backView addSubview:moreButton];
                        }
                        completion:NULL];
        frontViewOpened = false;
    }
    else
    {
        
        [UIView transitionWithView:self
                          duration:0.5
                           options:UIViewAnimationOptionTransitionFlipFromRight
                        animations: ^{
                            [backView removeFromSuperview];
                            [self addSubview:frontView];
                            [frontView addSubview:moreButton];
                        }
                        completion:NULL];
        frontViewOpened = true;
    }
}

- (IBAction)swap:(UIButton *)button
{
    /*
    if ([self.delegate respondsToSelector:@selector(myController:buttonTapped:)]) {
        [self.delegate myController:self buttonTapped:button];
    }
    */
    [self switchView];
}

@end