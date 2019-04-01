#import "MatrixHacker.h"
@interface Character : NSObject <Character>
@property (nonatomic,readwrite,getter=isClone) BOOL clone;
@property (nonatomic,retain,getter=name) NSString* name;
-(instancetype)initWithName:(NSString *)name isClone:(BOOL)clone;
@end
@implementation Character
+ (instancetype)createWithName:(NSString *)name isClone:(BOOL)clone {
    return [[[ self alloc] initWithName:name isClone:clone] retain];
}
- (instancetype)initWithName:(NSString *)name isClone:(BOOL)clone{
    self = [super init];
    if (self) {
        _name = name;
        _clone = clone;
    }
    return self;
}
- (BOOL)isClone {
    return _clone;
}

- (NSString *)name {
    return _name;
}
- (void)dealloc
{
    _clone = nil;
    [_name release];
    [super dealloc];
}
@end

@interface MatrixHacker ()
    @property (nonatomic,copy) id <Character> (^injectedCode)(NSString *);
@end

@implementation MatrixHacker
- (void)injectCode:(id<Character> (^)(NSString *))theBlock{
    self.injectedCode = theBlock;
}
- (NSArray<id<Character>> *)runCodeWithData:(NSArray<NSString *> *)names{
    
    NSMutableArray *resultPersons = [[NSMutableArray new] autorelease];
    
 [names   enumerateObjectsUsingBlock:^ (NSString* obj, NSUInteger idx, BOOL *stop) {
                 id <Character> agentSmith = [ self.injectedCode(obj) autorelease];
     
                if ([obj isEqualToString: @"Neo"]) {
                        [resultPersons addObject:[Character createWithName:obj isClone:NO]];
                    }
                else{
                         // agentSmith.name = @"Agent Smith";
                         // agentSmith.isClone = YES;
                         //[resultPersons addObject:agentSmith];
                         [resultPersons addObject:agentSmith];
                    }
 }];
    
    return resultPersons;
}
- (void)dealloc
{
    [_injectedCode release];
    [super dealloc];
}
@end
