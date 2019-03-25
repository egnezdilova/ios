#import "Sorted.h"

@implementation ResultObject
- (void)dealloc
{
    self.status = nil;
    [self.detail release];
    self = nil;
    [super dealloc];
}
@end

@implementation Sorted

// Complete the sorted function below.
- (ResultObject*)sorted:(NSString*)string {
    ResultObject *resultValue = [[ResultObject new] autorelease];
  
    NSArray *input = [string componentsSeparatedByString:@" "];
    
//    NSArray *input=@[@(1),@(2),@(3),@(15),@(11),@(16),@(14),@(18)];


    
    for (int i=0; i<[input count] -1 ; i++) {
        if ([[input objectAtIndex:(i+1)] intValue]<[[input objectAtIndex:i] intValue]){
         //first unsorted element
           NSArray* firstPart = [input subarrayWithRange: NSMakeRange( 0, i )]; //store first sorted part
            NSArray* arrPart=[input subarrayWithRange: NSMakeRange( i, [input count] - i)];//store another part of input array
            
//                   swap
            if ( [self isSwaped:arrPart withFirstPart:firstPart andResult:resultValue]  == NO) {
//             othervise-reverse
                [self isReversed:arrPart withFirstPart:firstPart andResult:resultValue];
            } ;
            break;
        }
    }
    
    
    return resultValue;
}

-(BOOL)isSorted:(NSArray *)array{
    //check sorted array
    for (int i=0; i<[array count] - 1; i++) {
        if ([[array objectAtIndex:(i+1)] intValue]<[[array objectAtIndex:i] intValue]){
            return NO;
        }
    }
    return YES;
}

-(BOOL)isReversed:(NSArray *)array withFirstPart:(NSArray *)firstPart andResult:(ResultObject *)result{
    
    NSMutableArray *stayedPart = [NSMutableArray new];
    NSMutableArray *need2reverce = [NSMutableArray new];
    
    for( int j=0; j<[array count] -1; j++){
        //check if sorted descending
        if ([[array objectAtIndex:(j+1)] intValue] > [[array objectAtIndex:(j)] intValue]){
          
            stayedPart = [array subarrayWithRange: NSMakeRange( j+1, [array count] - j-1)];
            need2reverce = [array subarrayWithRange: NSMakeRange(0, j+1)];
            result.detail = [NSString stringWithFormat:@"reverse %lu %d",(unsigned long)[firstPart count]+1,j+2];
            break;
        }
    }
    
    NSArray *reversed = [[need2reverce reverseObjectEnumerator] allObjects];
    NSArray* finalArr = [[firstPart arrayByAddingObjectsFromArray:reversed] arrayByAddingObjectsFromArray:stayedPart];
    
    result.status = [self isSorted:finalArr];
   
    return result.status;
}
-(BOOL)isSwaped:(NSArray *)array withFirstPart:(NSArray *)firstPart andResult:(ResultObject *)result{
    
    NSMutableArray *middlePart = [NSMutableArray new];
    NSMutableArray *stayedPart = [NSMutableArray new];
    NSMutableArray *need2swap = [NSMutableArray new];
  //skip first element
    for( int j=1; j<[array count] -1; j++){
        //find second unsorted
        if ([[array objectAtIndex:(j+1)] intValue] < [[array objectAtIndex:(j)] intValue]){
           middlePart = [array subarrayWithRange: NSMakeRange( 1, j)];
            stayedPart = [array subarrayWithRange: NSMakeRange( j+2, [array count] - j - 2)];
            need2swap = [array subarrayWithRange: NSMakeRange(j+1, 1)];
            result.detail = [NSString stringWithFormat:@"swap %lu %d",(unsigned long)[firstPart count] +1,(unsigned long)[firstPart count] + j+2];
            break;
        }
    }
    
    NSMutableArray* finalArr = [NSMutableArray new];
    [finalArr addObjectsFromArray:firstPart];
    if ([need2swap count] == 0) {
        //try to swap nex element
        [finalArr addObject:[array objectAtIndex:1]];
        [finalArr addObject:[array objectAtIndex:0]];
         result.detail = [NSString stringWithFormat:@"swap %lu %d",(unsigned long)[firstPart count] +1,(unsigned long)[firstPart count] + 2];
        if (array.count > 2) {
            [finalArr addObjectsFromArray:[array subarrayWithRange:NSMakeRange(2,[array count]-2)]];
        }
          }
    else{
        
        [finalArr addObjectsFromArray:need2swap];
        [finalArr addObjectsFromArray:middlePart];
        [finalArr addObject:[array objectAtIndex:0]];
        [finalArr addObjectsFromArray:stayedPart];
    }
    
    if ([finalArr count] == [firstPart count]+[array count]) {
        result.status = [self isSorted:finalArr];
    }
    else{
        result.status = NO;
    }
    
    return result.status;
    
}


@end
