//
//  BFBarGraphView.m

#import "BFBarGraphView.h"

@implementation BFBarGraphView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
                  }
    return self;
}


- (void)awakeFromNib {

    
    if ([self.dataArray count] == 0){
        self.dataArray = @[@50,@100,@60,@150,@70]; // for example
    }
    
    
    self.colorArray = @[@[[UIColor colorWithRed:210.0/255.0 green:0.0/255.0 blue:110.0/255.0 alpha:1.0],
                          [UIColor colorWithRed:229.0/255.0 green:88.0/255.0 blue:58.0/255.0 alpha:1.0],
                          [UIColor colorWithRed:229.0/255.0 green:143.0/255.0 blue:38.0/255.0 alpha:1.0]
                          ],
                        @[[UIColor colorWithRed:23.0/255.0 green:163.0/255.0 blue:60.0/255.0 alpha:1.0],
                          [UIColor colorWithRed:112.0/255.0 green:193.0/255.0 blue:55.0/255.0 alpha:1.0],
                          [UIColor colorWithRed:190.0/255.0 green:214.0/255.0 blue:47.0/255.0 alpha:1.0]
                          ],
                        @[[UIColor colorWithRed:35.0/255.0 green:149.0/255.0 blue:216.0/255.0 alpha:1.0],
                          [UIColor colorWithRed:25.0/255.0 green:100.0/255.0 blue:172.0/255.0 alpha:1.0],
                          [UIColor colorWithRed:31.0/255.0 green:46.0/255.0 blue:136.0/255.0 alpha:1.0]
                          ],
                        @[[UIColor colorWithRed:48.0/255.0 green:208.0/255.0 blue:212.0/255.0 alpha:1.0],
                          [UIColor colorWithRed:29.0/255.0 green:206.0/255.0 blue:181.0/255.0 alpha:1.0],
                          [UIColor colorWithRed:12.0/255.0 green:104.0/255.0 blue:244.0/255.0 alpha:1.0]
                          ],
                        @[[UIColor colorWithRed:184.0/255.0 green:22.0/255.0 blue:136.0/255.0 alpha:1.0],
                          [UIColor colorWithRed:108.0/255.0 green:48.0/255.0 blue:129.0/255.0 alpha:1.0],
                          [UIColor colorWithRed:52.0/255.0 green:51.0/255.0 blue:136.0/255.0 alpha:1.0]
                          ]];
    

}


- (void) drawBarGraph{
    
    self.clipsToBounds = YES;
    CGFloat goalLineHeightPos = .75 * self.frame.size.height;
    CGFloat kStartAnimationDelay = 0.5;
    CGFloat kTotalAnimation = 1.5;
    CGFloat numberOfColumns = [self.dataArray count];
    CGFloat kMargin = 0;
    CGFloat columnSpacing = (self.frame.size.width - (kMargin * 2))/numberOfColumns;
    CGFloat columnWidth = columnSpacing - 5;
    CGFloat kDelayBetweenAnimations = 0.04;
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:self.bounds];
    [shapeLayer setAnchorPoint:CGPointMake(0,0)];
    [shapeLayer setFillColor:[[UIColor clearColor] CGColor]];
    [shapeLayer setStrokeColor:[[UIColor lightGrayColor] CGColor]];
    [shapeLayer setLineWidth:1.0f];
    [shapeLayer setLineJoin:kCALineJoinRound];
    [shapeLayer setLineDashPattern:
    [NSArray arrayWithObjects:[NSNumber numberWithInt:3],
    [NSNumber numberWithInt:3],nil]];
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPathMoveToPoint(path, NULL, 0, self.frame.size.height -  goalLineHeightPos);
    CGPathAddLineToPoint(path, NULL, self.frame.size.width,  self.frame.size.height -  goalLineHeightPos);
    
    [shapeLayer setPath:path];
    CGPathRelease(path);
    
    int colorCntr = 0;
    
    for (int i = 0; i < numberOfColumns; i++){
        
        float dataPercentage = [self.dataArray[i] floatValue] * .01;
        float barGraphHeight = dataPercentage * goalLineHeightPos;
        
        UIView *barGraphView = [[UIView alloc] initWithFrame:CGRectMake(i*columnSpacing + kMargin,  self.frame.size.height -  barGraphHeight  ,columnWidth,  barGraphHeight)];
        
        [self setAnchorPoint:CGPointMake(0,1) forView:barGraphView];
              
         CAGradientLayer *gradient = [CAGradientLayer layer];
         gradient.frame = barGraphView.bounds;
        
        
        if (i % [self.colorArray count] == 0 ){
            colorCntr = 0;
        }
        
        
        
        NSArray *columnColorArray = self.colorArray[colorCntr];
        
        UIColor *col1 = (UIColor*) columnColorArray[0];
        UIColor *col2 = (UIColor*) columnColorArray[1];
        UIColor *col3 = (UIColor*) columnColorArray[2];
        gradient.colors = [NSArray arrayWithObjects: (id)col1.CGColor, (id)col2.CGColor, (id)col3.CGColor, nil];
        
         [barGraphView.layer insertSublayer:gradient atIndex:0];
        
        barGraphView.transform = CGAffineTransformMakeScale(1,0);
        
        [self addSubview:barGraphView];
        
        [UIView animateWithDuration:kTotalAnimation/numberOfColumns delay:(kDelayBetweenAnimations * i) + kStartAnimationDelay options:UIViewAnimationOptionCurveEaseOut animations:^{
            barGraphView.transform = CGAffineTransformIdentity;
            [self layoutIfNeeded];
        } completion:^(BOOL finished) {
        }];
        
        colorCntr++;
        
    }
    
    [[self layer] addSublayer:shapeLayer];
    
    
}



-(void)setAnchorPoint:(CGPoint)anchorPoint forView:(UIView *)view
{
    CGPoint newPoint = CGPointMake(view.bounds.size.width * anchorPoint.x, view.bounds.size.height * anchorPoint.y);
    CGPoint oldPoint = CGPointMake(view.bounds.size.width * view.layer.anchorPoint.x, view.bounds.size.height * view.layer.anchorPoint.y);
    newPoint = CGPointApplyAffineTransform(newPoint, view.transform);
    oldPoint = CGPointApplyAffineTransform(oldPoint, view.transform);
    CGPoint position = view.layer.position;
    position.x -= oldPoint.x;
    position.x += newPoint.x;
    position.y -= oldPoint.y;
    position.y += newPoint.y;
    view.layer.position = position;
    view.layer.anchorPoint = anchorPoint;
}




@end
