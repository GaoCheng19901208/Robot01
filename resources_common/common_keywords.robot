*** Setting ***
Documentation    Common Keywords for test projects.
Library    DatabaseLibrary
Library    String
Library     DateTime
LIbrary    XML    use_lxml=True

*** Variable ***
${Connection39 String}    'oracle.jdbc.driver.OracleDriver', 'jdbc:oracle:thin:wmwhse39/WMwhSql39@//10.215.22.21:1521/UAT01'
${Connection85 String}    'oracle.jdbc.driver.OracleDriver', 'jdbc:oracle:thin:wmwhse39/WMwhSql85@//10.215.22.21:1521/UAT01'
@{ResultSet 0}    Null
@{ResultSet 1}    Null
@{ResultSet 2}    Null
@{ResultSet 3}    Null
@{ResultSet 4}    Null

*** Keyword ***
Load Xml and Open DB
    [Arguments]    ${Connection39 String}    ${Sgi File}    ${Customer File}    @{SQL Statements}
    ${Root SGI}    Parse XML    ${Sgi File}
    ${Root CUST}    Parse XML    ${Customer File}
    Set Suite Variable    ${SGI XML DOC}    ${Root SGI} 
    Set Suite Variable    ${CUST XML DOC}    ${Root CUST} 
    Connect To Database Using Custom Params    jaydebeapi    ${Connection39 String}
    ${i}=    Set Variable    0
    FOR    ${A SQL Statement}    IN    @{SQL Statements}
        @{query}    Query    ${A SQL Statement}    True
        Set Suite Variable    @{ResultSet ${i}}    @{query}
        ${i}    Evaluate    ${i}+1   
    END

Remove zero profix
    [Arguments]    ${str}
    ${len}    Get Length    ${str}
    ${index}    Set Variable    0
    :FOR    ${i}    IN RANGE    ${len}
    \    ${index}    Set Variable If    '${str[${i}]}'=='0'    ${i}    ${index}
    \    Exit For Loop If    '${str[${i}]}'!='0'
    ${tempIndex}    Evaluate    ${index}+1
    ${realIndex}    Set Variable If    '${i}'=='${0}'    0    ${tempIndex}
    ${result}    Get Substring    ${str}    ${realIndex}
    Return From Keyword    ${result}

Conver Date format
    [Arguments]    ${original date}
    ${Date}=    Convert Date    ${original date}    result_format=%Y-%m-%d
    Return From Keyword    ${Date}
    
Check Element Exist
    [Arguments]    ${xml_doc}    ${xml_element}
    ${element_exist_flag}=    Run Keyword And Return Status    Get Element Text    ${xml_doc}    xpath=${xml_element}
    Return From Keyword    ${element_exist_flag}
    
Set ExpDare format
    [Arguments]    ${XML DOC}    ${XML XPATH}
    ${ExpDate in File}=    Get Element Text    ${XML DOC}    xpath=${XML XPATH}
    ${ExpDate Original}    Run Keyword If    ${ExpDate in File}!=00000000    Conver Date format    ${ExpDate in File}
    ...    ELSE    Set Variable    00000000

Item should not be empty or null
    [Arguments]    ${XML DOC}    ${XML XPATH}
    ${element in File}=    Get Element Text    ${XML DOC}    xpath=${XML XPATH}
    Should Not Be Empty    ${element in File}