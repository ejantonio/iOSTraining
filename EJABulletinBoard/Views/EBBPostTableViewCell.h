//
//  EBBPostTableViewCell.h
//  EJABulletinBoard
//
//  Created by Errol John Antonio on 12/10/14.
//  Copyright (c) 2014 Errol John Antonio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EBBPostTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *postTitle;
@property (weak, nonatomic) IBOutlet UILabel *postPosts;
@property (weak, nonatomic) IBOutlet UILabel *postUser;

@end
