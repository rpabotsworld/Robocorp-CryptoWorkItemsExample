*** Settings ***
Documentation   Read Excel Records to Create Robocloud WorkItems
Library    RPA.Browser.Selenium
Library    RPA.HTTP
Library    RPA.Robocorp.WorkItems
Library    RPA.Excel.Files


*** Variables ***
${File}=  %{ROBOT_ROOT}/CoinsToWatch.xlsx

*** Tasks ***
Upload Data
    Open Workbook    ${File}
    ${sheetname}=  Get Active Worksheet
    LOG  ${sheetname}
    ${data}=  Read Worksheet As Table  name=${sheetname}  header=True
    FOR    ${row}    IN    @{data}
        Create Output Work Item
        Set Work Item Variable  ID  ${row}[ID]
        Set Work Item Variable  Coin  ${row}[Coin]
        Set Work Item Variable  Symbol  ${row}[Symbol]
        Save Work Item
    END
    Close Workbook