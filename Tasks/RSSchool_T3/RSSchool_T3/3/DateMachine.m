#import "DateMachine.h"





@interface DateMachine() <UITextFieldDelegate>
@property (retain, nonatomic) IBOutlet UITextField *startDate;
@property (retain, nonatomic) IBOutlet UITextField *step;
@property (retain, nonatomic) IBOutlet UITextField *unit;

@property (retain, nonatomic) IBOutlet UILabel *timeResult;
@end

@implementation DateMachine
@synthesize unit;
@synthesize step;
@synthesize startDate;
@synthesize timeResult;


NSDateFormatter *dateFormatter;

- (void)viewDidLoad {
    [super viewDidLoad];
    step.delegate = self;
    unit.delegate=self;
    startDate.delegate = self;
    startDate.clearsOnBeginEditing = YES;
    // US English Locale (en_US) 20/04/2004 12:00
  //  dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy HH:mm"]; // set template after setting locale

    startDate.text = [dateFormatter stringFromDate:[NSDate date]];//[NSString stringWithFormat:@"%@",currentDate];
    timeResult.text = startDate.text;
    
}
- (void)dealloc {
    [startDate release];
    [step release];
    [unit release];
    [timeResult release];
    [dateFormatter release];
    [super dealloc];
}
- (IBAction)add2start:(id)sender {
    
    startDate.text = [dateFormatter stringFromDate:[self getCalculatedDate:[step.text integerValue]]];
   timeResult.text = startDate.text;
}

- (IBAction)subFromStart:(id)sender {
    startDate.text = [dateFormatter stringFromDate: [self getCalculatedDate:(0 - [step.text integerValue])] ];
     timeResult.text = startDate.text;
}
- (NSDate*) getCalculatedDate:(NSUInteger) stepInt {
    NSArray* unitSource = @[@"year", @"month", @"week", @"day", @"hour", @"minute"];
    NSDateComponents *dateComponents = [NSDateComponents new];
    NSUInteger selectedUnit = [unitSource indexOfObject:unit.text];
 NSDate *currentDate = [dateFormatter dateFromString:startDate.text];
    //    UIAlertController *alert = [[UIAlertController alloc] tit
    //    [alert show];
    //    [alert release];
    
    
    
    switch (selectedUnit) {
        case 0:
            dateComponents.year = stepInt;
            break;
        case 1:
            dateComponents.month = stepInt;
            break;
        case 2:
            dateComponents.day = stepInt * 7;
            break;
        case 3:
            dateComponents.day = stepInt;
            break;
        case 4:
            dateComponents.hour = stepInt;
            break;
        case 5:
            dateComponents.minute = stepInt;
            break;
        default:
            break;
    };
    NSDate *newDate = [[[NSCalendar currentCalendar] dateByAddingComponents:dateComponents
                                                                     toDate: currentDate
                                                                    options:0] autorelease];
    [dateComponents release];
    [currentDate release];
    return newDate;
};

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSString *pattern = nil;
    if ([step isEqual:textField]) {
        pattern = @"^[0-9]*$";
    }
    else if([unit isEqual:textField]){
        pattern = @"^[a-z,A-Z]*$";
    }
    else if ([startDate isEqual:textField]){
        timeResult.text = [textField.text stringByAppendingString:string];
        return YES;
    }
    NSRegularExpression *regexStep = [[[NSRegularExpression alloc] initWithPattern: pattern
                                                                          options:0
                                                                            error:nil] autorelease];
    if ([regexStep numberOfMatchesInString:string options:0 range:NSMakeRange(0, [string length])] > 0) {
        return YES;
    }
    return NO;
}
@end
