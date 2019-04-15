#import "FullBinaryTrees.h"
#import "Node.h"

@implementation FullBinaryTrees

- (NSString *)stringForNodeCount:(NSInteger)count{
    NSMutableString *printedTrees = [[NSMutableString new] autorelease];
    
    [printedTrees appendString:@"["];
    
        for (Node* tree in [self getTreesWithCountNodes:count fromAllVariants:[[self createAllTrees:count] lastObject]]) {
            [printedTrees appendString:@"["];
            [printedTrees appendString:[self printTree:tree]];
            [printedTrees appendString:@"]"];
        } ;
    
    [printedTrees appendString:@"]"];
  
    NSRegularExpression *regex = [[[NSRegularExpression alloc] initWithPattern: @"[\\(\\)]"
                                                                           options:0
                                                                             error:nil] autorelease];
    
    
    
    return [regex stringByReplacingMatchesInString:printedTrees options:0 range:NSMakeRange(0, [printedTrees length]) withTemplate:@""];
}

-(NSArray*)createAllTrees:(NSInteger)count{
//    check if it is feasible;
    if (!(count % 2)){ return @[@[]];}
    
    
    NSMutableArray* allTrees = [NSMutableArray new];
    [allTrees addObject:[NSMutableArray arrayWithObject:[ [Node alloc] initWithValue:@(0)] ] ];
    if (count == 1) {
        return allTrees;
    }
    
    Node* fullNode = [[Node alloc] initWithValue:@(0)];
    fullNode.left_leaf=[[Node alloc] initWithValue:@(0)];
    fullNode.right_leaf=[[Node alloc] initWithValue:@(0)];
    
    [allTrees addObject:[NSMutableArray arrayWithObject:fullNode]];
   
    if (count == 3) {
        return allTrees;
    }
    
    
    for (int i = 3 ; i < count; i+=2) {
        NSMutableArray* level = [NSMutableArray new];
        
            for (Node* node in [allTrees lastObject]) {
                NSArray* left = [self fillPosLevesForNode: [node left_leaf]];
                NSArray* right = [self fillPosLevesForNode: [node right_leaf]] ;
                [level addObjectsFromArray:[self generateAllCombinationsWithLeft:left Right:right]];
            }
        
        [allTrees addObject:level];
        
    }
    return allTrees;
}
-(NSMutableArray *) generateAllCombinationsWithLeft:(NSArray*)left Right:(NSArray*)right{
    NSMutableArray *nodeList = [[NSMutableArray new] autorelease];
    for (Node* leaf_left in left) {
        for (Node* leaf_right in right) {
            Node* node = [[[Node alloc] initWithValue:@(0)] autorelease];
            node.left_leaf = [leaf_left cloneNode];
            node.right_leaf = [leaf_right cloneNode];
            [nodeList addObject:node];
        }
    }
    return nodeList;
}
-(NSArray*)fillPosLevesForNode:(Node*)node{
    NSMutableArray *leves = [[NSMutableArray new] autorelease];
    if (node.left_leaf) {
        NSArray* left = [self fillPosLevesForNode: [node left_leaf]];
        NSArray* right = [self fillPosLevesForNode: [node right_leaf]];
       [leves addObjectsFromArray:[self generateAllCombinationsWithLeft:left Right:right]];
    }
    else{
    Node* fullNode = [[[Node alloc] initWithValue:@(0)] autorelease];
    fullNode.left_leaf=[[Node alloc] initWithValue:@(0)];
    fullNode.right_leaf=[[Node alloc] initWithValue:@(0)];
    
   [ leves addObjectsFromArray: @[fullNode,[[Node alloc] initWithValue:@(0)]]];
    }
    return leves;
}
-(NSArray*)getTreesWithCountNodes:(NSInteger)count fromAllVariants:(NSArray*)allTrees{
    NSMutableArray *result = [[NSMutableArray new] autorelease];
    for (Node* tree in allTrees) {
        if ([self getNumberOfLevesInTree:tree] == count) {
            [result addObject:tree];
        }
    }
    return result;
}
-(NSInteger)getNumberOfLevesInTree:(Node*)tree{
    NSInteger result=0;
    if (tree.left_leaf) {
      result+= [self getNumberOfLevesInTree:tree.left_leaf];
      result+= [self getNumberOfLevesInTree:tree.right_leaf];
    }
    
    return ++result;
}
-(NSString *)printTree:(Node *)tree{
    //something goes wrong with printing functionality
    NSMutableString *result = [[NSMutableString new] autorelease];
//firs level
    [result appendFormat:@"%@", tree.value];
    //second level
    if (tree.left_leaf) {
        [result appendFormat:@",%@,%@", tree.left_leaf.value, tree.right_leaf.value];
    }
    //third level
    if (tree.left_leaf.left_leaf||tree.right_leaf.left_leaf) {
        [result appendFormat:@",%@,%@", tree.left_leaf.left_leaf.value,tree.left_leaf.right_leaf.value] ;
        if (tree.right_leaf.left_leaf) {
            [result appendFormat:@",%@,%@", tree.right_leaf.left_leaf.value,tree.right_leaf.left_leaf.value];
            
            }
          }
   
    return result;
}
@end
