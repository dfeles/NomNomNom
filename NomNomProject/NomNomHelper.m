//
//  NomNomHelper.m
//  NomNomNom
//
//  Created by Daniel Feles on 16/10/2015.
//
//

#import "NomNomHelper.h"

@interface NomNomHelper ()

@end

@implementation NomNomHelper

+(UILabel*) titleLabelWithString: (NSString*)content
{
    UILabel *label = [UILabel new];
    [label setFont:[UIFont boldSystemFontOfSize:16]];
    [label setTextColor:[UIColor blackColor]];
    [label setText:content];
    
    return label;
}

+(UILabel*) hugeLabelWithString: (NSString*)content
{
    UILabel *label = [UILabel new];
    [label setFont:[UIFont boldSystemFontOfSize:22]];
    [label setTextColor:[UIColor blackColor]];
    [label setText:content];
    [label setTextAlignment:NSTextAlignmentCenter];
    
    return label;
}

+ (UIColor *)colorWithHex:(UInt32)col {
    unsigned char r, g, b;
    b = col & 0xFF;
    g = (col >> 8) & 0xFF;
    r = (col >> 16) & 0xFF;
    return [UIColor colorWithRed:(float)r/255.0f green:(float)g/255.0f blue:(float)b/255.0f alpha:1];
}

+(int)getScreenWidth
{
    return [UIScreen mainScreen].bounds.size.width;
}
+(int)getScreenHeight
{
    return [UIScreen mainScreen].bounds.size.height;
}



@end