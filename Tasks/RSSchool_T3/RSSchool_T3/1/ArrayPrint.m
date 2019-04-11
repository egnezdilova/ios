#import "ArrayPrint.h"
#define CASE(str)                       if ([__s__ isEqualToString:(str)])
#define SWITCH(s)                       for (NSString *__s__ = (s); ; )
#define DEFAULT

@implementation NSArray(RSSchool_Extension_Name)

- (NSString *)print{
    NSMutableString* result = [[NSMutableString new] autorelease];
 
    //open brackets
    [result appendString:@"["];
    
    //proceed elements
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *className = [NSString stringWithFormat:@"%@",[[obj classForCoder] autorelease]];
        if (idx != 0) {//separate elements
             [result appendString:@","];
        }
        SWITCH(className) {
            CASE(@"NSArray"){
                [result appendString:[obj print]];
                break;
            }
            CASE(@"NSNumber"){
                [result appendString:[obj stringValue]];
                break;
            }
            CASE(@"NSNull"){
                [result appendString:@"null"];
                break;
            }
            CASE(@"NSString"){
                [result appendString:@"\""]; // \"
                [result appendString: obj];
                [result appendString:@"\""];//  \"
                break;
            }
            DEFAULT{
                 [result appendString: @"unsupported"];
                break;
            }
        }
    }];
    
//end of array- close bracket
    [result appendString:@"]"];

    return result;
}

@end
