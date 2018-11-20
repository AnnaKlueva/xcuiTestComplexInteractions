//
//  XCUITestComplexInteractionsUITests.m
//  XCUITestComplexInteractionsUITests
//
//  Created by Anna Kliuieva on 11/13/18.
//  Copyright © 2018 Anna Kliuieva. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface XCUITestComplexInteractionsUITests : XCTestCase

@end

@implementation XCUITestComplexInteractionsUITests

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    [[[XCUIApplication alloc] init] launch];
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

/*Please note that this test is applicable for real device and for simulator*/
- (void)testCopyFromUrlAndPasteToEmail {
    XCUIApplication *safari = [[XCUIApplication alloc] initWithBundleIdentifier:@"com.apple.mobilesafari"];
    [safari activate];
    
    XCUIElement *urlField = safari.buttons[@"URL"];
    [urlField tap];
    
    [safari.keys[@"q"] tap];
    [safari.keys[@"w"] tap];
    [safari.keys[@"e"] tap];
    [safari.keys[@"r"] tap];
    [safari.buttons[@"Go"] tap];
    [urlField pressForDuration:3];
    [safari.menuItems[@"Copy"] tap];
    XCUIApplication *annasApp = [[XCUIApplication alloc] initWithBundleIdentifier:@"anna.kliuieva.XCUITestComplexInteractions"];
    [annasApp activate];
    NSLog(annasApp.debugDescription);
    [annasApp.searchFields[@"EmailField"] tap];
    [annasApp.searchFields[@"EmailField"] pressForDuration:3];
    [annasApp.menuItems[@"Paste"] tap];
}

/*Please note that this test is applicable only for real device*/
- (void)testSetNewPasscode {
    XCUIApplication *generalSettings = [[XCUIApplication alloc] initWithBundleIdentifier:@"com.apple.Preferences"];
    [generalSettings activate];
    [generalSettings.staticTexts[@"Touch ID & Passcode"] tap];
    [generalSettings.keys[@"2"] tap];
    [generalSettings.keys[@"4"] tap];
    [generalSettings.keys[@"1"] tap];
    [generalSettings.keys[@"1"] tap];
    [generalSettings.keys[@"6"] tap];
    [generalSettings.keys[@"7"] tap];
    
    [generalSettings.staticTexts[@"Change Passcode"] tap];
    [generalSettings.keys[@"2"] tap];
    [generalSettings.keys[@"4"] tap];
    [generalSettings.keys[@"1"] tap];
    [generalSettings.keys[@"1"] tap];
    [generalSettings.keys[@"6"] tap];
    [generalSettings.keys[@"7"] tap];
    
    //enter new password
    [generalSettings.keys[@"2"] tap];
    [generalSettings.keys[@"4"] tap];
    [generalSettings.keys[@"1"] tap];
    [generalSettings.keys[@"1"] tap];
    [generalSettings.keys[@"6"] tap];
    [generalSettings.keys[@"8"] tap];
    //confirm new password
    [generalSettings.keys[@"2"] tap];
    [generalSettings.keys[@"4"] tap];
    [generalSettings.keys[@"1"] tap];
    [generalSettings.keys[@"1"] tap];
    [generalSettings.keys[@"6"] tap];
    [generalSettings.keys[@"8"] tap];
}

/*Please note that this test is applicable only for real device*/
- (void) testRemovePasscode {
    //Turn Passcode Off
    XCUIApplication *generalSettings = [[XCUIApplication alloc] initWithBundleIdentifier:@"com.apple.Preferences"];
    [generalSettings activate];
    //TODO: add scroll
    [generalSettings.staticTexts[@"Touch ID & Passcode"] tap];
    [generalSettings.keys[@"2"] tap];
    [generalSettings.keys[@"4"] tap];
    [generalSettings.keys[@"1"] tap];
    [generalSettings.keys[@"1"] tap];
    [generalSettings.keys[@"6"] tap];
    [generalSettings.keys[@"7"] tap];
    
    [generalSettings.staticTexts[@"Turn Passcode Off"] tap];
    [generalSettings.keys[@"2"] tap];
    [generalSettings.keys[@"4"] tap];
    [generalSettings.keys[@"1"] tap];
    [generalSettings.keys[@"1"] tap];
    [generalSettings.keys[@"6"] tap];
    [generalSettings.keys[@"7"] tap];
    //TODO: add assert
}

/*Please note that this test is applicable only for real device*/
- (void) testGetWiFiNetwork{
    XCUIApplication *generalSettings = [[XCUIApplication alloc] initWithBundleIdentifier:@"com.apple.Preferences"];
    [generalSettings activate];
    [generalSettings.staticTexts[@"Wi-Fi"] tap];
    NSArray *array = [generalSettings.staticTexts allElementsBoundByAccessibilityElement];
    XCUIElementQuery *elem = [[array objectAtIndex:1] query];
    BOOL result = [elem matchingIdentifier:@"HomeNet"];
}

@end
