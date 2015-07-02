//
//  SettingViewController.m
//  EVA
//
//  Created by SourabhBanerjee on 6/11/15.
//  Copyright (c) 2015 47Billion. All rights reserved.
//

#import "SettingViewController.h"
#import <QuartzCore/QuartzCore.h>
@interface SettingViewController ()
{
    IBOutlet UIImageView*imgProfile;
    IBOutlet UITextField*txtName;
}
@end

@implementation SettingViewController




- (id)initWithCoder:(NSCoder*)aDecoder
{
    if(self = [super initWithCoder:aDecoder])
    {
        // [[self.tabBarController.tabBar.items objectAtIndex:1] setTitle:NSLocalizedString(@"Upcoming", @"comment")];
        
        //self.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFavorites tag:1];
        // self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Upcoming" image:nil selectedImage:nil];
        
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0,450, 20)];
    view.backgroundColor=[UIColor colorWithRed:0/255.0f green:188/255.0f blue:212/255.0f alpha:1.0];
    [self.navigationController.view addSubview:view];

    
    
}- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *maskImage = [UIImage imageNamed:@"circleIMG"];

    [self setimage:maskImage];

    txtName.autocapitalizationType = UITextAutocapitalizationTypeWords;

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES;
}
#pragma mark--
#pragma mark-IBACTION
-(IBAction)DoneActoin:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert!"
                                                    message:@"Your profile is update successfully."
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];

}

-(IBAction)editActon:(id)sender
{

UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Please Select Photo"                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Take Photo", @"Choose Photo", nil];
         [actionSheet showInView:self.view];
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        
        //////TAKE PHOTO
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                  message:@"Device has no camera"
                                                                 delegate:nil
                                                        cancelButtonTitle:@"OK"
                                                        otherButtonTitles: nil];
            
            [myAlertView show];
            
        }

        else
        {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = (id)self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:picker animated:YES completion:NULL];
        }
        
    }
    else if (buttonIndex==1)
    {
        ///CHOOSE FROM PICKER
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = (id)self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        [self presentViewController:picker animated:YES completion:NULL];

    
    }
}

#pragma mark - Image Picker Controller delegate methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    [self setimage:chosenImage];
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}
-(void)setimage:(UIImage*)imgv
{
   imgProfile.image=nil;
[imgProfile setImage:imgv];
imgProfile.layer.cornerRadius = imgProfile.frame.size.width/2;
imgProfile.layer.masksToBounds = YES;

}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
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
