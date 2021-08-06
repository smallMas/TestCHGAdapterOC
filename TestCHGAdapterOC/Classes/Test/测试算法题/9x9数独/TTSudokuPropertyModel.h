//
//  TTSudokuPropertyModel.h
//  TestCHGAdapterOC
//
//  Created by love on 2021/7/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TTSudokuPropertyModel : NSObject <CHGCollectionViewCellModelProtocol>
@property (strong, nonatomic) UIFont *font;
@property (assign, nonatomic) BOOL selected;
@property (strong, nonatomic, nullable) NSString *bgColor;
@property (strong, nonatomic) NSNumber *num;
@property (assign, nonatomic) CGSize size;
@property (strong, nonatomic) NSString *idf;

@property (assign, nonatomic) NSInteger factorial;
@property (strong, nonatomic) NSIndexPath *indexPath;

@end

NS_ASSUME_NONNULL_END
