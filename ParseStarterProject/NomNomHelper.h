//
//  NomNomHelper.h
//  NomNomNom
//
//  Created by Daniel Feles on 16/10/2015.
//
//

#import <UIKit/UIKit.h>

#define PADDING 10
#define CARDPADDING 20
#define HEADER 100
#define ICONSIZE 76

@interface NomNomHelper:NSObject{
}

+(UILabel*) titleLabelWithString: (NSString*)content;
+(UILabel*) hugeLabelWithString: (NSString*)content;
+(UIColor *)colorWithHex:(UInt32)col;
+(int)getScreenWidth;
+(int)getScreenHeight;

@end