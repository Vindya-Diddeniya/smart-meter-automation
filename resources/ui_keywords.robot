*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${BROWSER}        chrome
${BASE_URL}       https://www.saucedemo.com
${DEFAULT_ITEM}   sauce-labs-backpack

*** Keywords ***
Open Sauce Demo Login Page
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    # Standard options
    Call Method    ${options}    add_argument    --incognito
    Call Method    ${options}    add_argument    --disable-notifications
    Call Method    ${options}    add_argument    --disable-infobars
    Call Method    ${options}    add_argument    --disable-save-password-bubble
    # Headless / CI options
    Call Method    ${options}    add_argument    --headless
    Call Method    ${options}    add_argument    --no-sandbox
    Call Method    ${options}    add_argument    --disable-dev-shm-usage
    Open Browser    ${BASE_URL}    ${BROWSER}    options=${options}
    Maximize Browser Window
    Wait Until Element Is Visible    id:user-name    10s

Login To Sauce Demo
    [Arguments]    ${username}    ${password}
    Input Text    id:user-name    ${username}
    Input Text    id:password     ${password}
    Click Button  id:login-button
    Wait Until Page Contains Element    css:.inventory_list    10s

Add Item To Cart
    [Arguments]    ${item_id}
    Wait Until Element Is Visible    id:add-to-cart-${item_id}    10s
    Scroll Element Into View        id:add-to-cart-${item_id}
    Click Element                   id:add-to-cart-${item_id}
    Capture Page Screenshot
    Wait Until Element Is Visible    id:remove-${item_id}    10s

Add First Item To Cart
    Add Item To Cart    ${DEFAULT_ITEM}

Open Cart
    Click Element    css:.shopping_cart_link
    Wait Until Element Is Visible    css:.cart_item    10s
    Capture Page Screenshot

Verify Cart Has Item
    Element Should Be Visible    css:.cart_item

Remove Item From Cart
    [Arguments]    ${item_id}
    Click Element    id:remove-${item_id}
    Capture Page Screenshot

Remove First Item From Cart
    Remove Item From Cart    ${DEFAULT_ITEM}

Verify Cart Is Empty
    Page Should Not Contain Element    css:.cart_item

Close Sauce Demo Browser
    Close All Browsers

Capture Screenshot On Failure
    Run Keyword If Test Failed    Capture Page Screenshot