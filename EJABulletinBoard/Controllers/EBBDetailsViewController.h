//
//  EBBDetailsViewController.h
//  EJABulletinBoard
//
//  Created by Errol John Antonio on 12/11/14.
//  Copyright (c) 2014 Errol John Antonio. All rights reserved.
//

#import "EBBBaseUIViewController.h"
#import "EBBDetailsView.h"
#import "EBBCommentsTableViewCell.h"

@interface EBBDetailsViewController : EBBBaseUIViewController <EBBDetailsViewDelegate, UITabBarDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (strong,nonatomic) EBBDetailsView *DetailsView;
@end
