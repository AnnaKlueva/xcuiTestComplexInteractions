//
//  XCUITestPasscodeTest.m
//  XCUITestComplexInteractionsUITests
//
//  Created by Anna Kliuieva on 11/26/18.
//  Copyright © 2018 Anna Kliuieva. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface XCUITestPasscodeTest : XCTestCase
#define newPasscode @[@"2",@"4",@"1",@"1",@"6",@"8"]
#define oldPasscode @[@"2",@"4",@"1",@"1",@"6",@"7"]
@end

@implementation XCUITestPasscodeTest

-(void) setUp {
    XCUIApplication *generalSettings = [[XCUIApplication alloc] initWithBundleIdentifier:@"com.apple.Preferences"];
    [generalSettings activate];
    [generalSettings.staticTexts[@"Touch ID & Passcode"] tap];
    
    XCUIElement *turnPasscodeOnButton = generalSettings.staticTexts[@"Turn Passcode On"];
    if(turnPasscodeOnButton.exists){
        [turnPasscodeOnButton tap];
        [XCUITestPasscodeTest enterPasscode:generalSettings withValue: oldPasscode];
        sleep(1);
        [XCUITestPasscodeTest enterPasscode:generalSettings withValue: oldPasscode];
        sleep(10);//not working
    }
    [generalSettings terminate];
}

/*Please note that this test is applicable only for real device*/
- (void)testChangePasscode {
    XCUIApplication *generalSettings = [[XCUIApplication alloc] initWithBundleIdentifier:@"com.apple.Preferences"];
    [generalSettings activate];
    [generalSettings.staticTexts[@"Touch ID & Passcode"] tap];
    
    //Go to passcode settings, if user has passcode
    [XCUITestPasscodeTest enterPasscode:generalSettings withValue: oldPasscode];
    
    //Go to 'Change passcode' view
    [generalSettings.staticTexts[@"Change Passcode"] tap];
    [XCUITestPasscodeTest enterPasscode:generalSettings withValue: oldPasscode];
    
    //enter new password
    [XCUITestPasscodeTest enterPasscode:generalSettings withValue: newPasscode];
    //confirm new password
    //add waiter
    sleep(1);
    [XCUITestPasscodeTest enterPasscode:generalSettings withValue: newPasscode];
    sleep(5);
    [generalSettings terminate];
}

-(void)tearDown {
    XCUIApplication *generalSettings = [[XCUIApplication alloc] initWithBundleIdentifier:@"com.apple.Preferences"];
    [generalSettings activate];
    [generalSettings.staticTexts[@"Touch ID & Passcode"] tap];
    
    [XCUITestPasscodeTest enterPasscode:generalSettings withValue: newPasscode];
    XCUIElement *turnPasscodeOffButton = generalSettings.staticTexts[@"Turn Passcode Off"];
    [turnPasscodeOffButton tap];
    [XCUITestPasscodeTest enterPasscode:generalSettings withValue: newPasscode];
    sleep(5);
    [generalSettings terminate];
}

+ (void) enterPasscode: (XCUIApplication *) app withValue: (NSArray *) passcode {
    for(int i = 0; i < [passcode count]; i++){
        [app.keys[(NSString *)[passcode objectAtIndex:i]] tap];
    }
}

@end
