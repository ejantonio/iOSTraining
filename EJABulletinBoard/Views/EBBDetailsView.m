//
//  EBBDetailsView.m
//  EJABulletinBoard
//
//  Created by Errol John Antonio on 12/11/14.
//  Copyright (c) 2014 Errol John Antonio. All rights reserved.
//

#import "EBBDetailsView.h"

@implementation EBBDetailsView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void) awakeFromNib{
    [[self.commentField layer] setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [[self.commentField  layer] setBorderWidth:.4];
    [[self.commentField  layer] setCornerRadius:8.0f];
    
}
- (IBAction)postButtonPressed:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(postButtonPressed)]) {
        [self.delegate postButtonPressed];
    }
}
@end
