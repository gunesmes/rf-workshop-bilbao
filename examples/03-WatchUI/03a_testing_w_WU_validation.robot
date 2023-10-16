*** Settings ***
Library         Collections
Library         Browser
Library         WatchUI    outputs_folder=${IMAGES_STORAGE}/comparisons
Library         OperatingSystem
Resource        ../../resources/common.robot

Test Setup      Start test


*** Variables ***
${BROWSER}              chromium
${URL}                  https://dronjo.wopee.io

${IMAGES_STORAGE}       ${OUTPUTDIR}/wui_images
${HEADLESS}             True

# equal `ci` when running in CI
${CI}                   %{CI=}/


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

Contact Test - wo. areas
    Click    text=Contact >> nth=0
    Checks visual wo areas    800    300    1550    900

Gallery Test
    Click    text=Gallery >> nth=0
    Checks visual

Gallery Test - wo. areas
    Click    text=Gallery >> nth=0
    Checks visual wo areas    600    240    1350    1000


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
    Compare Images    ${actual screen file}    baselines/${CI}${screen_id}.png    ssim=0.99

Checks visual wo areas
    [Arguments]    ${x1}    ${y1}    ${x2}    ${y2}
    ${page_url}=    Get Url
    ${screen_id}=    Convert URL to Unique String    url=${page_url}
    ${actual screen file}=    Set Variable    ${IMAGES_STORAGE}/${screen_id}-wo.png

    Sleep    3s
    Take Screenshot
    ...    filename=${actual screen file}
    ...    fullPage=True
    ...    disableAnimations=True
    ...    timeout=1s
    Compare screen without areas
    ...    ${actual screen file}
    ...    baselines/${CI}${screen_id}.png
    ...    ${x1}
    ...    ${y1}
    ...    ${x2}
    ...    ${y2}

Start test
    New Browser    chromium    headless=${HEADLESS}
    New Context    viewport={'width': 1920, 'height': 1080}
    New Page    ${URL}
