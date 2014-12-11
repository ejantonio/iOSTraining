//
//  EBBLogInViewController.m
//  EJABulletinBoard
//
//  Created by Errol John Antonio on 12/9/14.
//  Copyright (c) 2014 Errol John Antonio. All rights reserved.
//

#import "EBBLogInViewController.h"

@interface EBBLogInViewController (){
    UITextField *activeField;
    NSArray *users;
    NSMutableArray *password;
    NSString *inputUsername;
    NSString *inputPassword;
}
@end

@implementation EBBLogInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //Set-Up Layout
    
    
    //Load Xib into view
    self.loginView = (EBBLogInView *) [self getCustomXibUsingXibName:@"logInView"];
    
       self.loginView.frame = CGRectMake(0.0, 0.0, self.view.frame.size.width, self.view.frame.size.height);
    
    //Add login view to view
    [self.view addSubview:self.loginView];
    //Set Delegates
    self.loginView.usernameTextField.delegate = self;
    self.loginView.passwordTextField.delegate=self;
    self.loginView.delegate=self;
    
    [self registerForKeyboardNotifications];


        [self.loginView.usernameTextField becomeFirstResponder];
    
    users = [[NSArray alloc] initWithObjects: @"errol", @"john", nil];
    password = [[NSMutableArray alloc] initWithObjects:@"123", @"456", nil];
}

- (void) viewWillDisappear:(BOOL)animated{
    [self.view resignFirstResponder];
    self.loginView.usernameTextField.text = @"";
    self.loginView.passwordTextField.text = @"";
    [self.loginView.usernameTextField becomeFirstResponder];
}

#pragma mark - EBBLogInView Delegates
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    self.loginView.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height + kbSize.height);
    
    // Scroll to visible active field
    [self.loginView.scrollView scrollRectToVisible:visibleActiveFieldRect animated:YES];
}

- (void)keyboardWillBeHidden:(NSNotification *)aNotification {
        NSLog(@"Keyboard Hidden");
    // Reset the content size of the scroll view
    self.loginView.scrollView.contentSize = CGSizeMake(0.0, 0.0);
}


-(void) logInButtonPressed{
    NSLog(@"Log in Button Pressed");
   inputUsername = self.loginView.usernameTextField.text;
    inputPassword = self.loginView.passwordTextField.text;
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (![inputUsername isEqual:@""] && ![inputPassword isEqual:@""]){
        
        if ([users containsObject:inputUsername] && [password containsObject:inputPassword]){
            
            NSInteger userIndex = [users indexOfObject:inputUsername];
            NSInteger passwordIndex = [password indexOfObject:inputPassword];
            
            if (userIndex == passwordIndex){
                [defaults setObject:inputUsername forKey:@"username"];
                [defaults synchronize];
                [self performSegueWithIdentifier:@"LoginToHomeSegue" sender:self];}
            
        
            else{
                NSString *msg = @"Username and password mismatch.";
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oooopss!" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alertView show];
                [self.loginView.usernameTextField becomeFirstResponder];
            }
        }
        else{
            NSString *msg = @"Wrong username ans password.";
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oooopss!" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
            [self.loginView.usernameTextField becomeFirstResponder];
        }
    
    }
    else{
        NSString *msg = @"Please fill-up all fields.";
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oooopss!" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        [self.loginView.usernameTextField becomeFirstResponder];
        
    }


}

//- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
//    [segue.destinationViewController getUsername:inputUsername];
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

