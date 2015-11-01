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
    
    actualY+=100;
    moreButton.frame= CGRectMake(self.bounds.size.width/2-moreIconSize/2,actualY,moreIconSize,moreIconSize);
    
    
    
    actualY = 50;
    backView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    hello.frame = CGRectMake(2*PADDING+ICONSIZE,actualY-10,self.bounds.size.width-PADDING*2,20);
    
}

-(void) setCardWithItem :(PFObject*)food
{
    [soup setText:food[@"Soup"]];
    [main setText:food[@"Mainfood"]];
    [price setText:[NSString stringWithFormat:@"%@ Ft", food[@"Price"]]];
}

-(void) switchView
{
    if(frontViewOpened)
    {
        [frontView removeFromSuperview];
        [self addSubview:backView];
        frontViewOpened = false;
    }
    else
    {
        [backView removeFromSuperview];
        [self addSubview:frontView];
        frontViewOpened = true;
    }
}

- (IBAction)swap:(UIButton *)button
{
    [UIView transitionWithView:self
                      duration:0.5
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations: ^{
                        [backView removeFromSuperview];
                        [self addSubview:frontView];
                    }
                    completion:NULL];
    /*
    if ([self.delegate respondsToSelector:@selector(myController:buttonTapped:)]) {
        [self.delegate myController:self buttonTapped:button];
    }
    */
    [self switchView];
}

@end