//
//  EBBHomeViewController.h
//  EJABulletinBoard
//
//  Created by Errol John Antonio on 12/10/14.
//  Copyright (c) 2014 Errol John Antonio. All rights reserved.
//

#import "EBBBaseUIViewController.h"
#import "EBBHomeView.h"
#import "EBBPostTableViewCell.h"


@interface EBBHomeViewController : EBBBaseUIViewController<EBBHomeViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (strong,nonatomic) EBBHomeView *HomeView;
- (void) getUsername: (NSString *) username;
@end
