//
//  LoadingViewController.m
//  Editure
//
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LoadingViewController.h"

@implementation LoadingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        [spinner setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
        //CGPoint point=[[[appDelegate tabBarController] navigationController]view].center;
       // self.view.frame=CGRectMake(point.x-50, point.y-50, 120, 120);
        // self.view.center=point;

       //  self.view.frame=CGRectMake(450, 300, 120, 120);

        
       // [[appDelegate window].rootViewController.view addSubview:self.view];
      // [[[[appDelegate tabBarController] navigationController]view]addSubview:self.view];

    }
    return self;
}

+(LoadingViewController *) instance
{
	static LoadingViewController *instance;
	@synchronized (self)
	{
		if( !instance){
			//instance = [[ LoadingViewController alloc] initWithNibName:LOADING_VIEW_CONTROLLER bundle:nil];
            
            UIStoryboard *newStoryBoard;
            newStoryBoard = [UIStoryboard storyboardWithName:StoryBoard_IPad bundle:nil];
            instance =[newStoryBoard instantiateViewControllerWithIdentifier:@"LOADING_VIEW_CONTROLLER"];
		}
	}
	return instance;
}

-(void)stopRotation
{
    [[[[appDelegate tabBarController] navigationController]view]setUserInteractionEnabled:YES];
	[self.view setHidden:YES];
    [[[[appDelegate tabBarController] navigationController]view]sendSubviewToBack:self.view];
}
-(IBAction)startRotationonview:(UIView*)vieww
{
//    [[[[appDelegate tabBarController] navigationController]view]setUserInteractionEnabled:NO];
//	[[[[appDelegate tabBarController] navigationController]view]bringSubviewToFront:self.view];

    
    self.view.center = [[appDelegate window]center];
    
    [[appDelegate window] addSubview:self.view];
    
    [vieww addSubview:self.view];
    self.view.center=vieww.center;
    [self.view setHidden:NO];
    

    
    //    [[appDelegate window].rootViewController.view addSubview:self.view];
    //    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    

    
    
    
}
-(IBAction)startRotation
{
    [[[[appDelegate tabBarController] navigationController]view]setUserInteractionEnabled:NO];
	[[[[appDelegate tabBarController] navigationController]view]bringSubviewToFront:self.view];
    self.view.center=[appDelegate tabBarController] .view.center;
    [self.view setHidden:NO];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setLblDownloading:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
