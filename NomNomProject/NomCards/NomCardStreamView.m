//
//  NomCardStream.m
//  NomNomNom
//
//  Created by Daniel Feles on 16/10/2015.
//
//

#import "NomCardStreamView.h"

@interface NomCardStreamView ()

@end

@implementation NomCardStreamView

-(id) init
{
    
    self = [super init];
    if(self)
    {
        currentFood = 0;
        tapRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        tapRecognizer.cancelsTouchesInView = NO;
        
        currentLocationManager = [CurrentLocationManager new];
        [currentLocationManager getCurrentLocation];
    }
    
    return self;
}

-(void) layoutSubviews
{
    
    anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    
    CGPoint p = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    anim.toValue = [NSValue valueWithCGPoint:p];
    anim.springBounciness = 5.f;
    anim.springSpeed = 3;
}

-(void)handleTap:(id)sender {
    UIView *view = [(UIGestureRecognizer *)sender view];
    
    
    if ([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateBegan) {
        [view pop_removeAnimationForKey:@"slide"];
    }
    
    UIPanGestureRecognizer* recognizer = (UIPanGestureRecognizer*)sender;
    CGPoint translation = [sender translationInView:self];
    
    view.center = CGPointMake(view.center.x + translation.x, view.center.y + translation.y);
    
    
    
    [recognizer setTranslation:CGPointMake(0, 0) inView:view];
    
    if ([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateEnded) {
        CGFloat velocityX = [(UIPanGestureRecognizer*)sender velocityInView:self].x;
        CGFloat velocityY = [(UIPanGestureRecognizer*)sender velocityInView:self].y;
        CGFloat distance = sqrtf(pow(velocityX, 2)+pow(velocityY, 2));
        
        NSLog(@"%f",distance);
        if (fabsf(distance) < 500.f) {
            
            anim.fromValue = [NSValue valueWithCGPoint:view.center];
            [view pop_addAnimation:anim forKey:@"anim"];
            
            
            POPSpringAnimation *rotateBack = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerRotation];
            rotateBack.toValue = @(0.0);
            [view.layer pop_addAnimation:rotateBack forKey:@"rotateBack"];
        }
        else
        {
            POPDecayAnimation *animThrow = [POPDecayAnimation animationWithPropertyNamed:kPOPLayerPosition];
            animThrow.velocity = [NSValue valueWithCGPoint:CGPointMake(velocityX, velocityY)];
            [view pop_addAnimation:animThrow forKey:@"slide"];
            
            
            POPDecayAnimation *rotateMore = [POPDecayAnimation animationWithPropertyNamed:kPOPLayerRotation];
            
            float multiply = -(self.bounds.size.height/2-startTouchY)/(self.bounds.size.height/2);
            rotateMore.velocity = @(-velocityX/300.0*multiply);
            
            [view.layer pop_addAnimation:rotateMore forKey:@"rotateMore"];
            
            [self nextFood];
            [self addCardWithCurrentFood];
            
            animThrow.completionBlock = ^(POPAnimation *animThrow, BOOL finished) {
                [view removeFromSuperview];
            };
        }
        
        
        
    }
}
float startTouchY = 0;
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self scaleUpObject:activeCard];
    UITouch *touch = touches.anyObject;
    startTouchY = [touch locationInView:self].y;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = touches.anyObject;
    
    float force = 1.0;
    if ([touch respondsToSelector:@selector(force)]) {
        force = touch.force;
    }
    
    float scale = (7.0*activeCard.transform.a + (1.05+force/100.0))/8.0;
    float angle = ([NomNomHelper getScreenWidth]/2-activeCard.center.x)/200.0;
    float multiply = -(self.bounds.size.height/2-startTouchY)/(self.bounds.size.height/2);
    
    CGAffineTransform cardTransform = CGAffineTransformMakeScale(scale, scale);
    cardTransform = CGAffineTransformRotate(cardTransform, angle*multiply);
    
    activeCard.transform = cardTransform;
    
    //AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self scaleDownObject:activeCard];
}


-(void) scaleTo:(float) to object:(UIView*) object
{
    
    POPSpringAnimation *scaleUp = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleUp.toValue = [NSValue valueWithCGSize:CGSizeMake(to, to)];
    [object.layer pop_addAnimation:scaleUp forKey:@"scaleUp"];
}

-(void) scaleUpObject:(UIView*) object
{
    
    POPSpringAnimation *scaleUp = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleUp.toValue = [NSValue valueWithCGSize:CGSizeMake(1.05f, 1.05f)];
    [object.layer pop_addAnimation:scaleUp forKey:@"scaleUp"];
    

    POPSpringAnimation *shadowDown = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerShadowOffset];
    shadowDown.toValue = [NSValue valueWithCGSize:CGSizeMake(0.00f, 3.00f)];
    [object.layer pop_addAnimation:shadowDown forKey:@"shadowDown"];
    
    POPSpringAnimation *shadowRadius = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerShadowRadius];
    shadowRadius.toValue = @(3);
    [object.layer pop_addAnimation:shadowRadius forKey:@"shadowRadius"];
    
    POPSpringAnimation *shadowOpacity = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerShadowOpacity];
    shadowOpacity.toValue = @(0.8f);
    [object.layer pop_addAnimation:shadowOpacity forKey:@"shadowOpacity"];

}
-(void) scaleDownObject:(UIView*) object
{
    
    POPSpringAnimation *scaleUp = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleUp.toValue = [NSValue valueWithCGSize:CGSizeMake(1.00f, 1.00f)];
    [activeCard.layer pop_addAnimation:scaleUp forKey:@"scaleUp"];
    
    POPSpringAnimation *shadowDown = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerShadowOffset];
    shadowDown.toValue = [NSValue valueWithCGSize:CGSizeMake(0.00f, 1.00f)];
    [activeCard.layer pop_addAnimation:shadowDown forKey:@"shadowDown"];
    [activeCard.layer pop_addAnimation:shadowDown forKey:@"shadowDown"];
    
    POPSpringAnimation *shadowRadius = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerShadowRadius];
    shadowRadius.toValue = @(1);
    [activeCard.layer pop_addAnimation:shadowRadius forKey:@"shadowRadius"];
    
    POPSpringAnimation *shadowOpacity = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerShadowOpacity];
    shadowOpacity.toValue = @(0.3);
    [activeCard.layer pop_addAnimation:shadowOpacity forKey:@"shadowOpacity"];
}

-(void) nextFood
{
    currentFood++;
    if (currentFood >= [foodList count]) currentFood = 0;
}

-(void) setFoodList :(NSArray*)_foodList
{
    foodList = _foodList;
}

-(void) addCardWithCurrentFood
{
    
    
    NomMenuCardView* currentCard = [NomMenuCardView new];
    
    
    activeCard = currentCard;
    [self addSubview:currentCard];
    
    [currentCard addGestureRecognizer:tapRecognizer];
    
    
    currentCard.frame = CGRectMake(CARDPADDING, self.bounds.size.height-CARDPADDING*2, [NomNomHelper getScreenWidth]-CARDPADDING*2, self.bounds.size.height-CARDPADDING*2);
    
    [currentCard pop_addAnimation:anim forKey:@"slide"];
    
    [currentCard setCurrentLocation:currentLocationManager.currentLocation];
    [currentCard setCardWithItem:foodList[currentFood]];

    
}

@end