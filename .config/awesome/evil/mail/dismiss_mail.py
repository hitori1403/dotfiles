import imaplib
import json
import os
import sys

def set_seen(username, password, mail_id):
    session = imaplib.IMAP4_SSL('imap.gmail.com')
    session.login(username, password)
    session.select()
    session.store(mail_id, '+FLAGS', '\Seen')
    session.logout()

with open('/home/' + os.getlogin() + '/.config/awesome/evil/mail/conf.json', 'r') as f:
    accounts = json.load(f)

username, mail_id = sys.argv[1:3]
set_seen(username, accounts[username], mail_id)
