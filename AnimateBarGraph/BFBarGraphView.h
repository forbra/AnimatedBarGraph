//
//  BFBarGraphView.h

/* To Use: 1) Insert BFBarGraphView in your .xib  2) overide dataArray with percentage values  3) call drawBarGraph   Optionally you can override the color array also.   Dashed line is 100%.  Graph is clipped to bounds so it does not draw outside of the bounds of the view;
 
*/



#import <UIKit/UIKit.h>

@interface BFBarGraphView : UIView

@property (strong, nonatomic) NSArray  *dataArray;
@property (strong, nonatomic) NSArray  *colorArray;


- (void) drawBarGraph;

@end
