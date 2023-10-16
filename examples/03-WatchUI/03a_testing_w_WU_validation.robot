*** Settings ***
Library         Collections
Library         Browser
Library         WatchUI    outputs_folder=${IMAGES_STORAGE}/outputs
Library         OperatingSystem
Resource        ../../resources/common.robot

Test Setup      Start test


*** Variables ***
${BROWSER}              chromium
${URL}                  https://dronjo.wopee.io

${IMAGES_STORAGE}       ${OUTPUTDIR}/wui_images
${HEADLESS}             True


*** Test Cases ***
Checkout Test
    Click    text=Buy Now >> nth=0
    Checks visual

Login Test
    Click    text=Sign In >> nth=0
    Checks visual

Contact Test
    Click    text=Contact >> nth=0
    Checks visual

Gallery Test
    Click    text=Gallery >> nth=0
    Checks visual

Gallery Test - wo. areas
    Click    text=Gallery >> nth=0
    Checks visual wo areas


*** Keywords ***
Checks visual
    ${page_url}=    Get Url
    ${screen_id}=    Convert URL to Unique String    url=${page_url}
    ${actual screen file}=    Set Variable    ${IMAGES_STORAGE}/${screen_id}.png

    Sleep    3s
    Take Screenshot
    ...    filename=${actual screen file}
    ...    fullPage=True
    ...    disableAnimations=True
    ...    timeout=1s
    Compare Images    ${actual screen file}    baselines/${screen_id}.png

Checks visual wo areas
    ${page_url}=    Get Url
    ${screen_id}=    Convert URL to Unique String    url=${page_url}
    ${actual screen file}=    Set Variable    ${IMAGES_STORAGE}/${screen_id}-wo.png

    Sleep    3s
    Take Screenshot
    ...    filename=${actual screen file}
    ...    fullPage=True
    ...    disableAnimations=True
    ...    timeout=1s
    Compare screen without areas    ${actual screen file}    baselines/${screen_id}.png    600    240    1350    1000

Start test
    New Browser    chromium    headless=${HEADLESS}
    New Context    viewport={'width': 1920, 'height': 1080}
    New Page    ${URL}
