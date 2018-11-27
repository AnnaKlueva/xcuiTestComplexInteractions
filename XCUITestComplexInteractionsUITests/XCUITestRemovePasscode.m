//
//  XCUITestRemovePasscode.m
//  XCUITestComplexInteractionsUITests
//
//  Created by Anna Kliuieva on 11/26/18.
//  Copyright © 2018 Anna Kliuieva. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface XCUITestRemovePasscode : XCTestCase
#define newPasscode @[@"2",@"4",@"1",@"1",@"6",@"8"]
#define oldPasscode @[@"2",@"4",@"1",@"1",@"6",@"7"]
@end

@implementation XCUITestRemovePasscode

-(void) setUp {
    XCUIApplication *generalSettings = [[XCUIApplication alloc] initWithBundleIdentifier:@"com.apple.Preferences"];
    [generalSettings activate];
    [generalSettings.staticTexts[@"Touch ID & Passcode"] tap];
    
    XCUIElement *turnPasscodeOnButton = generalSettings.staticTexts[@"Turn Passcode On"];
    if(turnPasscodeOnButton.exists){
        [turnPasscodeOnButton tap];
        [XCUITestRemovePasscode enterPasscode:generalSettings withValue: oldPasscode];
        sleep(1);
        [XCUITestRemovePasscode enterPasscode:generalSettings withValue: oldPasscode];
        sleep(5);
    }
    [generalSettings terminate];
}

-(void)tearDown {
    XCUIApplication *generalSettings = [[XCUIApplication alloc] initWithBundleIdentifier:@"com.apple.Preferences"];
    [generalSettings activate];
    [generalSettings.staticTexts[@"Touch ID & Passcode"] tap];
    
    if(!generalSettings.staticTexts[@"Turn Passcode On"].isEnabled){
        [generalSettings.staticTexts[@"Turn Passcode Off"] tap];
        [XCUITestRemovePasscode enterPasscode:generalSettings withValue: oldPasscode];
        sleep(3);
    }
    [generalSettings terminate];
}

/*Please note that this test is applicable only for real device*/
- (void) testRemovePasscode {
    //Turn Passcode Off
    XCUIApplication *generalSettings = [[XCUIApplication alloc] initWithBundleIdentifier:@"com.apple.Preferences"];
    [generalSettings activate];
    //TODO: add scroll
    [generalSettings.staticTexts[@"Touch ID & Passcode"] tap];
    //Go to passcode settings, if user has passcode
    [XCUITestRemovePasscode enterPasscode:generalSettings withValue: oldPasscode];
    sleep(1);
    
    //Go to 'Turn passcode off' view
    [generalSettings.staticTexts[@"Turn Passcode Off"] tap];
    [XCUITestRemovePasscode enterPasscode:generalSettings withValue: oldPasscode];
    sleep(1);
    
    //Verify if passcode was switched off
    XCUIElement *value = generalSettings.staticTexts[@"Turn Passcode On"];
    XCTAssertTrue(value.isEnabled, "Button 'Turn passcode on' button is not displayed");
    [generalSettings terminate];
}

+ (void) enterPasscode: (XCUIApplication *) app withValue: (NSArray *) passcode {
    for(int i = 0; i < [passcode count]; i++){
        [app.keys[(NSString *)[passcode objectAtIndex:i]] tap];
    }
}

@end
