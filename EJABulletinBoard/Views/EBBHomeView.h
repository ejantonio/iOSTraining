//
//  EBBHomeView.h
//  EJABulletinBoard
//
//  Created by Errol John Antonio on 12/10/14.
//  Copyright (c) 2014 Errol John Antonio. All rights reserved.
//

#import <UIKit/UIKit.h>



@protocol EBBHomeViewDelegate <NSObject>

@required
- (void) addPostButtonPressed;
- (void) logoutButtonPressed;

@end

@interface EBBHomeView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *profileName;
@property (weak, nonatomic) IBOutlet UIButton *logoutButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *addPostButton;
- (IBAction)addPostButtonPressed:(id)sender;

- (IBAction)logoutButtonPressed:(id)sender;

@property (strong) id<EBBHomeViewDelegate> delegate;

@end
