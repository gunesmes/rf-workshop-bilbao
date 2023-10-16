*** Settings ***
Library     Collections
Library     Browser
Resource    ../../resources/common.robot
Resource    ../../resources/asserts.robot


*** Variables ***
${URL}                              %{URL=https://dronjo.wopee.io}

${ERR_COUNT}                        0
${WARN_COUNT}                       0

${MAX_DEPTH_TO_CRAWL}               3
${MAX_NUMBER_OF_PAGE_TO_CRAWL}      10


*** Test Cases ***
Crawl a website
    Log To Console    \nTest for ${URL} just started
    ${crawling_result}=
    ...    Crawl Site    ${URL}    page_crawl_keyword=Wopee Checks
    ...    max_depth_to_crawl=${MAX_DEPTH_TO_CRAWL}
    ...    max_number_of_page_to_crawl=${MAX_NUMBER_OF_PAGE_TO_CRAWL}
    Get Summary Results    ${ERR_COUNT}    ${WARN_COUNT}    ${MAX_NUMBER_OF_PAGE_TO_CRAWL}


*** Keywords ***
Wopee Checks
    Console should not contain errors
    Console should not contain warnings
