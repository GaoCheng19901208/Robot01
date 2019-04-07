*** Setting ***
Library    OperatingSystem
Documentation    Open Url in Browser:    
...    Chrome    
...    Chrome Phantom Mode    
...    Firefox    
...    Internet Explorer
Library    SeleniumLibrary
*** Keyword ***
Open Page In Chrome Phantom Mode
    [Arguments]    ${URL}    ${Download Dir}
    ${chrome_options} =    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    ${preferences} =    Create Dictionary    credentials_enable_services=${False}    download.default_directory=${Download Dir}
    Call Method    ${chrome_options}    add_experimental_option    prefs    ${preferences}
    Call Method    ${chrome_options}    add_argument    disable-infobars
    # Call Method    ${chrome_options}    add_argument    headless
    Call Method    ${chrome_options}    add_argument    disable-gpu
    Create Webdriver    Chrome    chrome_options=${chrome_options}
    Maximize Browser Window
    Go To    ${URL}
    ${page_title} =    Get Title
    Log    ${page_title}
    
Open Page In Chrome
    [Arguments]    ${URL}
    ${chrome_options} =    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    ${preferences} =    Create Dictionary    credentials_enable_services=${False}
    Call Method    ${chrome_options}    add_experimental_option    prefs    ${preferences}
    Call Method    ${chrome_options}    add_argument    disable-infobars
    # Call Method    ${chrome_options}    add_argument    headless
    Call Method    ${chrome_options}    add_argument    disable-gpu
    Create Webdriver    Chrome    chrome_options=${chrome_options}
    Maximize Browser Window
    Go To    ${URL}
    ${page_title} =    Get Title
    Log    ${page_title}

Download Should Be Done
    [Arguments]    ${Download Dir}    ${File Name}
    ${fullpath}    Catenate    SEPARATOR=${/}    ${Download Dir}    ${File Name}
    File Should Exist    ${fullpath}