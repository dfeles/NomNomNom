//
//  NomDatabase.h
//  NomNomNom
//
//  Created by Daniel Feles on 15/10/2015.
//  Copyright © 2015 Daniel Feles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "NomNomHelper.h"

@interface NomMenuCardView:UIView{
    UILabel *soup;
    UIImageView *soupIcon;
    UILabel *main;
    UIImageView *mainIcon;
    
    UILabel *price;
}
-(void) setCardWithItem :(PFObject*)food;

@end
