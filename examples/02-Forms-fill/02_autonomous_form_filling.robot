*** Settings ***
Library     Collections
Library     Browser
Library     RequestsLibrary
Resource    ../../resources/ai.robot


*** Variables ***
${URL}      %{URL=https://dronjo.wopee.io/sign-in.html}


*** Test Cases ***
Filling form bot
    &{recordVideo}    Create Dictionary    dir=${OUTPUT DIR}/videos
    Set Browser Timeout    30s
    New Browser    chromium    headless=True
    New Context
    ...    recordVideo=${recordVideo}
    ...    tracing=${OUTPUT DIR}/trace.zip
    ...    viewport={'width': 1920, 'height': 1080}
    New Page    ${URL}

    Start progress loader
    Autonomous Form Filling
    Take Screenshot    fullPage=True
    Close Browser
