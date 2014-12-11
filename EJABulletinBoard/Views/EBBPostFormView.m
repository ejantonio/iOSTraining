//
//  EBBPostFormView.m
//  EJABulletinBoard
//
//  Created by Errol John Antonio on 12/11/14.
//  Copyright (c) 2014 Errol John Antonio. All rights reserved.
//

#import "EBBPostFormView.h"

@implementation EBBPostFormView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)postNowButtonPressed:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(postNowButtonPressed)]) {
        [self.delegate postNowButtonPressed];
    }

}
- (IBAction)cancelButtonPressed:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(cancelButtonPressed)]) {
        [self.delegate cancelButtonPressed];
    }
}
@end
