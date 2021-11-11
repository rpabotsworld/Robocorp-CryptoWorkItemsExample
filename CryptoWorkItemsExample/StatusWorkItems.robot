*** Settings ***
Documentation     Process Workitems
Library           RPA.Robocorp.WorkItems
Library           RPA.HTTP
Library           RPA.JSON
Library           CommonLibrary


*** Variables ***

*** Keywords ***
Consoidated Report
    [Documentation]    Send Report for All Cryptos
    For Each Input Work Item    Build Report

*** Keywords ***
Build Report
    #Coin=${Coin}    CoinGekoPrice=${Price}    CoinMarketPrice=${MarketPrice}    TimeStamp=${DATE}
    ${Coin}=    Get Work Item Variable    Coin
    ${Price}=    Get Work Item Variable    CoinGekoPrice
    ${marketprice}=    Get Work Item Variable    CoinMarketPrice
    ${updatedon}=    Get Work Item Variable    TimeStamp
    Log    ${Coin} ${price}
    Insert Table    ${Coin}    ${price}    ${marketprice}     ${updatedon}

*** Keywords ***
Send Report
    ${results}=    Read Table
    Send Price List    ${results}

*** Tasks ***
Report Workitems
    Clean Table
    Consoidated Report
    Send Report
