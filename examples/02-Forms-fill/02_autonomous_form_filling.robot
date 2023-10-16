*** Settings ***
Library     Collections
Library     Browser
Library     RequestsLibrary
Resource    ../../resources/ai.robot


*** Variables ***
${URL}      %{URL=https://dronjo.wopee.io/sign-in.html}


*** Test Cases ***
Filling form bot
    Set Browser Timeout    30s
    # New Browser    chromium    headless=false
    # New Context    viewport={'width': 1920, 'height': 1080}
    # New Page    ${URL LOGIN}
    Open Browser    ${URL}    chromium    headless=True

    Autonomous Form Filling
    Take Screenshot    fullPage=True
    Close Browser
