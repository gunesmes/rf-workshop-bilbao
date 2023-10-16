*** Settings ***
Library     OperatingSystem
Library     String


*** Keywords ***
Convert URL to Unique String
    [Arguments]    ${url}
    ${result} =    Evaluate    hashlib.md5("${url}".encode('utf-8')).hexdigest()    hashlib
    RETURN    ${result}

Get Summary Results
    [Arguments]    ${err_count}    ${warn_count}
    Log To Console    .
    Log To Console    ==============================================================================
    Log To Console
    ...    WOPEE SIMPLE BOT * \U0001F916 \U0001F648 \U0001F649 \U0001F64A \U0001F435 \U0001F412 \U0001F98D \U0001F9A7
    Log To Console    ==============================================================================
    Log    TOTAL ERRORS FOUND: ${err_count}    level=ERROR
    Log    TOTAL WARNINGS FOUND: ${warn_count}    level=WARN
    Log To Console    .
    Log To Console    ==============================================================================

# 🤖 Robot: \U0001F916
# 🙈 See-No-Evil Monkey: \U0001F648
# 🙉 Hear-No-Evil Monkey: \U0001F649
# 🙊 Speak-No-Evil Monkey: \U0001F64A
# 🐵 Monkey Face: \U0001F435
# 🐒 Monkey: \U0001F412
# 🦍 Gorilla: \U0001F98D
# 🦧 Orangutan: \U0001F9A7
