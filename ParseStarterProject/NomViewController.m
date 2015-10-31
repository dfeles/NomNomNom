/**
 * Copyright (c) 2015-present, Parse, LLC.
 * All rights reserved.
 *
 * This source code is licensed under the BSD-style license found in the
 * LICENSE file in the root directory of this source tree. An additional grant
 * of patent rights can be found in the PATENTS file in the same directory.
 */

#import "NomViewController.h"

@implementation NomViewController

#pragma mark -
#pragma mark UIViewController

CGFloat width;
CGFloat height;

- (void)viewDidLoad {
    [super viewDidLoad];
    width = [UIScreen mainScreen].bounds.size.width;
    height = [UIScreen mainScreen].bounds.size.height;
    
//    [self.view setBackgroundColor:[UIColor redColor]];
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"background"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    
    menusArray = [NomDatabase getMenuForToday];
    
    [self addHeader];
    [self addCardStream];
    [cardStream setFoodList:menusArray];
    
}

- (void) viewDidAppear:(BOOL) animated {
    //do stuff...
    [cardStream addCardWithCurrentFood];
}

- (void)viewWillLayoutSubviews {
    
    
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];

    // Release any cached data, images, etc that aren't in use.
}

- (void)loadMenus
{
    
}
- (void) addHeader
{
    header = [NomHeader new];
    [header setFrame:CGRectMake(0, 0, width, HEADER)];
    [self.view addSubview:header];
}

- (void) addCardStream
{
    cardStream = [NomCardStreamView new];
    [cardStream setFrame:CGRectMake(0, HEADER+PADDING, width, height-HEADER-PADDING*2)];
    [self.view addSubview:cardStream];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
