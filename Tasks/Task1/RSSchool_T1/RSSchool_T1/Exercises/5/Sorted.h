#import <Foundation/Foundation.h>

@interface ResultObject : NSObject
@property (nonatomic, retain) NSString *detail;
@property (nonatomic, assign) BOOL status;
@end

@interface Sorted : NSObject
- (ResultObject*)sorted:(NSString*)string;
- (BOOL) isReversed:(NSArray *)array withFirstPart:(NSArray *)firstPart andResult:(ResultObject *)result;
- (BOOL) isSwaped:(NSArray *)array withFirstPart:(NSArray *)firstPart andResult:(ResultObject *)result;
- (BOOL) isSorted:(NSArray *)array;
@end
