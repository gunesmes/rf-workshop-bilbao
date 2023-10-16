*** Settings ***
Library         Collections
Library         Browser
Library         WatchUI    outputs_folder=${IMAGES_STORAGE}/comparisons
Library         OperatingSystem
Resource        ../../resources/common.robot

Test Setup      Start test


*** Variables ***
${BROWSER}                          chromium
${URL}                              https://dronjo.wopee.io

${IMAGES_STORAGE}                   ${OUTPUTDIR}/wui_images
${HEADLESS}                         True

# equal `ci` when running in CI
${CI}                               %{CI=}/

${ERR_COUNT}                        0
${WARN_COUNT}                       0

${MAX_DEPTH_TO_CRAWL}               3
${MAX_NUMBER_OF_PAGE_TO_CRAWL}      %{TESTS=5}


*** Test Cases ***
Crawl a website
    ${crawling_result}=
    ...    Crawl Site    ${URL}    page_crawl_keyword=Check Visual
    ...    max_depth_to_crawl=${MAX_DEPTH_TO_CRAWL}
    ...    max_number_of_page_to_crawl=${MAX_NUMBER_OF_PAGE_TO_CRAWL}
    Get Summary Results    ${ERR_COUNT}    ${WARN_COUNT}    ${MAX_NUMBER_OF_PAGE_TO_CRAWL}



*** Keywords ***
Check Visual
    ${page_url}=    Get Url
    ${screen_id}=    Convert URL to Unique String    url=${page_url}
    ${actual screen file}=    Set Variable    ${IMAGES_STORAGE}/${screen_id}.png

    Sleep    3s
    Take Screenshot
    ...    filename=${actual screen file}
    ...    fullPage=True
    ...    disableAnimations=True
    ...    timeout=1s
    Wopee Check

 Wopee Check
    ${page_url}=    Get Url
    ${screen_id}=    Convert URL to Unique String    url=${page_url}
    ${actual screen file}=    Set Variable    ${IMAGES_STORAGE}/${screen_id}.png

    ${baseline_exists}=    Run Keyword And Return Status    File Should Exist    baselines/${CI}${screen_id}.png
    IF    '${baseline_exists}' == 'False'
        Log
        ...    Baseline for ${page_url} / ${screen_id} does not exist. You need to create one - take the screenshot from report.
        ...    level=WARN
        ${new_warn_val}=    Evaluate    ${WARN_COUNT}+1
        Set Global Variable    ${WARN_COUNT}    ${new_warn_val}
    ELSE
        ${status}=    Run Keyword And Return Status
        ...    Compare Images
        ...    ${actual screen file}
        ...    baselines/${CI}${screen_id}.png
        ...    ssim=0.99

        IF    '${status}' == 'False'
            Log
            ...    ERROR FOUND: Page at ${page_url} / ${screen_id} seems to be different than the one storeed as baseline.
            ...    level=ERROR
            ${new_err_val}=    Evaluate    ${ERR_COUNT}+1
            Set Global Variable    ${ERR_COUNT}    ${new_err_val}
        END
    END

Start test
    New Browser    chromium    headless=${HEADLESS}
    New Context    viewport={'width': 1920, 'height': 1080}
    New Page    ${URL}
