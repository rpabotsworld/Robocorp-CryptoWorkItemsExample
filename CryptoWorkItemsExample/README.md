# Robot Overview
This robot tracks the cryptocurrencies portfolio of customer from an incoming Excel file, the individual crypto coins is tracked for price movement is then handled individually in parallel in cloud container.
The robot demonstrates the concept of work items feature of Robocorp- 
•		Creating multistep process
•		Passing data between the process steps using work items
•		Parallel execution of steps
•		Use of Custom Python Library (pycoingecko to get Crypto prices using Coin Gecko API)
•		Sending consolidated HTML email using python Jinja2 template engine
## Robot Tasks
The robot is split into 3 tasks.
1.	CreateWorkitems - Read Excel Records to Create Robocloud Work Items, Creates a new work item for each Crypto Coin.
2.	ProcessWorkItems - Process Work items Individually to get Latest price from CoinGecko API, can be set to run in parallel 
3.	StatusWorkitems - Send Consolidated Report of All coins from Input in template-based HTML email.

## Robocorp Library Used 
•	RPA.Robocorp.WorkItems
•	RPA.HTTP
•	RPA.JSON
•	RPA.Excel.Files
## Additional Python Library Used 
•	Smtplib, jinja2 ,sqllite3
•	Pycoingecko wrapper for CoinGeckoAPI


## Learning materials

- [All docs related to Robot Framework](https://robocorp.com/docs/languages-and-frameworks/robot-framework)
