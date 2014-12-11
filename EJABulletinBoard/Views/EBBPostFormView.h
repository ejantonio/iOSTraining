//
//  EBBPostFormView.h
//  EJABulletinBoard
//
//  Created by Errol John Antonio on 12/11/14.
//  Copyright (c) 2014 Errol John Antonio. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol EBBPostFormDelegate <NSObject>

@required
- (void) postNowButtonPressed;
- (void) cancelButtonPressed;

@end


@interface EBBPostFormView : UIView
@property (weak, nonatomic) IBOutlet UITextField *titleField;
@property (weak, nonatomic) IBOutlet UITextView *descriptionField;
@property (weak, nonatomic) IBOutlet UIButton *postNowButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
- (IBAction)postNowButtonPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *cancelButtonPressed;

- (IBAction)cancelButtonPressed:(id)sender;

@property (strong) id<EBBPostFormDelegate> delegate;
@end
