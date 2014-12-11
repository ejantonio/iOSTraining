//
//  EBBLogInView.m
//  EJABulletinBoard
//
//  Created by Errol John Antonio on 12/9/14.
//  Copyright (c) 2014 Errol John Antonio. All rights reserved.
//

#import "EBBLogInView.h"

@implementation EBBLogInView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)logInButtonPressed:(id)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(logInButtonPressed)]) {
        [self.delegate logInButtonPressed];
    }
}



@end
