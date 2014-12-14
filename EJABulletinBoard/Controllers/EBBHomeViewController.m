//
//  EBBHomeViewController.m
//  EJABulletinBoard
//
//  Created by Errol John Antonio on 12/10/14.
//  Copyright (c) 2014 Errol John Antonio. All rights reserved.
//

#import "EBBHomeViewController.h"
#import "EBBHomeView.h"
#import "EBBLogInView.h"
#import "AppDelegate.h"
#import "Post.h"

@interface EBBHomeViewController (){
    NSString *username;
    NSString *welcomeRemark;

    NSMutableArray *titles;
    NSMutableArray *posts;
    NSMutableArray *users;
}

@end

@implementation EBBHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //Set XIb View into View
    self.HomeView = (EBBHomeView *) [self getCustomXibUsingXibName:@"HomeView"];
    self.HomeView.frame = CGRectMake(0.0, 0.0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:self.HomeView];
    
    self.navigationItem.hidesBackButton = YES;
    
    //Set Delegates
    self.HomeView.delegate=self;
    self.HomeView.tableView.delegate = self;
    self.HomeView.tableView.dataSource = self;
    
    //Declaration of NSUSerDefaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    username = [defaults objectForKey:@"username"];
    welcomeRemark = @"Hello, ";
    
    self.HomeView.profileName.text = [welcomeRemark stringByAppendingString: username];
    

    if ([defaults objectForKey:@"isFirstRun"] == nil){
        [defaults setObject:@"YES" forKey:@"isFirstRun"];
        
        // titles = [[NSMutableArray alloc] initWithObjects: @"MANILA at SIGNAL 2", @"CD Christmas Party", nil];
        // posts = [[NSMutableArray alloc] initWithObjects:@"Everyone is advised to WFH.", @"Let's Celebrate on the 17th!", nil];
        // users = [[NSMutableArray alloc] initWithObjects: @"Earth M.", @"Errol A.", nil];
        
        [defaults setObject:titles forKey:@"titles"];
        [defaults setObject:posts forKey:@"posts"];
        [defaults setObject:users forKey:@"users"];
        
        [defaults synchronize];
        

        // [defaults objectForKey:@"titles"];
        // [defaults objectForKey:@"posts"];
        // [defaults objectForKey:@"users"];

    }
    
    if ([username isEqualToString:@"errol"]){
        self.HomeView.profileImage.image = [UIImage imageNamed:@"errol"];
    }
    else{
        self.HomeView.profileImage.image = [UIImage imageNamed:@"vaughn"];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) addPostButtonPressed{

//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    For Hard-Coded Posts
//    NSMutableArray *mutableCopyTitles = [[defaults arrayForKey:@"titles"]mutableCopy];
//    NSMutableArray *mutableCopyPosts  = [[defaults arrayForKey:@"posts"]mutableCopy];
//    NSMutableArray *mutableCopyUsers  = [[defaults arrayForKey:@"users"]mutableCopy];
//    
//    
//    [mutableCopyTitles addObject:@"test"];
//    [mutableCopyPosts addObject:@"test"];
//    [mutableCopyUsers addObject:username];
//    
//    
//    //replace
//    [defaults setObject:mutableCopyTitles forKey:@"titles"];
//    [defaults setObject:mutableCopyPosts forKey:@"posts"];
//    [defaults setObject:mutableCopyUsers forKey:@"users"];
//    
//    [defaults synchronize];
//    
//    [self.HomeView.tableView reloadData];
    
      [self performSegueWithIdentifier:@"HomeToFormSegue" sender:self];
}

-(void) logoutButtonPressed{
    NSLog(@"Log out Button Pressed");
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"username"];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table Data Source
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSMutableArray *persistentTitles = [[defaults arrayForKey:@"titles"]mutableCopy];
//    NSLog(@" %lu",persistentTitles.count);
//    return persistentTitles.count;
    
    return [ self getAllPost].count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.HomeView.tableView) {
        EBBPostTableViewCell *postCell = (EBBPostTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"postCell"];
        
        if (postCell == nil){
            postCell = [[[NSBundle mainBundle]loadNibNamed:@"PostTableViewCell" owner:nil options:nil]objectAtIndex:0];
        }
//
//        NSMutableArray *persistentTitles = [[defaults arrayForKey:@"titles"]mutableCopy];
//        NSMutableArray *persistentPosts = [[defaults arrayForKey:@"posts"]mutableCopy];
//        NSMutableArray *persistentUsers = [[defaults arrayForKey:@"users"]mutableCopy];
        
//        postCell.postTitle.text =[persistentTitles objectAtIndex:indexPath.row];
//        postCell.postPosts.text =[persistentPosts objectAtIndex:indexPath.row];
//        postCell.postUser.text =[persistentUsers objectAtIndex:indexPath.row];

        Post *post = [[self getAllPost] objectAtIndex:indexPath.row];
        
        postCell.postTitle.text = post.title;
        postCell.postPosts.text = post.body;
        postCell.postUser.text = post.user;
        
        
//       NSArray *currentPostArray = [[NSArray alloc] initWithObjects:post.title, post.body, post.user, nil];
//       [defaults setObject:currentPostArray forKey:@"currentPostArray"];
        
        return postCell;
    }
        return nil;
}



#pragma mark - Table View Delegate
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 83.0;
    
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    Post *post = [[self getAllPost] objectAtIndex:indexPath.row];
    
//    NSMutableArray *persistentTitles = [[defaults arrayForKey:@"titles"]mutableCopy];
//    NSMutableArray *persistentPosts = [[defaults arrayForKey:@"posts"]mutableCopy];
//    NSMutableArray *persistentUsers = [[defaults arrayForKey:@"users"]mutableCopy];
    
//    NSString *currentTitle = [persistentTitles objectAtIndex:indexPath.row];
//    NSString *currentPosts = [persistentPosts objectAtIndex:indexPath.row];
//    NSString *currentUsers = [persistentUsers objectAtIndex:indexPath.row];
    
    NSString *row = @(indexPath.row).stringValue;
    [defaults setObject:post.title forKey:@"currentTitle"];
    [defaults setObject:post.body forKey:@"currentPosts"];
    [defaults setObject:post.user forKey:@"currentUsers"];
    
    [defaults synchronize];
    
    [defaults setObject:row forKey:@"index"];
    
    [self performSegueWithIdentifier:@"PostToDetailsSegue" sender:self];

}

- (NSArray*) getAllPost{
    AppDelegate *ad = (AppDelegate*) [[UIApplication sharedApplication]delegate];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Post" inManagedObjectContext:ad.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSError *error = nil;
    NSArray *result = [ad.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    if (error){
        NSLog(@"Unable to excutefetch request");
        NSLog(@"%@ %@", error, error.localizedDescription);
    }else{
        NSLog(@"%@", result);
    }
    
    return result;
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
