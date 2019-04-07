*** Setting ***
Documentation    NGW IDX Automation Test
Library    String
Library    Collections
Library    DatabaseLibrary
LIbrary    XML    use_lxml=True
Resource    ./resources_common/common_keywords_sword.robot

*** Variables ***
@{LIST} =    foo    baz
${Connection39 String}    'oracle.jdbc.driver.OracleDriver', 'jdbc:oracle:thin:wmwhse39/WMwhSql39@//10.215.22.21:1521/UAT01'
${SQL_Orders}        SELECT * FROM ORDERS WHERE ROWNUM < 3
${SGI XML FILE}    C:\\DB\\AU\\NGW\\Python\\Automation\\RobotFramework\\Task\\NGW_IDX_Mapping\\MAHU\\resources\\test_data\\940\\AU_MAHU_940-IB-WMWHSE39_0093873913_20190311110506.XML        
${xpath_MessageID SGI}    /ShippingOrder/ApplicationArea/Receivers/Receiver/ReferenceID  
    
*** Keywords ***
Find Index
   [Arguments]    ${element}    @{items}
   ${index} =    Set Variable    ${0}
   :FOR    ${item}    IN    @{items}
   \    Return From Keyword If    '${item}' == '${element}'    ${index}
   \    ${index} =    Set Variable    ${index + 1}
   Return From Keyword    ${-1}    # Also [Return] would work here.

*** Test Cases ***
Exampled
    LOG     ${CURDIR}
    ${index} =    Find Index    baz    @{LIST}
    Should Be Equal    ${index}    ${1}
    ${index} =    Find Index    non existing    @{LIST}
    Should Be Equal    ${index}    ${-1}
    Set Suite Variable     ${index}
    
Show List
    #Log    ${index}    
    @{DemoLIST} =  Create List  ${1}  ${2}  ${3}
    Log    @{DemoLIST}[1]
    Log    ${DemoLIST[1]}
    LogMany    @{DemoLIST}
    @{DemoLIST1} =  Create List  4  5  6
    @{DemoLIST2} =  Create List  ${DemoLIST}  ${DemoLIST1}
    Log    @{DemoLIST2[1]}[1]
    Log    ${DemoLIST2[1][1]}
    ${No} =   Set Variable  ${1}
    ${No} =   Evaluate    ${No} + 1
    Log       ${No + 1}
    ${index7} =     Set Variable     ${22}
    Run KeyWord IF     ${No} > 1
    ...    run keywords     Log  MMMM                  AND            Should be equal     ${1}    ${1}
    ${DNNO}      Run KeyWord IF     ${No} > 1  SET VARIABLE     VV
    ...    ELSE    SET VARIABLE    BB
    ${DNNO} =    Evaluate    'NN'
    ${DNNO}      Run KeyWord IF     ${No} > 0  SET VARIABLE     RR
    ...    ELSE    SET VARIABLE    Z
    ${DNNO2} =     Catenate    ${DNNO}     QQ
    
    ${Status} =    Run Keyword And Return Status    Should be equal     ${1}    ${2}
    
    Import Library    ./customkw.py
    Download Should Be Done    C:/DB    
    ...    6.txt
    Should Greater Than    b=${1}    a=${2}
    ${Name}    Set Variable    kc
    ${Male}    Set Variable    Male
    Run KeyWord IF    '${Name} == kc or ${Male} == Mal'   Log    ${5}
    ...    ELSE    Log    ${6}
  
Connect To DataBase
    Connect To Database Using Custom Params    jaydebeapi    ${Connection39 String}
    @{query}    Query    ${SQL_Orders}    True
    LogMany    @{query}
    
 Read XML ELEMENT
    LOG    ${SGI XML FILE}
    ${Root SGI}    Parse XML    ${SGI XML FILE}
    ${MessageID SGI}=    Get Element Text    ${Root SGI}    xpath=${xpath_MessageID SGI}
    LOG    ${MessageID SGI} 
    
 Open URL
    Open Browser    http://www.baidu.com/    Chrome
    
    