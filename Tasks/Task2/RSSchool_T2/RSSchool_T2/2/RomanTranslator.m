#import "RomanTranslator.h"
@interface RomanTranslator (){
    NSDictionary *romanArabic;
    NSArray* onesArray ;
    NSArray* tensArray ;
    NSArray* hundredsArray ;
}


@end

@implementation RomanTranslator
- (instancetype)init
{
    self = [super init];
    if (self) {
       romanArabic = [NSDictionary dictionaryWithObjectsAndKeys: @"1", @"I",
                                     @"5", @"V",
                                     @"10",@"X",
                                     @"50",@"L",
                                     @"100", @"C",
                                     @"500", @"D",
                                     @"1000",@"M",nil
                                     ];
        onesArray = @[@"I", @"II", @"III", @"IV", @"V", @"VI", @"VII", @"VIII", @"IX"];
       tensArray = @[@"X", @"XX", @"XXX", @"XL", @"L", @"LX", @"LXX", @"LXXX", @"XC"];
         hundredsArray = @[@"C", @"CC", @"CCC", @"CD", @"D", @"DC", @"DCC", @"DCCC", @"CM"];
        
    }
    return self;
}

- (void)dealloc
{
    [romanArabic release];
    [onesArray release];
    [tensArray release];
    [hundredsArray release];
    self=nil;
    [super dealloc];
}

- (NSString *)romanFromArabic:(NSString *)arabicString{
   
    int num = (int)[arabicString integerValue];
    int ones = num %10;
    int tens = ((num-ones)/10) %10;
    int hundreds = ((num-tens-ones)/100) %10;
    int thousands = (num -hundreds-tens -ones)/1000;
    
//    "collect result
    NSMutableString *result = [[NSMutableString new] autorelease];
//    thousands
    for (int i = 0; i < thousands; i++) {
       [result appendString:@"M"];
    }
//    hundreds
    if (hundreds >= 1) {
        [result appendString:[hundredsArray objectAtIndex:(hundreds -1)]];
    }
    
    //tens
    if (tens >= 1) {
        [result appendString:[tensArray objectAtIndex:(tens-1)]];
    }
    
//    ones
    if (ones >= 1) {
        [result appendString:[onesArray objectAtIndex:(ones-1)]];
    }


    return result;
}

- (NSString *)arabicFromRoman:(NSString *)romanString{
    
    
    int resultInt = 0;
    int prev_digit = 0;
    for (int i=0; i < romanString.length; i++) {
        NSString *romanSymbol = [[romanString substringWithRange:NSMakeRange(i, 1)] autorelease];
        int arabicFromRoman =  (int)[romanArabic[romanSymbol] integerValue];
        if ((prev_digit <arabicFromRoman)&&(prev_digit!=0)) {
            arabicFromRoman -= prev_digit;
            resultInt -= prev_digit;
            resultInt += arabicFromRoman;
            prev_digit = arabicFromRoman;
        } else {
            prev_digit = arabicFromRoman;
            resultInt += arabicFromRoman;
        }

        }
    return [[NSString stringWithFormat:@"%d",resultInt] autorelease];
}
@end
