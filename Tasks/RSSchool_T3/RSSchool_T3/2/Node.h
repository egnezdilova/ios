//
//  Node.h
//  RSSchool_T3
//
//  Created by Elizaveta Gnezdilova on 4/14/19.
//  Copyright © 2019 Alexander Shalamov. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Node : NSObject

@property(nonatomic,retain) NSObject* value;
@property(nonatomic,retain) Node* left_leaf;
@property(nonatomic,retain) Node* right_leaf;

-(instancetype)initWithValue:(NSObject*) value;
-(Node* )cloneNode;

@end
