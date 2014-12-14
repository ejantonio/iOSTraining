//
//  EBBDetailsView.h
//  EJABulletinBoard
//
//  Created by Errol John Antonio on 12/11/14.
//  Copyright (c) 2014 Errol John Antonio. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EBBDetailsViewDelegate <NSObject>

@required
- (void) postButtonPressed;

@end

@interface EBBDetailsView : UIView

@property (weak, nonatomic) IBOutlet UILabel *detailsTitle;

@property (weak, nonatomic) IBOutlet UILabel *detailsUser;
@property (weak, nonatomic) IBOutlet UITextView *detailsPosts;

@property (weak, nonatomic) IBOutlet UITableView *commentsTable;

@property (weak, nonatomic) IBOutlet UITextView *commentField;
@property (weak, nonatomic) IBOutlet UIButton *postButton;

- (IBAction)postButtonPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong) id<EBBDetailsViewDelegate> delegate;
@end
