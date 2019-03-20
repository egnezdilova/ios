#import "SummArray.h"

@implementation SummArray

// Complete the summArray function below.
- (NSNumber *)summArray:(NSArray *)array {
    int sum = 0;
    for (NSNumber *item in array) {
        sum += item.intValue;
    }
    
    return @(sum);
            
            }

@end
