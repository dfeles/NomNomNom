//
//  NomDatabase.h
//  NomNomNom
//
//  Created by Daniel Feles on 15/10/2015.
//  Copyright © 2015 Daniel Feles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NomDatabase:NSObject

+(UILabel*) giveMeALabelWithString: (NSString*)content andFontSize:(int)fontSize andColor:(UInt32*)col;
+ (UIColor *)colorWithHex:(UInt32)col;

+ (NSArray*)getMenuForToday;

@end
