*** Settings ***
Library               SeleniumLibrary
Library               Dialogs
Library               Collections

Suite Setup           Login For GPA Testing
Suite Teardown        Close Browser
Test Setup            Navigate To Grade Calculation

*** Variables ***
${SERVER}             reg.up.ac.th
${BROWSER}            chrome
${DELAY}              0
${VALID USER}         67023086@up.ac.th
${VALID PASSWORD}     Aman0945785806*
${WELCOME URL}        https://${SERVER}/

# XPath Locators
${BTN_MAIN_MENU}      xpath://button[contains(@class, 'navbar-toggle')] | /html/body/header/div[1]/div[2]/div[3]/div/button
${BTN_ENTER_REG}      xpath://a[contains(text(), 'เข้าสู่ระบบระบบบริการการศึกษา')] | /html/body/header/div[1]/div[2]/div[3]/div/div/div/div[2]/a[1]
${BTN_STAY_SIGNED_IN}  id:idSIButton9
${BTN_CALCULATE}      xpath://span[contains(text(), 'คำนวณเกรด')]

*** Keywords ***
Login For GPA Testing
    Open Browser      ${WELCOME URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Speed    ${DELAY}

    # 1. คลิกปุ่มเมนูก่อนเข้าหน้า main
    Wait Until Element Is Visible    ${BTN_MAIN_MENU}    20s
    Click Element    ${BTN_MAIN_MENU}

    # 2. คลิกปุ่ม Login สีเขียว
    Wait Until Element Is Visible    xpath://*[@id="current"]/div/div[2]/a    15s
    Click Element    xpath://*[@id="current"]/div/div[2]/a

    # 3. Microsoft Login (Username)
    Wait Until Element Is Visible    id:i0116    30s
    Input Text     id:i0116    ${VALID USER}
    Click Button   id:idSIButton9

    # 4. Microsoft Login (Password)
    Wait Until Element Is Visible    id:i0118    20s
    Input Text     id:i0118    ${VALID PASSWORD}
    Sleep    1s
    Execute Javascript    document.querySelector('#idSIButton9').click()

    # 5. ยืนยัน MFA
    Wait Until Page Contains    อนุมัติ    timeout=30s
    Pause Execution    กรุณายืนยัน MFA ในมือถือให้เรียบร้อย แล้วค่อยกลับมากด OK ตรงนี้

    # 6. กดปุ่ม "ใช่" ในหน้า Stay signed in?
    Wait Until Element Is Visible    ${BTN_STAY_SIGNED_IN}    20s
    Click Element    ${BTN_STAY_SIGNED_IN}

    # 7. กลับเข้าสู่ระบบมหาวิทยาลัย
    Wait Until Location Contains    ${SERVER}    timeout=30s
    Sleep    2s

    ${status}    Run Keyword And Return Status    Wait Until Element Is Visible    ${BTN_ENTER_REG}    15s
    IF    ${status}
        Execute Javascript    document.evaluate("${BTN_ENTER_REG.replace('xpath:', '')}", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.click();
    ELSE
        Go To    https://${SERVER}/app/main
    END

    Set Screenshot Directory    ${CURDIR}/results/screenshots

Navigate To Grade Calculation
    Go To    https://${SERVER}/app/main
    Wait Until Element Is Visible    xpath://*[@id="box-topmenu"]/ul/li[4]/a/b    20s
    Click Element    xpath://*[@id="box-topmenu"]/ul/li[4]/a/b
    Wait Until Element Is Visible    xpath://*[@id="box-topmenu"]/ul/li[4]/ul/li[3]/a/b    15s
    Click Element    xpath://*[@id="box-topmenu"]/ul/li[4]/ul/li[3]/a/b
    Wait Until Element Is Visible    xpath://*[@id="1"]/td[6]/select    15s

Input Multiple Grades
    [Arguments]    @{grades}
    ${index}=    Set Variable    1
    FOR    ${grade}    IN    @{grades}
        # ตรวจสอบก่อนว่าแถวนั้นมีอยู่จริงหรือไม่ป้องกัน Error ถ้าเทอมนั้นวิชาน้อยกว่าที่ใส่
        ${row_status}    Run Keyword And Return Status    Element Should Be Visible    xpath://*[@id="${index}"]/td[6]/select
        Exit For Loop If    '${row_status}' == 'False'

        Select From List By Value    xpath://*[@id="${index}"]/td[6]/select    ${grade}
        ${index}=    Evaluate    ${index} + 1
    END
    Scroll Element Into View    ${BTN_CALCULATE}
    Sleep    1s
    Execute Javascript    document.evaluate("${BTN_CALCULATE.replace('xpath:', '')}", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.click();
    Sleep    2s

*** Test Cases ***
TC-01: Maximum GPA (All A)
    [Documentation]    ตรวจสอบกรณีได้เกรด A ทุกวิชา GPA ต้องเป็น 4.00
    Input Multiple Grades    A    A    A    A    A    A    A
    Wait Until Page Contains    4.00    10s
    Capture Page Screenshot    all-a.png

TC-02: Mixed Grades (A, B, C)
    [Documentation]    ทดสอบเกรดคละกันเพื่อดูการคำนวณค่าเฉลี่ย
    Input Multiple Grades    A    B+    B    C+    C    D+    D
    # ค่า GPA จะเปลี่ยนไปตามหน่วยกิตวิชาจริงในหน้านั้น ให้ Capture มาเช็คความถูกต้อง
    Capture Page Screenshot    mixed-grades.png

TC-03: Minimum GPA (All F)
    [Documentation]    ตรวจสอบกรณีติด F ทุกวิชา GPA ต้องเป็น 0.00
    Input Multiple Grades    F    F    F    F    F    F    F
    Wait Until Page Contains    0.00    10s
    Capture Page Screenshot    all-f.png

TC-04: Verify Information Matching
    [Documentation]    เช็คว่ารหัสนิสิตที่แสดงในหน้าคำนวณตรงกับ Login หรือไม่
    Page Should Contain    67023086
    Log To Console    Student ID Verified.
