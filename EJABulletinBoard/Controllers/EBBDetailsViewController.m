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
#import "Comment.h"
#import "AppDelegate.h"

@interface EBBDetailsViewController (){
      UITextField *activeField;
}
@end

@implementation EBBDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //Load Xib with respect to the screen
    self.DetailsView = (EBBDetailsView *) [self getCustomXibUsingXibName:@"DetailsView"];
    self.DetailsView.frame = CGRectMake(0.0, 0.0, self.view.frame.size.width, self.view.frame.size.height);
    
    //Set Delegates
    self.DetailsView.delegate=self;
    self.DetailsView.commentsTable.delegate = self;
    self.DetailsView.commentsTable.dataSource = self;
    self.DetailsView.commentField.delegate = self;

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.DetailsView.detailsTitle.text = [defaults objectForKey:@"currentTitle"];
    self.DetailsView.detailsPosts.text = [defaults objectForKey:@"currentPosts"];
    self.DetailsView.detailsUser.text = [defaults objectForKey:@"currentUsers"];

    [self.view addSubview:self.DetailsView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table Data Source
-(NSInteger) numberOfSectionsInTableView:(UITableView *)commentsTable{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //    NSMutableArray *persistentTitles = [[defaults arrayForKey:@"titles"]mutableCopy];
    //    NSLog(@" %lu",persistentTitles.count);
    //    return persistentTitles.count;
    
    return [ self getAllCommment].count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.DetailsView.commentsTable) {
        EBBCommentsTableViewCell *commentCell = (EBBCommentsTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"commentCell"];
        
        if (commentCell == nil){
            commentCell = [[[NSBundle mainBundle]loadNibNamed:@"CommentsTableViewCell" owner:nil options:nil]objectAtIndex:0];
        }
        //        NSMutableArray *persistentTitles = [[defaults arrayForKey:@"titles"]mutableCopy];
        //        NSMutableArray *persistentPosts = [[defaults arrayForKey:@"posts"]mutableCopy];
        //        NSMutableArray *persistentUsers = [[defaults arrayForKey:@"users"]mutableCopy];
        
        //        postCell.postTitle.text =[persistentTitles objectAtIndex:indexPath.row];
        //        postCell.postPosts.text =[persistentPosts objectAtIndex:indexPath.row];
        //        postCell.postUser.text =[persistentUsers objectAtIndex:indexPath.row];

        Comment *comments = [[self getAllCommment] objectAtIndex:indexPath.row];
        
        commentCell.commentLabel.text = comments.comment_txxt;
        commentCell.usernameLabel.text = comments.user;
        
        
        //        NSArray *currentPostArray = [[NSArray alloc] initWithObjects:post.title, post.body, post.user, nil];
        //        [defaults setObject:currentPostArray forKey:@"currentPostArray"];
        return commentCell;
    }
    return nil;
}

#pragma mark - Table View Delegate
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 52.0;
    
}

#pragma mark - UItextField Delegates
- (void) textFieldDidBeginEditing:(UITextField *)textField{
    activeField = textField;
    
}


-(void) textFieldDidEndEditing:(UITextField *)textField{
    activeField = nil;
}


-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - Keyboard
- (void)registerForKeyboardNotifications {
    NSLog(@"Keyboard Notifs");
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWasShown:(NSNotification *)aNotification {
    NSLog(@"Keyboard shown");
    // Get size of displayed keyboard
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    // Compute visible active field
    CGRect visibleActiveFieldRect = CGRectMake(activeField.frame.origin.x, activeField.frame.origin.y + kbSize.height, activeField.frame.size.width, activeField.frame.size.height);
    
    // Adjust scroll view content size
    self.DetailsView.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height + kbSize.height);
    
    // Scroll to visible active field
    [self.DetailsView.scrollView scrollRectToVisible:visibleActiveFieldRect animated:YES];
}

- (void)keyboardWillBeHidden:(NSNotification *)aNotification {
    NSLog(@"Keyboard Hidden");
    // Reset the content size of the scroll view
    self.DetailsView.scrollView.contentSize = CGSizeMake(0.0, 0.0);
}


- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    Comment *comments = [[self getAllCommment] objectAtIndex:indexPath.row];
    
    //    NSMutableArray *persistentTitles = [[defaults arrayForKey:@"titles"]mutableCopy];
    //    NSMutableArray *persistentPosts = [[defaults arrayForKey:@"posts"]mutableCopy];
    //    NSMutableArray *persistentUsers = [[defaults arrayForKey:@"users"]mutableCopy];
    
    //    NSString *currentTitle = [persistentTitles objectAtIndex:indexPath.row];
    //    NSString *currentPosts = [persistentPosts objectAtIndex:indexPath.row];
    //    NSString *currentUsers = [persistentUsers objectAtIndex:indexPath.row];
    
    [defaults setObject:comments.comment_txxt forKey:@"currentCommentText"];
    [defaults setObject:comments.user forKey:@"currentCommentUser"];
    
    [defaults synchronize];
    
    //    [self performSegueWithIdentifier:@"PostToDetailsSegue" sender:self];
    
}

- (NSArray*)getAllCommment {
    // with predicate
    
    AppDelegate *ad = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
//    NSString *username = [defaults objectForKey:@"user"];
//    NSString *title = [defaults objectForKey:@"title"];
    
    NSString *post_id = [[NSUserDefaults standardUserDefaults]objectForKey:@"index"]; //Serves as identifier
    
    // Create Predicate
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %@", @"comment_id", post_id];
    [fetchRequest setPredicate:predicate];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Comment" inManagedObjectContext:ad.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Execute Fetch Request
    NSError *fetchError = nil;
    NSArray *result = [ad.managedObjectContext executeFetchRequest:fetchRequest error:&fetchError];
    
    return result;
}




- (void) postButtonPressed{

    NSString *msgSuccess = @"Posted Successfully.";
    NSString *msgError = @"Please fill-up all fields";
    NSString *commentTxt = self.DetailsView.commentField.text;
    
    //TextFields Validations
    if ([commentTxt isEqual:@""]){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Ooooops!" message:msgError delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
    
    else{
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Success!" message:msgSuccess delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
            [self.DetailsView.commentField becomeFirstResponder];
            
            self.DetailsView.commentField.text=@"";
            

            //        NSString *username = [defaults objectForKey:@"username"];
            //        NSMutableArray *mutableCopyTitles = [[defaults arrayForKey:@"titles"]mutableCopy];
            //        NSMutableArray *mutableCopyPosts  = [[defaults arrayForKey:@"posts"]mutableCopy];
            //        NSMutableArray *mutableCopyUsers  = [[defaults arrayForKey:@"users"]mutableCopy];
            //
            //        [mutableCopyTitles addObject:newTitle];
            //        [mutableCopyPosts addObject:newDescription];
            //        [mutableCopyUsers addObject:username];
            //
            //        [defaults setObject:mutableCopyTitles forKey:@"titles"];
            //        [defaults setObject:mutableCopyPosts forKey:@"posts"];
            //        [defaults setObject:mutableCopyUsers forKey:@"users"];
            //
            //        [defaults synchronize];
            

            
            // Get TextField Values
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            NSString *username = [defaults objectForKey:@"username"];
            NSString *post_id = [defaults objectForKey:@"index"];
        
            AppDelegate *ad = (AppDelegate*) [[UIApplication sharedApplication]delegate];
            
            NSEntityDescription *entityComment = [NSEntityDescription entityForName:@"Comment" inManagedObjectContext:ad.managedObjectContext];
        
            NSManagedObject *newComment = [[NSManagedObject alloc]initWithEntity:entityComment insertIntoManagedObjectContext:ad.managedObjectContext];
            
            [newComment setValue:commentTxt forKey:@"comment_txxt"];
            [newComment setValue:username forKey:@"user"];
            [newComment setValue:post_id forKey:@"comment_id"];
        
            
            NSError *error = nil;
            
            if (![newComment.managedObjectContext save:&error]){
                NSLog(@"Unabale to save managed object context.");
                NSLog(@"%@ %@", error, error.localizedDescription);
            }
        
            [self.navigationController popViewControllerAnimated:YES];
        
    }
    
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
