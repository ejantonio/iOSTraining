//
//  EBBLogInView.h
//  EJABulletinBoard
//
//  Created by Errol John Antonio on 12/9/14.
//  Copyright (c) 2014 Errol John Antonio. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EBBlogInViewDelegate <NSObject>

@required
- (void) logInButtonPressed;

@end




@interface EBBLogInView : UIView
//IBOutlets
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIButton *logInButton;

- (IBAction)logInButtonPressed:(id)sender;

@property (strong) id<EBBlogInViewDelegate> delegate;

@end
