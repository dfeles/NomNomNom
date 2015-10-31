//
//  NomDatabase.m
//  NomNomNom
//
//  Created by Daniel Feles on 15/10/2015.
//  Copyright © 2015 Daniel Feles. All rights reserved.
//

#import "NomDatabase.h"
#import <Parse/Parse.h>

@interface NomDatabase ()

@end

@implementation NomDatabase

+ (NSArray*)getMenuForToday
{
    PFQuery *query = [PFQuery queryWithClassName:@"Menus"];
    [query whereKey:@"Day" containsString:@"Oct 15"];
    NSArray* menusArray = [query findObjects];
    
    for (PFObject *menu in menusArray) {
        NSLog(@"%@", menu[@"Food"]);
    }
    return menusArray;
}


@end