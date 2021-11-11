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
    ${Coin}=    Get Work Item Variable    Coin
    ${Price}=    Get Work Item Variable    price
    Log    ${Coin} ${price}
    Insert Table    ${Coin}     ${price}

*** Keywords ***
Send Report
    ${results}=     Read Table
    Send Price List    ${results}


*** Tasks ***
Report Workitems
    Consoidated Report
    #Create Table
    Send Report

