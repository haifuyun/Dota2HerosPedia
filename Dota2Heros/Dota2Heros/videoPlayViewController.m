//
//  videoPlayViewController.m
//  
//
//  Created by HFY on 16/2/15.
//
//

#import "videoPlayViewController.h"
#import "XYPlayerController.h"

@interface videoPlayViewController ()<UITextViewDelegate>
@property (nonatomic, strong) XYPlayerController *videoController;

@end

@implementation videoPlayViewController

 - (void)viewDidLoad
{
    [super viewDidLoad];
    [self setVideoDetailView];
    [self setVideoPlayerUrl];

}

 - (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
}

 - (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.videoController pause];

    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
}

 - (void)setVideoDetailView
{
    UIView *detailView = [[UIView alloc]init];
    detailView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:detailView];
    
    CGFloat deatailViewX = 0;
    CGFloat deatailViewY = [UIScreen mainScreen].bounds.size.width*(9.0/16.0) + 20;
    CGFloat deatailViewWidth = self.view.frame.size.width;
    CGFloat deatailViewHeight = self.view.frame.size.height - deatailViewY;
    NSLog(@"deatailViewHeight %f",deatailViewHeight);
    NSLog(@"screenHeight %f",[UIScreen mainScreen].bounds.size.height);

    
    detailView.frame = CGRectMake(deatailViewX, deatailViewY, deatailViewWidth, deatailViewHeight);
    UITextView *textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, detailView.frame.size.width, detailView.frame.size.height)];

    textView.backgroundColor = [UIColor whiteColor];
    [detailView addSubview:textView];
    textView.font = [UIFont fontWithName:@"Arial" size:18];
    textView.text = @"测试！！！！！";
    textView.allowsEditingTextAttributes = NO;
    textView.scrollEnabled = YES;
    textView.selectedRange = NSMakeRange(textView.text.length, 0);
    textView.editable = NO;
}

 - (void)setVideoPlayerUrl
{
//    NSURL *videoURL = [[NSBundle mainBundle]URLForResource:@"150511_JiveBike" withExtension:@"mov"];
    NSURL *videoURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@",self.videoUrl]];

    [self playVideoWithURL:videoURL];
}


 - (void)viewDidDisappear:(BOOL)animated
{
    [self.videoController stop];
    [self.videoController cancelObserver];
    self.videoController = nil;
    
}

 - (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

 - (void)playVideoWithURL:(NSURL *)url
{
    if (!self.videoController) {
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        self.videoController = [[XYPlayerController alloc] initWithFrame:CGRectMake(0, 20, width, width*(9.0/16.0))];
        
        __weak typeof(self)weakSelf = self;
        
        [self.videoController settingTVId:[NSString stringWithFormat:@"%@",self.tvID]
                                    Title:[NSString stringWithFormat:@"%@",self.tittle]
                                   Detail:[NSString stringWithFormat:@"%@",self.detail]
                             access_token:@"123"
                               coverImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",self.imageName]]];
        
        NSLog(@"%@",self.tittle);
        [self.videoController setDimissCompleteBlock:^{
            weakSelf.videoController = nil;
        }];
        
        
        [self.view addSubview:self.videoController.view];
        
     }
    self.videoController.contentURL = url;
}

@end
