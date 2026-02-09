*** Settings ***
Suite Setup       Open Browser To Login Page
Suite Teardown    Close Browser
Test Setup        Go To Login Page
Test Template     Login With Invalid Credentials Should Fail
Resource          resource.robot

*** Test Cases ***
#                                USER NAME           PASSWORD
Invalid Username                 invalid@up.ac.th    ${VALID PASSWORD}
Invalid Password                 ${VALID USER}       invalid_pass
Empty Username                   ${EMPTY}            ${VALID PASSWORD}
Empty Password                   ${VALID USER}       ${EMPTY}

MFA Confirmation Timeout
    [Documentation]    ทดสอบกรณีผู้ใช้ไม่กดยืนยัน MFA ภายในเวลาที่กำหนด
    [Template]    NONE
    Login With Correct Credentials But Wait For MFA Timeout    ${VALID USER}    ${VALID PASSWORD}


*** Keywords ***
Login With Invalid Credentials Should Fail
    [Arguments]    ${username}    ${password}
    Input Username    ${username}
    Run Keyword And Ignore Error    Input Password    ${password}
    Login Should Have Failed

Login With Correct Credentials But Wait For MFA Timeout
    [Arguments]    ${username}    ${password}
    Input Username    ${username}
    Input Password    ${password}

    Log To Console    ${SPACE}
    Log To Console    [WAITING] กรุณาไม่กดยืนยัน MFA... เพื่อทดสอบ Timeout
    Sleep    100s
    Reload Page
    Wait Until Page Contains    ติดต่อ    timeout=30s
    Log To Console    Detected MFA Timeout error as expected.
