#import "MatrixHacker.h"
@interface MatrixHacker ()
@property (nonatomic, copy) id<Character> (^code)(NSString *name);
@end

@implementation MatrixHacker
- (void)injectCode:(id<Character> (^)(NSString *))theBlock {
  self.code = theBlock;
}

- (NSArray<id<Character>> *)runCodeWithData:(NSArray<NSString *> *)names {
  NSMutableArray *result = [NSMutableArray new];
  for (NSString *name in names) {
    id newChar = self.code(name);
    [result addObject:newChar];
  }
  return result.copy;
}

@end
