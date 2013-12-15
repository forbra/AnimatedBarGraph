//
//  BFViewController.m
//  AnimateBarGraph

#import "BFExampleViewController.h"

@interface BFExampleViewController ()

@end

@implementation BFExampleViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    //STEP 1: Insert BFBarGraphView
    
    //STEP 2:
    self.barGraphView.dataArray = @[@10,@20,@30,@40,@50,@60,@170,@80,@10,@20];
    
    
    // OPTIONAL STEP IF YOU DON'T LIKE THE DEFAULT COLORS:
//    self.barGraphView.colorArray = @[@[[UIColor colorWithRed:210.0/255.0 green:0.0/255.0 blue:110.0/255.0 alpha:1.0],
//                          [UIColor colorWithRed:129.0/255.0 green:88.0/255.0 blue:58.0/255.0 alpha:1.0],
//                          [UIColor colorWithRed:129.0/255.0 green:143.0/255.0 blue:38.0/255.0 alpha:1.0]
//                          ],
//                        @[[UIColor colorWithRed:13.0/255.0 green:163.0/255.0 blue:60.0/255.0 alpha:1.0],
//                          [UIColor colorWithRed:112.0/255.0 green:193.0/255.0 blue:55.0/255.0 alpha:1.0],
//                          [UIColor colorWithRed:190.0/255.0 green:214.0/255.0 blue:47.0/255.0 alpha:1.0]
//                          ],
//                        @[[UIColor colorWithRed:15.0/255.0 green:149.0/255.0 blue:216.0/255.0 alpha:1.0],
//                          [UIColor colorWithRed:25.0/255.0 green:100.0/255.0 blue:172.0/255.0 alpha:1.0],
//                          [UIColor colorWithRed:31.0/255.0 green:46.0/255.0 blue:136.0/255.0 alpha:1.0]
//                          ]];

    
    //STEP 3:
    [self.barGraphView drawBarGraph];


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
