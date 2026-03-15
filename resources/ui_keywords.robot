*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${BROWSER}    chrome
${BASE_URL}   https://www.saucedemo.com

*** Keywords ***
Open Sauce Demo Login Page
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${options}    add_argument    --incognito
    Call Method    ${options}    add_argument    --disable-notifications
    Call Method    ${options}    add_argument    --disable-infobars
    Call Method    ${options}    add_argument    --disable-save-password-bubble
    Open Browser    ${BASE_URL}    chrome    options=${options}
    Maximize Browser Window
    Wait Until Element Is Visible    id:user-name    10s

Login To Sauce Demo
    [Arguments]    ${username}    ${password}
    Input Text    id:user-name    ${username}
    Input Text    id:password     ${password}
    Click Button  id:login-button
    Wait Until Element Is Visible    css:.inventory_list    10s

Add First Item To Cart
    Wait Until Element Is Visible    id:add-to-cart-sauce-labs-backpack    10s
    Scroll Element Into View        id:add-to-cart-sauce-labs-backpack
    Click Element                   id:add-to-cart-sauce-labs-backpack
    Capture Page Screenshot
    Wait Until Element Is Visible    id:remove-sauce-labs-backpack    10s

Open Cart
    Click Element    css:.shopping_cart_link
    Wait Until Element Is Visible    css:.cart_item    10s
    Capture Page Screenshot

Verify Cart Has Item
    Element Should Be Visible    css:.cart_item

Remove Item From Cart
    Click Element    id:remove-sauce-labs-backpack
    Capture Page Screenshot

Verify Cart Is Empty
    Page Should Not Contain Element    css:.cart_item

Close Sauce Demo Browser
    Close Browser

Capture Screenshot On Failure
    Run Keyword If Test Failed    Capture Page Screenshot