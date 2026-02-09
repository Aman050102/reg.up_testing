*** Settings ***
Resource          resource.robot

*** Test Cases ***
Valid Login Scenario
    Open Browser To Login Page
    Submit Credentials
    Input Username          ${VALID USER}
    Input Password          ${VALID PASSWORD}
    Submit Email                                 
    Welcome Page Should Be Open
    [Teardown]    Close Browser
