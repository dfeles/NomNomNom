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
    UIButton *moreButton;
    
    //back view
    UILabel *hello;
    
    float moreIconSize;
}
-(void) setCardWithItem :(PFObject*)food;

-(void) switchView;

@end
