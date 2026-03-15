*** Settings ***
Library      SeleniumLibrary
Resource     ../resources/ui_keywords.robot
Test Teardown    Capture Screenshot On Failure

*** Variables ***
@{USERS}
...    standard_user    secret_sauce
...    problem_user     secret_sauce
...    performance_glitch_user    secret_sauce

*** Test Cases ***
Login And Cart Actions For Multiple Users
    FOR    ${username}    ${password}    IN    @{USERS}
        Log To Console    \nRunning test for ${username}
        Open Sauce Demo Login Page
        Login To Sauce Demo    ${username}    ${password}
        Add First Item To Cart
        Open Cart
        Verify Cart Has Item
        Remove Item From Cart
        Verify Cart Is Empty
        Close Sauce Demo Browser
    END
