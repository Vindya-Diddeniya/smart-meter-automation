*** Settings ***
Library     RequestsLibrary
Library     SeleniumLibrary

*** Variables ***
${BASE_URL}     https://reqres.in
${API_KEY}      reqres_49137685aceb4f4bba7bed2aa87f06fe
${SAUCE_URL}    https://www.saucedemo.com

*** Test Cases ***
API Data Used In UI Test

    # API call
    Create Session    reqres    ${BASE_URL}    headers={"x-api-key": "${API_KEY}"}
    ${response}=    GET On Session    reqres    url=/api/users/2
    Status Should Be    200    ${response}

    ${first_name}=    Set Variable    ${response.json()}[data][first_name]

    Log    API returned user: ${first_name}

    # UI test
    Open Browser    ${SAUCE_URL}    chrome
    Input Text    id:user-name    standard_user
    Input Text    id:password     secret_sauce
    Click Button  id:login-button

    Wait Until Page Contains Element    css:.inventory_list

    Log    Using API data in UI test: ${first_name}

    Close Browser