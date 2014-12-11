//
//  EBBLogInViewController.h
//  EJABulletinBoard
//
//  Created by Errol John Antonio on 12/9/14.
//  Copyright (c) 2014 Errol John Antonio. All rights reserved.
//

#import "EBBBaseUIViewController.h"
#import "EBBLogInView.h"
@interface EBBLogInViewController : EBBBaseUIViewController <EBBlogInViewDelegate, UITextFieldDelegate>

@property (strong,nonatomic) EBBLogInView *loginView;




@end
