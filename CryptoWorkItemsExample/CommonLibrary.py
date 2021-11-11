import os
import sqlite3
import json
from pycoingecko import CoinGeckoAPI
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from smtplib import SMTP

from jinja2 import Environment, FileSystemLoader

env = Environment(
    loader=FileSystemLoader('%s/templates/' % os.path.dirname(__file__)))

# VARIABLES 
TO_EMAIL = "prasadsatish@outlook.com"
FROM_EMAIL = "rpabotsworld@gmail.com"
SUBJECT = "PRICE MOVEMENT FOR TRACKED COIN"
EMAIL_APP_PASS = "tptetpdbizgizggz"


def send_mail(to_email ,from_email, subject, bodyContent):
    message = MIMEMultipart()
    message['Subject'] = subject
    message['From'] = from_email
    message['To'] = to_email

    message.attach(MIMEText(bodyContent, "html"))
    msgBody = message.as_string()

    server = SMTP('smtp.gmail.com', 587)
    server.starttls()
    server.login(from_email,EMAIL_APP_PASS )
    server.sendmail(from_email, to_email, msgBody)
    server.quit()


def send_price_list(data):
    template = env.get_template('list.html')
    output = template.render(data=data)
    send_mail(TO_EMAIL,FROM_EMAIL,SUBJECT, output)    
    return "Mail sent successfully."


def get_coin_price(coin,symbol):
    price = None
    cg = CoinGeckoAPI()
    response = cg.get_price(ids=coin, vs_currencies='usd')
    for key, value in response.items():
        price=value['usd']
    return price
    
    
def create_table():
    con =  con = sqlite3.connect('example.db')
    # Create table
    cur = con.cursor()
    cur.execute('''CREATE TABLE crypto
                (coin text, price real)''')
    con.commit()
    con.close()

def insert_table(coin,price):
    con =  con = sqlite3.connect('example.db')
    # Create table
    cur = con.cursor()
    sql = '''INSERT INTO crypto(coin, price) values(?, ?)'''
    val = (coin,price)
    cur.execute(sql,val)
    print(cur.rowcount, "details inserted")
    con.commit()
    con.close()

def read_table():
    con =  con = sqlite3.connect('example.db')
    cur = con.cursor()
    sql = "Select * from  crypto"
    cur.execute(sql)
    out=cur.fetchall()
    variable = {key:val for key,val in out}
    print(variable)
    con.close()
    return variable