//
//  Node.m
//  RSSchool_T3
//
//  Created by Elizaveta Gnezdilova on 4/14/19.
//  Copyright © 2019 Alexander Shalamov. All rights reserved.
//

#import "Node.h"

@interface Node()

@end

@implementation Node

- (instancetype)initWithValue:(NSObject *)value
{
    self = [super init];
    if (self) {
        _value = value;
        
    }
    return self;
}

-(Node *)cloneNode{
    Node* newNode = [[[Node alloc] initWithValue:_value] autorelease];
    if (![_left_leaf.value isEqual:[NSNull null]] ) {
        newNode.left_leaf = [_left_leaf cloneNode];
    }
    if (![_right_leaf.value isEqual:[NSNull null]] ) {
        newNode.right_leaf = [_right_leaf cloneNode];
    }
    return newNode;
}
@end
