*** Settings ***
Library     RequestsLibrary
Library     String
Library     Browser
Library     Collections


*** Variables ***
${API_URL}                  https://api.openai.com/v1/chat/completions
# This is example how the token should look link but do not store it here
# see README.MD for more details to set it up as system environment
# ${TOKEN}    Bearer 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
${TOKEN}                    %{OPENAI_API_KEY}
${MODEL}                    gpt-3.5-turbo-0613
${ROLE}                     user
${TEMPERATURE}              0.7

${ACCEPTABLE ELEMENTS}      input[type="text"], input[type="password"], textarea, select

${PROMPT_FILL_TEMPLATE}
...                         I am a test engineer writing tests in Robot Framework using the Browser library.
...                         I have opened a web page and I want to fill in and submit (click on button as a last step) the form on this page.
...                         Use real test data (consider defined and typical validations) and use only xpath locators from this HTML:
...                         \n\n
...                         ```html
...                         $$$HTML$$$
...                         ```
...                         \n\n
...                         Provide me steps to accomplish it in json format. Example:
...                         \n\n
...                         ```json
...                         [
...                         { "step": 1, "locator": "#name", "value": "Marcel", "action": "fill" },
...                         { "step": 2, "locator": "#pswd", "value": "abc123", "action": "fill" }
...                         ]
...                         ```

# TODO: Try to simplify and generate directly the robot code
${PROMPT_FILL_TEMPLATE2}
...                         I am a test engineer writing tests in Robot Framework using the Browser library.
...                         I have opened a web page and I want to fill in and submit (click on button as a last step) the form on this page.
...                         Use real test data (consider defined and typical validations) and use only locators from this HTML:
...                         \n\n
...                         ```html
...                         $$$HTML$$$
...                         ```
...                         \n\n
...                         Provide me steps to accomplish it as Robot Framework code. Example:
...                         \n\n
...                         ```robotframework
...                         Fill
...                         \#name
...                         Marcel
...                         Fill
...                         \#pswd
...                         abc123
...                         Click
...                         \#submit
...                         ```


*** Keywords ***
Autonomous Form Filling
    ${forms count}=    Get Element Count    form

    IF    ${forms count} > 0
        ${form code}=    Get Property    form >> nth=0    outerHTML
        Fill form    ${form code}
    ELSE
        Log To Console    \nNo forms found
    END

Fill Form
    [Arguments]    ${form code}

    ${inputs count}=    Get Element Count    ${ACCEPTABLE ELEMENTS}

    IF    ${inputs count} > 0
        Log To Console    \n\nFollowing form identified:
        Log To Console    ${form code}\n\n

        ${instructions}=    Get Filling Advice    ${form code}
        Log To Console    \n\nFollowing filling advice recieved:
        Log To Console    ${instructions}\n\n

        FOR    ${step}    IN    @{instructions}
            IF    'value' in ${step}
                Log To Console    Step ${step['step']}: ${step['action']} ${step['locator']} = ${step['value']}
            ELSE
                Log To Console    Step ${step['step']}: ${step['action']} ${step['locator']}
            END
        END

        FOR    ${step}    IN    @{instructions}
            ${action}=    Set Variable    ${step['action']}
            ${locator}=    Set Variable    ${step['locator']}

            IF    '${action}' == 'fill'
                ${value}=    Set Variable    ${step['value']}
                Fill Text    ${locator}    ${value}
            ELSE IF    '${action}' == 'click'
                Take Screenshot    fullPage=True
                Click    ${locator}
            END
        END
    ELSE
        Log To Console    \n\nNo inputs found
    END

Get Filling Advice
    [Arguments]    ${form code}

    # Replace newlines with spaces
    ${form code}=    Set Variable
    ...    ${form_code.replace("\n", " ")}

    ${prompt fill}=    Set Variable
    ...    ${PROMPT_FILL_TEMPLATE.replace("""$$$HTML$$$""", """${form code}""")}

    ${response}=    Get AI Advice    ${PROMPT_FILL}

    ${contains}=    Evaluate    "```json" in """${response}"""

    IF    ${contains}
        ${json text}=    Get Regexp Matches    ${response}    (?i)[\s\S]*?```(?:json)?\n([\s\S]*?[^`]*?)\n```[\s\S]*?
        ${json text}=    Evaluate    """${json text}""".replace("['```json", "")
        ${json text}=    Evaluate    """${json text}""".replace("```']", "")

        Log To Console    \n\n
        Log To Console    Following steps were proposed by AI:
        Log To Console    ${json text}
        Log To Console    \n\n
    ELSE
        ${json text}=    Set Variable    ${response}
    END

    ${json}=    Evaluate    json.loads('''${json text}''')    json

    RETURN    ${json}

Get AI Advice
    [Arguments]    ${prompt}
    ${headers}=    Create Dictionary    Authorization=${TOKEN}

    ${message}=    Create Dictionary
    ...    role=${ROLE}
    ...    content=${prompt}

    ${messages}=    Create List    ${message}

    ${data}=    Create Dictionary
    ...    model=${MODEL}
    ...    messages=${messages}
    ...    temperature=${${TEMPERATURE}}

    ${response}=    POST    ${API_URL}    headers=${headers}    json=${data}

    ${json}=    Set Variable    ${response.json()}

    ${text}=    Get From Dictionary    ${json}    choices

    # Get type of text
    ${t2}=    Get From Dictionary    ${text}[0]    message
    ${t3}=    Get From Dictionary    ${t2}    content

    RETURN    ${t3}

Start progress loader
    ${texts}=    Evaluate JavaScript    html
    ...    (elements, arg) => {
    ...    elements[0].insertAdjacentHTML(
    ...    'beforeend',
    ...    '<div class="wopeePopup">'+
    ...    '<h2>❤️ Wopee.io 🦧</h2>'+
    ...    '<p>Please wait, it takes a couple of seconds to get results from AI services.</p>'+
    ...    '</div>'+
    ...    '<style>'+
    ...    '.wopeePopup {'+
    ...    'display: block;'+
    ...    'text-align: center;'+
    ...    'position: fixed;'+
    ...    'top: 15px;'+
    ...    'left: 15px;'+
    ...    'padding: 15px;'+
    ...    'margin: 15px;'+
    ...    'width: 300px;'+
    ...    'background-color: rgb(255 204 0);'+
    ...    'z-index: 9;'+
    ...    'animation: blinker 3s linear infinite;'+
    ...    '}'+
    # ...    '.wopeePopup h2 { animation: blinker 3s linear infinite; }'+
    ...    '@keyframes blinker { 50% { opacity: 0; } }'+
    ...    '<style>'
    ...    );}
    ...    all_elements=True
