#import "Pangrams.h"

@implementation Pangrams
// Complete the pangrams function below.
- (BOOL)pangrams:(NSString *)string {
    NSString *input = [string lowercaseString];
    //NSArray *input = [string componentsSeparatedByString:@""];
    //NSCharacterSet *alphabetSet = [NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyz"];
  NSArray *alphabetSet = @[@"a",@"b",@"c",@"d",@"e",@"f",@"g",@"h",@"i",@"j",@"k",@"l",@"m",@"n",@"o",@"p",@"q",@"r",@"s",@"t",@"u",@"v",@"w",@"x",@"y",@"z"];
    
    NSMutableArray *resultArray = [NSMutableArray new];
    for (NSString *symbol in alphabetSet) {
        if ([input containsString:symbol]) {
            [resultArray addObject:symbol];
        };
    };
    if (resultArray.count == 26) //26 symbols in English alphabet
    {
        return YES;
    };
    
    return NO;
}

@end
