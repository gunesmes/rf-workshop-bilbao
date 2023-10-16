*** Settings ***
Library     Collections
Library     Browser


*** Keywords ***
Console should not contain errors
    ${console_log}=    Get Console Log

    FOR    ${log_item}    IN    @{console_log}
        ${log_type}=    Get From Dictionary    ${log_item}    type
        IF    '${log_type}' == 'error'
            Log    ERROR FOUND: ${log_item}    level=ERROR
            ${new_err_val}=    Evaluate    ${ERR_COUNT}+1
            Set Global Variable    ${ERR_COUNT}    ${new_err_val}
            Take Screenshot    fullPage=True
        END
    END

Console should not contain warnings
    ${console_log}=    Get Console Log

    FOR    ${log_item}    IN    @{console_log}
        ${log_type}=    Get From Dictionary    ${log_item}    type
        IF    '${log_type}' == 'warning'
            Log    WARNING FOUND: ${log_item}    level=WARN
            ${new_warn_val}=    Evaluate    ${WARN_COUNT}+1
            Set Global Variable    ${WARN_COUNT}    ${new_warn_val}
        END
    END
