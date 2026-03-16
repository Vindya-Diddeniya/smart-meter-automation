*** Settings ***
Library      SeleniumLibrary
Resource     ../resources/ui_keywords.robot
Test Teardown    Capture Screenshot On Failure

*** Test Cases ***

Login And Add Item To Cart
    Open Sauce Demo Login Page
    Login To Sauce Demo    standard_user    secret_sauce
    Add First Item To Cart
    Open Cart
    Verify Cart Has Item
    [Teardown]    Close Sauce Demo Browser

Login Add And Remove Item From Cart
    Open Sauce Demo Login Page
    Login To Sauce Demo    standard_user    secret_sauce
    Add First Item To Cart
    Open Cart
    Remove First Item From Cart
    Verify Cart Is Empty
    [Teardown]    Close Sauce Demo Browser