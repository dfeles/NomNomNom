//
//  NomHeader.m
//  NomNomNom
//
//  Created by Daniel Feles on 16/10/2015.
//
//

#import "NomHeader.h"

@interface NomHeader ()

@end

@implementation NomHeader

-(id) init
{
    
    self = [super init];
    if(self)
    {
        nomLogo = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ICONSIZE, ICONSIZE)];
        [nomLogo setImage:[UIImage imageNamed:@"logo"]];
        nomLogo.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:nomLogo];
    }
    
    return self;
}

-(void) layoutSubviews
{
    nomLogo.frame = CGRectMake([NomNomHelper getScreenWidth]/2-ICONSIZE/2, self.bounds.size.height/2-ICONSIZE/2+20, ICONSIZE, ICONSIZE);
}

@end