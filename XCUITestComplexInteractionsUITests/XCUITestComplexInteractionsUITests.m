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
    [annasApp.searchFields[@"EmailField"] tap];
    [annasApp.searchFields[@"EmailField"] pressForDuration:3];
    [annasApp.menuItems[@"Paste"] tap];
    [safari terminate];
}

/*Please note that this test is applicable only for real device
 Some actions should be done before test started:
 - be sure that Wi-Fi is switched on;
 Please note that this test can get only current WiFi network*/
- (void) testGetWiFiNetwork{
    NSString *expectedWiFiName = @"HomeNet";
    XCUIApplication *generalSettings = [[XCUIApplication alloc] initWithBundleIdentifier:@"com.apple.Preferences"];
    [generalSettings activate];
    [generalSettings.staticTexts[@"Wi-Fi"] tap];
    NSArray *array = [generalSettings.staticTexts allElementsBoundByAccessibilityElement];
    XCUIElementQuery *elem = [[array objectAtIndex:1] query];
    XCTAssertTrue([elem matchingIdentifier:expectedWiFiName], "Wi-Fi is NOT the same as expected");
    
    [generalSettings terminate];
}

@end
