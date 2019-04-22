//
//  ViewController.m
//  RSSchool_T4
//
//  Created by Elizaveta Gnezdilova on 4/22/19.
//  Copyright © 2019 iOSLab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewController.h"

@interface ViewController() <UITextFieldDelegate>
@property(nonatomic,retain)NSString *phoneNumber;
@property(nonatomic,retain)NSDictionary *countriesDict;
@end

@implementation ViewController
@synthesize phoneNumber;
@synthesize countriesDict;

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.userInteractionEnabled = YES;
    phoneNumber = @"";
//    dictionary
    countriesDict = @{
                      @(373): @[@(8),@"MD"],
                      @(374): @[@(8),@"AM"],
                      @(375): @[@(9),@"BY"],
                      @(380): @[@(9),@"UA"],
                      @(992): @[@(9),@"TJ"],
                      @(993): @[@(8),@"TM"],
                      @(994): @[@(9),@"AZ"],
                      @(996): @[@(9),@"KG"],
                      @(998): @[@(9),@"UZ"]
                      };
    [countriesDict retain];
    //View
    UIView *view = [[UIView alloc] initWithFrame: CGRectMake(self.view.frame.origin.x+30, self.view.frame.origin.y+200, self.view.frame.size.width - 60 , 100)];
    view.userInteractionEnabled = YES;
    view.backgroundColor = [UIColor colorWithRed:0.0 green:0.8 blue:0.9 alpha:0.3];
    view.layer.cornerRadius = 15.f;

   
    
    //UI TextField
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(view.bounds.origin.x +20, view.bounds.origin.y + 20, view.bounds.size.width - 40, 50)];
    textField.tag =1;
    textField.placeholder = @"  Phone number";
    textField.textAlignment = NSTextAlignmentLeft;
    textField.textColor = [UIColor darkGrayColor];
    textField.layer.borderWidth = 1.f;
    textField.layer.borderColor = [UIColor darkGrayColor].CGColor;
    textField.layer.cornerRadius = 15.f;
    textField.keyboardType = UIKeyboardTypePhonePad;
    textField.returnKeyType = UIReturnKeySend;
    
    //UI Left view
    UIView *viewLeft = [[UIView alloc] initWithFrame:CGRectMake(textField.bounds.origin.x +3, textField.bounds.origin.y + 3, 50, textField.bounds.size.height-10)];
    viewLeft.tag = 2;
    //viewLeft.layer.contents = (id)[UIImage imageNamed:@"flag_AM"].CGImage;
    
    //Add left view to textfield
    textField.leftView = viewLeft;
    textField.leftViewMode = UITextFieldViewModeAlways;
    
//    set delegate
    textField.delegate = self;
    
      [viewLeft release];

    
    [view addSubview:textField];
    [textField release];
    
    [self.view addSubview:view];
    [view release];
    
    
}
- (void)dealloc
{
    if (phoneNumber) {
        [phoneNumber release];
    }
    [countriesDict release];
    [super dealloc];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if ( [string isEqualToString:@"+"] && (textField.text.length == 0) ){
        return YES;
    }
    if (phoneNumber.length == 12 && range.length == 0){
        return NO;
    }
    
    
    NSRegularExpression *regexStep = [[[NSRegularExpression alloc] initWithPattern: @"^[0-9]*$"
                                                                           options:0
                                                                             error:nil] autorelease];
    
    if ([regexStep numberOfMatchesInString:string options:0 range:NSMakeRange(0, [string length])] > 0) {
        
        if (range.length == 0 && (![self checkLength])){
                return NO;
        }
        if (textField.text.length>phoneNumber.length){
            range.location = range.location - (textField.text.length - phoneNumber.length);
        }
        phoneNumber = [[phoneNumber stringByReplacingCharactersInRange:range withString:string] retain];
         [self fillFlag];
        textField.text = [self formatPhone:range];
        return NO;
    }
    return NO;
}

-(void)fillFlag{
   // UITextField *textField = [self.view viewWithTag:1];
   
// get country code
    NSString *flag = nil;
    if ( (phoneNumber.length > 0) && [[phoneNumber substringToIndex:1] isEqualToString:@"7"]) {
        //KZ or RU
        
        
        if ((phoneNumber.length == 1) ||((phoneNumber.length > 1) && ![[phoneNumber substringToIndex:2] isEqualToString:@"77"]) ) {
            flag = @"flag_RU";
        }
        else if ((phoneNumber.length > 1) && [[phoneNumber substringToIndex:2] isEqualToString:@"77"]){
            flag = @"flag_KZ";
        }
    }
    else if(phoneNumber.length > 2) {
        NSString *phoneCode = [phoneNumber substringToIndex:3] ;
        flag = [NSString stringWithFormat:@"flag_%@", [countriesDict[@([phoneCode integerValue])] objectAtIndex:1]];
    }
     UIView *viewLeft = [self.view viewWithTag:2];
    if (flag) {
        viewLeft.layer.contents = (id)[UIImage imageNamed:flag].CGImage;
    }
    else if(viewLeft.layer.contents)
        {
        viewLeft.layer.contents=nil;;
        
    }
    
    
}
-(BOOL)checkLength{
    int expectedLength = 0;
    if ( (phoneNumber.length > 0) && [[phoneNumber substringToIndex:1] isEqualToString:@"7"]) {
        //KZ or RU
        expectedLength = 11;
    }
    else if(phoneNumber.length > 2) {
       NSString * phoneCode = [phoneNumber substringToIndex:3];
        expectedLength = [ [countriesDict[@([phoneCode integerValue])] objectAtIndex:0] intValue] + 3;//3-length of code
    }
    
    if (phoneNumber.length == expectedLength && expectedLength > 3) {
        return NO;
    }
    return YES;
}
-(NSString *)formatPhone:(NSRange)range{
//    8 (xx) xxx-xxx
//    9 (xx) xxx-xx-xx
//    10 (xxx) xxx xx xx
    NSString *result = nil;
    if ( (phoneNumber.length > 0) && [[phoneNumber substringToIndex:1] isEqualToString:@"7"]) {
        //KZ or RU
        NSString * phoneCode = [phoneNumber substringToIndex:1];
        result = [NSString stringWithFormat:@"+%@", phoneCode];
        
                if (phoneNumber.length<4 ) {
                    result = [result stringByAppendingFormat:@" (%@",[phoneNumber substringFromIndex:1]];
                }
                else if (phoneNumber.length<5 ) {
                    result = [result stringByAppendingFormat:@" (%@)",[phoneNumber substringFromIndex:1]];
                    
                }
                else if (phoneNumber.length<8){
                    result = [result stringByAppendingFormat:@" (%@) %@",[phoneNumber substringWithRange:NSMakeRange(1, 3)],[phoneNumber substringFromIndex:4]];
                    
                }
                else if (phoneNumber.length<10){
                    result = [result stringByAppendingFormat:@" (%@) %@ %@",[phoneNumber substringWithRange:NSMakeRange(1, 3)],[phoneNumber substringWithRange:NSMakeRange(4, 3)],[phoneNumber substringFromIndex:7]];
                }
                else{
                    result = [result stringByAppendingFormat:@" (%@) %@ %@ %@",[phoneNumber substringWithRange:NSMakeRange(1, 3)],[phoneNumber substringWithRange:NSMakeRange(4, 3)],[phoneNumber substringWithRange:NSMakeRange(7, 2)],[phoneNumber substringFromIndex:9]];
                }
        
    
    }
    else if(phoneNumber.length > 2) {
        NSString * phoneCode = [phoneNumber substringToIndex:3];
        result = [NSString stringWithFormat:@"+%@", phoneCode];
       
        switch ([[countriesDict[@([phoneCode integerValue])] objectAtIndex:0] intValue]) {
            case 8:
                if (phoneNumber.length<4 ) {
                    result = [result stringByAppendingFormat:@" (%@",[phoneNumber substringFromIndex:3]];
                }
                else if (phoneNumber.length<5 ) {
                    result = [result stringByAppendingFormat:@" (%@)",[phoneNumber substringFromIndex:3]];
                  
                }
                else if (phoneNumber.length<9){
                      result = [result stringByAppendingFormat:@" (%@) %@",[phoneNumber substringWithRange:NSMakeRange(3, 2)],[phoneNumber substringFromIndex:5]];
                   
                }
                else{
                    result = [result stringByAppendingFormat:@" (%@) %@-%@",[phoneNumber substringWithRange:NSMakeRange(3, 2)],[phoneNumber substringWithRange:NSMakeRange(5, 3)],[phoneNumber substringFromIndex:8]];
                }
                break;
                
            case 9:
                if (phoneNumber.length<4 ) {
                    result = [result stringByAppendingFormat:@" (%@",[phoneNumber substringFromIndex:3]];
                }
                else if (phoneNumber.length<5 ) {
                    result = [result stringByAppendingFormat:@" (%@)",[phoneNumber substringFromIndex:3]];
                    
                }
                else if (phoneNumber.length<9){
                    result = [result stringByAppendingFormat:@" (%@) %@",[phoneNumber substringWithRange:NSMakeRange(3, 2)],[phoneNumber substringFromIndex:5]];
                    
                }
                else if(phoneNumber.length<10){
                    result = [result stringByAppendingFormat:@" (%@) %@-%@",[phoneNumber substringWithRange:NSMakeRange(3, 2)],[phoneNumber substringWithRange:NSMakeRange(5, 3)],[phoneNumber substringFromIndex:8]];
                }
                else {
                    result = [result stringByAppendingFormat:@" (%@) %@-%@-%@",[phoneNumber substringWithRange:NSMakeRange(3, 2)],[phoneNumber substringWithRange:NSMakeRange(5, 3)],[phoneNumber substringWithRange:NSMakeRange(8, 2)],[phoneNumber substringFromIndex:10]];
                }
                break;
                
            default:
                result = [result stringByAppendingFormat:@"%@",[phoneNumber substringFromIndex:3]];
                break;
        };
    }
    else if(phoneNumber.length>0){ result = [NSString stringWithFormat:@"+%@", phoneNumber];}
   
    return result;
}
@end
