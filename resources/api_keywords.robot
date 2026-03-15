*** Settings ***
Library    RequestsLibrary

*** Variables ***
${BASE_URL}    https://reqres.in
${API_KEY}     reqres_49137685aceb4f4bba7bed2aa87f06fe
${HEADERS}     {"x-api-key": "${API_KEY}", "User-Agent": "RobotFramework API Test"}

*** Keywords ***
Create API Session
    Create Session    demo    ${BASE_URL}    headers=${HEADERS}    verify=False

Get Users List
    ${response}=    GET On Session    demo    /api/users    params=page=2
    Status Should Be    200    ${response}

Get Single User
    ${response}=    GET On Session    demo    /api/users/2
    Status Should Be    200    ${response}

Get Resource List
    ${response}=    GET On Session    demo    /api/unknown
    Status Should Be    200    ${response}
