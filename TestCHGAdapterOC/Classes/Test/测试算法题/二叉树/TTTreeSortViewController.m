//
//  TTTreeSortViewController.m
//  TestCHGAdapterOC
//
//  Created by 燕来秋 on 2021/1/27.
//

#import "TTTreeSortViewController.h"
#import "TTTreeModel.h"
#import "TTTreeSortUtility.h"

@interface TTTreeSortViewController ()

@end

@implementation TTTreeSortViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    /*
     二叉树：
             4
           /   \
          2     7
         / \   / \
        1  3  6   9
     */

    TTTreeModel *one = [TTTreeModel createTreeValue:4];
    one.left = [TTTreeModel createTreeValue:2];
    one.right = [TTTreeModel createTreeValue:7];
    
    TTTreeModel *two = one.left;
    two.left = [TTTreeModel createTreeValue:1];
    two.right = [TTTreeModel createTreeValue:3];
    
    TTTreeModel *twoR = one.right;
    twoR.left = [TTTreeModel createTreeValue:6];
    twoR.right = [TTTreeModel createTreeValue:9];
    
    if (self.queModel) {
        switch (self.queModel.type) {
            case TTTreeTypeBeforeSort:
                NSLog(@"前序排列 : %@",[TTTreeSortUtility beforeSort:one]);
                break;
                
            case TTTreeTypeCenterSort:
                NSLog(@"中序排列 : %@",[TTTreeSortUtility centerSort:one]);
                break;
            
            case TTTreeTypeAfterSort:
                NSLog(@"后序排列 : %@",[TTTreeSortUtility afterSort:one]);
                break;
                
            case TTTreeTypeUpDownLeftRight:
                NSLog(@"自上而下排列 : %@",[TTTreeSortUtility updownSort:one]);
                break;
                
            case TTTreeTypeDownUpLeftRight:
                NSLog(@"自下而上排列 : %@",[TTTreeSortUtility downupSort:one]);
                break;
                
            default:
                break;
        }
    }
}

@end
