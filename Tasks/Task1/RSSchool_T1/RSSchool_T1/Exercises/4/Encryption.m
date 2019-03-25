#import "Encryption.h"

@implementation Encryption

// Complete the encryption function below.
- (NSString *)encryption:(NSString *)string {
   //convert string to array without spaces
    NSMutableArray *input = [NSMutableArray new];
    for (int i=0; i < string.length; i++) {
    NSString *tmp_str = [[string substringWithRange:NSMakeRange(i, 1)] autorelease];
        if (![tmp_str isEqualToString:@" "]) {
        [input addObject:tmp_str];
        }
    }
    
    //number of columns
    int maxColumnsNum = ceilf(sqrt(input.count));
    
    //create array for encryption
    int row = 0;
    int column = 0;
    NSMutableArray *encryptionArray = [ NSMutableArray new];
     for (NSString *symbol in input) {
        if (column == maxColumnsNum) {
            row ++;
            column = 0;
        }
         if (column == 0){[encryptionArray addObject:[NSMutableArray new]];}
        [ [encryptionArray  objectAtIndex:row] addObject:symbol];
        column ++;
    }
    
    [input release];
//create encryption string
    NSMutableString *resultString = [NSMutableString stringWithString:string];
    [resultString deleteCharactersInRange:NSMakeRange(0, string.length)];
    for (column = 0; column < maxColumnsNum; column ++) {
    for (row = 0; row < encryptionArray.count ; row++) {
        if (column < [[encryptionArray objectAtIndex:row] count]) {
         [resultString  appendString:[[encryptionArray objectAtIndex:row] objectAtIndex:column]];
        }
                      }
        [resultString  appendString:@" "];
    }
    [encryptionArray release];
    //delete last space
   [resultString deleteCharactersInRange:NSMakeRange((resultString.length-1),1)];
    return resultString;
}

@end
