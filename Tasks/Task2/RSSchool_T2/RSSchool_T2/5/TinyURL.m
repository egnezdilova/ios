#import "TinyURL.h"
@interface TinyURL ()
    @property (nonatomic,retain,readonly)NSURL* baseURL;
    @property (nonatomic,retain)NSMutableDictionary* urls;
@end

@implementation TinyURL

@synthesize baseURL;
@synthesize urls;

- (instancetype)init
{
    self = [super init];
    if (self) {
        baseURL = [ [NSURL alloc] initWithString:@"https://egnezdilova/"];
        urls = [[ NSMutableDictionary alloc] init];
    }
    return self;
}
- (void)dealloc
{
    [baseURL release];
    [urls release];
    [super dealloc];
}
- (NSURL *)encode:(NSURL *)originalURL{
    NSString* newURL = [[[NSString alloc] initWithFormat:@"%d%lu",arc4random(),[urls count]] autorelease];
    [urls setObject:originalURL forKey:newURL];
    return [NSURL URLWithString:newURL relativeToURL:baseURL];
}

- (NSURL *)decode:(NSURL *)shortenedURL{
    return urls[[shortenedURL.pathComponents objectAtIndex:1]];
}

@end
