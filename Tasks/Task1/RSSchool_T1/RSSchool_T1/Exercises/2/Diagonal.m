#import "Diagonal.h"

@implementation Diagonal

// Complete the diagonalDifference function below.
- (NSNumber *) diagonalDifference:(NSArray *)array {
    int sum1 = 0;
    int sum2 = 0;
    for (NSString *line in array) {
        @autoreleasepool {
        NSArray *lineArr = [line componentsSeparatedByString:@" " ];
        sum1 += [[lineArr objectAtIndex:[array indexOfObject:line]] intValue];
        sum2 += [[lineArr objectAtIndex:(lineArr.count - 1 - [array indexOfObject:line])] intValue];
    }
        
    }
    
    return @(abs(sum1 - sum2));
}

@end
