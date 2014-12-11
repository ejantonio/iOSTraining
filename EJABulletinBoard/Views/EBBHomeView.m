//
//  EBBHomeView.m
//  EJABulletinBoard
//
//  Created by Errol John Antonio on 12/10/14.
//  Copyright (c) 2014 Errol John Antonio. All rights reserved.
//

#import "EBBHomeView.h"

@implementation EBBHomeView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void) awakeFromNib{
    //Make Profile Image in Circular Shape
    self.profileImage.layer.cornerRadius = self.frame.size.width / 5.5;
    self.profileImage.clipsToBounds = YES;
    self.profileImage.layer.borderWidth = 3.0f;
    self.profileImage.layer.borderColor = [UIColor whiteColor].CGColor;
}

- (IBAction)addPostButtonPressed:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(addPostButtonPressed)]) {
        [self.delegate addPostButtonPressed];
    }
}

- (IBAction)logoutButtonPressed:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(logoutButtonPressed)]) {
        [self.delegate logoutButtonPressed];
    }
}
@end
