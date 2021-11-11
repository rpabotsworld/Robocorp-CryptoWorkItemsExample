*** Settings ***
Documentation     Process Workitems Individually to get Latest price from CoinGecko API
Library           RPA.Robocorp.WorkItems
Library           RPA.HTTP
Library           RPA.JSON
Library           CommonLibrary
Library           DateTime
Library           Collections
Library           RPA.Browser.Selenium
Library           RPA.FileSystem

*** Variables ***
${API_URL}=

*** Keywords ***
Load and Process Coin
    [Documentation]    Get Price
    ${ID}=    Get Work Item Variable    ID
    ${Coin}=    Get Work Item Variable    Coin
    ${Symbol}=    Get Work Item Variable    Symbol
    ${passed}=    Run Keyword And Return Status
    ...    Get Coin Data    ${Coin}    ${Symbol}
    IF    ${passed}
        Log    Price prosessing passed for: ${ID} Coin: ${Coin} items: ${Symbol}    level=INFO
        Release Input Work Item    DONE
    ELSE
        Log    Price prosessing failed for: ${ID} Coin: ${Coin} items: ${Symbol}    level=ERROR
        Release Input Work Item
        ...    state=FAILED
        ...    exception_type=BUSINESS
        ...    message=Order prosessing failed for: ${Coin}
    END

*** Keywords ***
Get Coin Data
    [Arguments]    ${Coin}    ${Symbol}
    ${DATE}=    Get Current Date    result_format=timestamp
    ${Price}=    Get Coin Price    ${Coin}    ${Symbol}
    ${MarketPrice}=    Get Coin Data From CoinMarketCap    ${Coin}    ${Symbol}
    Create output work item
    Set work item variables    Coin=${Coin}    CoinGekoPrice=${Price}    CoinMarketPrice=${MarketPrice}    TimeStamp=${DATE}
    Save work item
    Log    Price for ${Coin} : ${Price} at TimeStamp ${DATE} while at Market is ${MarketPrice}

 *** Keyword ***

 Get Coin Data From CoinMarketCap
    [Arguments]    ${Coin}    ${Symbol}
    Open Available Browser    https://coinmarketcap.com/
    Sleep    2
    Maximize Browser Window
    Go To    https://coinmarketcap.com/currencies/${Coin}
    Sleep    1
    Wait Until Element Is Visible    //*[@id="__next"]/div[1]/div/div[2]/div/div[1]/div[2]/div/div[2]/div[1]/div
    ${MARKET_PRICE}=    Get Text    //*[@id="__next"]/div[1]/div/div[2]/div/div[1]/div[2]/div/div[2]/div[1]/div
    Log    ${MARKET_PRICE}
    Close Browser
    [Return]    ${MARKET_PRICE}

*** Tasks ***
Process Data
    For Each Input Work Item    Load and Process Coin
