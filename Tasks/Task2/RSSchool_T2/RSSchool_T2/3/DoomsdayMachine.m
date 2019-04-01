#import "DoomsdayMachine.h"

@interface AnyDayInfoClass : NSObject <AssimilationInfo>

@property (nonatomic, readwrite) NSInteger days;
@property (nonatomic, readwrite) NSInteger years;
@property (nonatomic, readwrite) NSInteger months;
@property (nonatomic, readwrite) NSInteger hours;
@property (nonatomic, readwrite) NSInteger minutes;
@property (nonatomic, readwrite) NSInteger seconds;
-(instancetype)initWithDate:(NSString *)dateString;
-(instancetype)initWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minutes:(NSInteger)minute seconds:(NSInteger)second;
@end

@implementation AnyDayInfoClass

@synthesize days;
@synthesize hours;
@synthesize minutes;
@synthesize months;
@synthesize seconds;
@synthesize weeks;
@synthesize years;

- (instancetype)initWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minutes:(NSInteger)minute seconds:(NSInteger)second{
    self = [super init];
    if (self) {
        years = year;
        months = month;
        days = day;
        hours = hour;
        minutes = minute;
        seconds = second;
    }
    return self;
}

- (instancetype)initWithDate:(NSString *)dateString{
    self = [super init];
    if (self) {
    years = [[dateString substringWithRange:NSMakeRange(0, 4)] integerValue];
    months= [[dateString substringWithRange:NSMakeRange(6, 2)] integerValue];
    days = [[dateString substringWithRange:NSMakeRange(9, 2)] integerValue];
    hours = [[dateString substringWithRange:NSMakeRange(18, 2)] integerValue];
    minutes= [[dateString substringWithRange:NSMakeRange(15, 2)] integerValue];
    seconds= [[dateString substringWithRange:NSMakeRange(12, 2)] integerValue];
    }
    
    return self;
}
- (void)dealloc
{
    years = 0;
    months = 0;
    days = 0;
    hours = 0;
    minutes = 0;
    seconds = 0;
    [super dealloc];
}
@end

@interface DoomsdayMachine () {
    NSString *doomsdayString;
    NSString *doomsday;
    id <AssimilationInfo> doomsday_info; //14 August 2208 03:13:37
}
@end
    
@implementation DoomsdayMachine
- (instancetype)init
{
    self = [super init];
    if (self) {
        doomsdayString = @"Sunday, August 14, 2208";
        doomsday =  @"2208:08:14@37\\13/03";
        doomsday_info = [[AnyDayInfoClass alloc] initWithDate:doomsdayString];
        
    }
    return self;
}
- (void)dealloc
{
    doomsday = nil;
    doomsdayString = nil;
    [doomsday_info release];
    [super dealloc];
}
- (NSString *)doomsdayString{
    return doomsdayString;
}
- (id<AssimilationInfo>)assimilationInfoForCurrentDateString:(NSString *)dateString{
    
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy:MM:dd@ss\\mm/HH"];
    NSDate *startDate = [formatter dateFromString:dateString];
    NSDate *endDate = [formatter dateFromString:doomsday];
    
    
    NSCalendar *calendar = [[[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian] autorelease];
    
    NSDateComponents *components = [calendar components:( NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond )
                                                        fromDate:startDate
                                                        toDate:endDate
                                                         options:0];
    
   id <AssimilationInfo> resultInfo = [[[AnyDayInfoClass alloc] initWithYear:[components year] month:[components month] day:[components day] hour:[components hour] minutes:[components minute] seconds:[components second]] autorelease];

    return resultInfo;
}
@end
