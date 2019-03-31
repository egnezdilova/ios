#import "KidnapperNote.h"

@implementation KidnapperNote
-(BOOL)checkMagazine:(NSString *)magaine note:(NSString *)note{
    NSArray *input_note = [[note lowercaseString] componentsSeparatedByString:@" "];
    NSCountedSet *input_magazine = [[[ NSCountedSet alloc] initWithArray:[[magaine lowercaseString] componentsSeparatedByString:@" "] ] autorelease];
    for (NSString *word in input_note) {
        if (!([input_magazine countForObject:word]==0)) {
            [input_magazine removeObject:word];
        }
        else{return NO;}
    }
    return YES;
}
@end
