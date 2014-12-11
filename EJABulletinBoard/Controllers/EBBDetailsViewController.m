//
//  EBBDetailsViewController.m
//  EJABulletinBoard
//
//  Created by Errol John Antonio on 12/11/14.
//  Copyright (c) 2014 Errol John Antonio. All rights reserved.
//

#import "EBBDetailsViewController.h"
#import "EBBDetailsView.h"
#import "EBBHomeView.h"

@interface EBBDetailsViewController (){
    
}


@end
@implementation EBBDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.DetailsView = (EBBDetailsView *) [self getCustomXibUsingXibName:@"DetailsView"];
    self.DetailsView.frame = CGRectMake(0.0, 0.0, self.view.frame.size.width, self.view.frame.size.height);
    
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.DetailsView.detailsTitle.text = [defaults objectForKey:@"currentTitle"];
    self.DetailsView.detailsPosts.text = [defaults objectForKey:@"currentPosts"];
    self.DetailsView.detailsUser.text = [defaults objectForKey:@"currentUsers"];
    
//    [self.DetailsView.detailsPosts sizeToFit];
    
//    CGSize labelSize = [self.DetailsView.detailsPosts.text sizeWithFont:[UIFont systemFontOfSize:17.0f]
//                        constrainedToSize:self.DetailsView.detailsPosts.frame.size
//                            lineBreakMode:NSLineBreakByWordWrapping];
//    
//    CGFloat labelHeight = labelSize.height;
//    
//    self.DetailsView.scrollView.contentSize = CGSizeMake(self.DetailsView.detailsPosts.frame.size.width, labelHeight);
    
    [self.view addSubview:self.DetailsView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
