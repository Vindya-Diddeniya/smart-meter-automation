*** Settings ***
Resource    ../resources/api_keywords.robot

*** Test Cases ***
Get Users List Test
    Create API Session
    Get Users List

Get Single User Test
    Create API Session
    Get Single User

Get Resource List Test
    Create API Session
    Get Resource List
