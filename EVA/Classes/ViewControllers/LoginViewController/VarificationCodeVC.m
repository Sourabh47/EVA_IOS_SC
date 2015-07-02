//
//  VarificationCodeVC.m
//  EVA
//
//  Created by SourabhBanerjee on 6/12/15.
//  Copyright (c) 2015 47Billion. All rights reserved.
//

#import "VarificationCodeVC.h"

@interface VarificationCodeVC ()
{
    IBOutlet UITextField*txtfirst;
    IBOutlet UITextField*txtsecond;
    IBOutlet UITextField*txtthird;
    IBOutlet UITextField*txtfourt;
    IBOutlet UIButton*btnDone;

}
@end

@implementation VarificationCodeVC

#pragma mark--
#pragma mark- View Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [txtfirst becomeFirstResponder];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark--
#pragma mark-IBACTION

-(IBAction)openEventViewControllerAction:(id)sender
{
    if (txtfirst.text && txtfirst.text.length > 0 && txtsecond.text && txtsecond.text.length>0 && txtthird.text && txtthird.text.length && txtfourt.text && txtfourt.text.length>0)
    {
     AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
     [app.window setRootViewController:app.tabBarController];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert!" message:@"Please enter all fileds." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    
    }
    
}
-(IBAction)backBtnAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(IBAction)sendAgainVerifcationCode:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert!" message:@"Please check your mobile,Verification code is send to your number." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];


}
#pragma mark--
#pragma mark- TEXTFILED

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    // This allows numeric text only, but also backspace for deletes
    if (string.length > 0 && ![[NSScanner scannerWithString:string] scanInt:NULL])
        return NO;
    
    NSUInteger oldLength = [textField.text length];
    NSUInteger replacementLength = [string length];
    NSUInteger rangeLength = range.length;
    
    NSUInteger newLength = oldLength - rangeLength + replacementLength;
    
    // This 'tabs' to next field when entering digits
    if (newLength == 1) {
        if (textField == txtfirst)
        {
            [self performSelector:@selector(setNextResponder:) withObject:txtsecond afterDelay:0.2];
        }
        else if (textField == txtsecond)
        {
            [self performSelector:@selector(setNextResponder:) withObject:txtthird afterDelay:0.2];
        }
        else if (textField == txtthird)
        {

            [self performSelector:@selector(setNextResponder:) withObject:txtfourt afterDelay:0.2];
        }
    }
    //this goes to previous field as you backspace through them, so you don't have to tap into them individually
    else if (oldLength > 0 && newLength == 0) {
        if (textField == txtfourt)
        {
            [self performSelector:@selector(setNextResponder:) withObject:txtthird afterDelay:0.1];
        }
        else if (textField == txtthird)
        {
            [self performSelector:@selector(setNextResponder:) withObject:txtsecond afterDelay:0.1];
        }
        else if (textField == txtsecond)
        {
            [self performSelector:@selector(setNextResponder:) withObject:txtfirst afterDelay:0.1];
        }
    }
    
    return newLength <= 1;
}
- (void)setNextResponder:(UITextField *)nextResponder
{
    [nextResponder becomeFirstResponder];
}
/*- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField==txtfirst) {
        
        
        [txtsecond becomeFirstResponder];

        

        
        
    }
    
//     if(textField == txtfirst || textField == txtsecond || textField == txtthird || textField == txtfourt)
//     {
//        
//
//       if ((textField.text.length >= 1) && (string.length > 0))
//    {
//        
//        NSInteger nextText = textField.tag + 1;
//        // Try to find next responder
//        UIResponder* nextResponder = [textField.superview viewWithTag:nextText];
//        if (! nextResponder)
//            nextResponder = [textField.superview viewWithTag:1];
//        
//        if (nextResponder)
//            // Found next responder, so set it.
//            [nextResponder becomeFirstResponder];
//        
//        return NO;
//    }
//     }
    return YES;

    
   // NSString *newString = [NSString stringWithFormat:@"%@%@",textField.text,string];
//[textField.text stringByReplacingCharactersInRange:range withString:string];
    
//    if(textField == txtfirst)
//    {
//        if (txtfirst.text.length > 0  && range.length == 0 )
//        {
//            return NO;
//        }
//        else {
//            [txtfirst setText:newString];
//
//            [txtsecond becomeFirstResponder];
//            return YES;
//        }
//    }
//    else if(textField == txtsecond)
//    {
//        if (txtsecond.text.length > 0  && range.length == 0 )
//        {
//            return NO;
//        }else {
//            [txtsecond setText:newString];
//            [txtthird becomeFirstResponder];
//            return YES;
//        }
//    }
    return YES;
}*/
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
