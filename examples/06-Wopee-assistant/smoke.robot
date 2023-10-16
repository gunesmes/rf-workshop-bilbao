*** Settings ***
Library             Browser

Test Setup          Open Application
Test Teardown       Close Application


*** Variables ***
${BROWSER}          headlesschrome
${URL}              https://dronjo.wopee.io/
${PSWD}             admin
${USER}             marcel.veselka@tesena.com
${WOPEE_CONFIG}     examples/06-Wopee-assistant/wopee.yaml


*** Test Cases ***
Login - correct
    Click    "Sign in"
    Fill Text    xpath=//input[@name="user"]    ${USER}
    Fill Secret    xpath=//input[@name="password"]    $PSWD

    Click    "sign in"

    Wait For Elements State    text=Log out    visible    timeout=5s

Login - incorrect
    Click    "Sign in"
    Fill Text    xpath=//input[@name="user"]    marcel.veselka@gmail.com
    Fill Secret    xpath=//input[@name="password"]    $PSWD

    Click    "sign in"

    Wait For Elements State    text=Log out    hidden    timeout=5s

Gallery page
    Click    "Gallery"

    Get Title    should start with    Gallery —
    Get Element Count    css=.gallery img    ==    3

Check out
    Click    "Buy Now"

    Fill Text    id=cardNumberFirstFour    123
    Fill Text    id=cardNumberSecondFour    456
    Fill Text    id=cardNumberThirdFour    789
    Fill Text    id=cardNumberLastFour    111

    Fill Text    id=cardHolderName    Marcel Wopee
    Fill Text    id=expirationDate    12/25
    Fill Text    id=cvc    111

    Click    "Purchase"

    Get Text    css=.confirmation    contains    Thank you for your order!


*** Keywords ***
Open Application
    New Page    ${URL}
    Set Viewport Size    1920    1080

Close Application
    Wopee check
    Close Browser

Wopee check
    Log    Wopee check
