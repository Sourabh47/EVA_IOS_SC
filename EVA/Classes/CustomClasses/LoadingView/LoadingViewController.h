//
//  LoadingViewController.h
// //

#import <UIKit/UIKit.h>
/**
 *	@Class: LoadingViewController
 *	@Description: LoadingViewController class use for implement loading indicator on request start and stop.
 */
@interface LoadingViewController : UIViewController {
    IBOutlet UIActivityIndicatorView *spinner;
}
@property (weak, nonatomic) IBOutlet UILabel *lblDownloading;

+(LoadingViewController *) instance;
-(IBAction)startRotationonview:(UIView*)vieww;

/**
 * use for start rotaing activity indicator
 * @param: nil
 * @return: IBAction
 */
-(IBAction)startRotation;

/**
 * use for start rotaing activity indicator
 * @param: nil
 * @return: void
 */
-(void)stopRotation;
@end
