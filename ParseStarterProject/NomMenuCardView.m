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
        [self setBackgroundColor:[UIColor whiteColor]];
        
        self.layer.masksToBounds = NO;
        self.layer.shadowOffset = CGSizeMake(0, 1);
        self.layer.shadowRadius = 1;
        self.layer.shadowOpacity = 0.25;
        self.layer.cornerRadius = 5;
        
        soupIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ICONSIZE, ICONSIZE)];
        [soupIcon setImage:[UIImage imageNamed:@"soup"]];
        [self addSubview:soupIcon];
        soup = [NomNomHelper titleLabelWithString:@""];
        [self addSubview:soup];
        
        mainIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ICONSIZE, ICONSIZE)];
        [mainIcon setImage:[UIImage imageNamed:@"mainFood"]];
        [self addSubview:mainIcon];
        main = [NomNomHelper titleLabelWithString:@""];
        [self addSubview:main];
        
        price = [NomNomHelper hugeLabelWithString:@""];
        [self addSubview:price];
    }
    
    return self;
}

-(void) layoutSubviews
{
    int actualY = 50;
    soupIcon.frame = CGRectMake(PADDING,actualY-ICONSIZE/2,ICONSIZE,ICONSIZE);
    soup.frame = CGRectMake(100,actualY-10,self.bounds.size.width-PADDING*2,20);
    actualY+=100;
    mainIcon.frame = CGRectMake(PADDING,actualY-ICONSIZE/2,ICONSIZE,ICONSIZE);
    main.frame = CGRectMake(100,actualY-10,self.bounds.size.width-PADDING*2,20);
    
    actualY+=100;
    price.frame= CGRectMake(PADDING,actualY-10,self.bounds.size.width-PADDING*2,20);
}

-(void) setCardWithItem :(PFObject*)food
{
    [soup setText:food[@"Soup"]];
    [main setText:food[@"Mainfood"]];
    [price setText:[NSString stringWithFormat:@"%@ Ft", food[@"Price"]]];
}

@end