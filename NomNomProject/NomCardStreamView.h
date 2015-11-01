//
//  NomCardStream.h
//  NomNomNom
//
//  Created by Daniel Feles on 16/10/2015.
//
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <pop/POP.h>
#import "NomMenuCardView.h"

@interface NomCardStreamView:UIView
{
    POPSpringAnimation *anim;
    NSArray *foodList;
    int currentFood;
    UIGestureRecognizer * tapRecognizer;
    UISwipeGestureRecognizer * swipeRecognizer;
    NomMenuCardView* activeCard;
}

-(void) setFoodList :(NSArray*)foodList;
-(void) addCardWithCurrentFood;

@end
