*** Settings ***
Suite Setup       Open Browser To Login Page
Suite Teardown    Close Browser
Test Setup        Go To Login Page
Test Template     Login With Invalid Credentials Should Fail
Resource          resource.robot

*** Test Cases ***               USER NAME           PASSWORD
Invalid Username                 invalid@up.ac.th    ${VALID PASSWORD}
Invalid Password                 ${VALID USER}       invalid_pass
Invalid Username And Password    invalid@up.ac.th    whatever
Empty Username                   ${EMPTY}            ${VALID PASSWORD}
Empty Password                   ${VALID USER}       ${EMPTY}
Empty Username And Password      ${EMPTY}            ${EMPTY}

*** Keywords ***
Login With Invalid Credentials Should Fail
    [Arguments]    ${username}    ${password}
    Input Username    ${username}
    Run Keyword And Ignore Error    Input Password    ${password}
    Login Should Have Failed

Login Should Have Failed
    Wait Until Page Contains Element    xpath://div[@id='usernameError' or @id='passwordError' or contains(@class, 'error')]    timeout=7s
    Log To Console    Detected login error as expected.
