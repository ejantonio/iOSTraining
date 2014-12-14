//
//  EBBPostFormViewController.m
//  EJABulletinBoard
//
//  Created by Errol John Antonio on 12/11/14.
//  Copyright (c) 2014 Errol John Antonio. All rights reserved.
//

#import "EBBPostFormViewController.h"
#import "EBBPostFormView.h"
#import "EBBHomeView.h"
#include <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"

@interface EBBPostFormViewController ()

@end

@implementation EBBPostFormViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.PostFormView = (EBBPostFormView *) [self getCustomXibUsingXibName:@"PostFormView"];
    self.PostFormView.frame = CGRectMake(0.0, 0.0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:self.PostFormView];
   
    
    //Set Up Delegates
    self.PostFormView.delegate=self;
    
    self.PostFormView.descriptionField.text=@"";
    [self.PostFormView.titleField becomeFirstResponder];
    
    [[self.PostFormView.descriptionField layer] setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [[self.PostFormView.descriptionField  layer] setBorderWidth:.4];
    [[self.PostFormView.descriptionField  layer] setCornerRadius:8.0f];
        
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void) postNowButtonPressed{

    NSString *msgSuccess = @"Posted Successfully.";
    NSString *msgError = @"Please fill-up all fields";
    NSString *msgTitleErrror = @"Title must only contain a maximum of 20 characters.";
    NSString *title = self.PostFormView.titleField.text;
    NSString *body = self.PostFormView.descriptionField.text;
    
    if ([title isEqual:@""] || [body isEqual:@""] ){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Ooooops!" message:msgError delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }

    else{
        if (title.length >=21){
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Warning!" message:msgTitleErrror delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
        }
        else{
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Success!" message:msgSuccess delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        [self.PostFormView.titleField becomeFirstResponder];

        self.PostFormView.titleField.text=@"";
        self.PostFormView.descriptionField.text=@"";
        }

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
        
        AppDelegate *ad = (AppDelegate*) [[UIApplication sharedApplication]delegate];
        
        NSEntityDescription *entityPost = [NSEntityDescription entityForName:@"Post" inManagedObjectContext:ad.managedObjectContext];
        
        NSManagedObject *newPost = [[NSManagedObject alloc]initWithEntity:entityPost insertIntoManagedObjectContext:ad.managedObjectContext];
        
        [newPost setValue:title forKey:@"title"];
        [newPost setValue:body forKey:@"body"];
        [newPost setValue:username forKey:@"user"];
        
        
        NSError *error = nil;
        
        if (![newPost.managedObjectContext save:&error]){
            NSLog(@"Unabale to save managed object context.");
            NSLog(@"%@ %@", error, error.localizedDescription);
        }
        }
    
        //[self.navigationController popViewControllerAnimated:YES];
   
}

-(void) cancelButtonPressed{

    self.PostFormView.titleField.text=@"";
    self.PostFormView.descriptionField.text=@"";

    [self.navigationController popViewControllerAnimated:YES];
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
