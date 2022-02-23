import imaplib
import email
import datetime
import json
import os

def get_emails_info(username, password):
    mails = []
    
    try:
        session = imaplib.IMAP4_SSL('imap.gmail.com')
        session.login(username, password)
        session.select()
    except:
        return mails

    _, index = session.search(None, 'UnSeen')
    index = index[0].split()

    for i in index:
        _, msg = session.fetch(i, '(BODY.PEEK[])')
        msg = email.message_from_bytes(msg[0][1])

        info = {
            'id': i.decode(),
            'To': username,
        }

        for header in ['From', 'Subject', 'Date']:
            data = email.header.make_header(email.header.decode_header(msg[header]))

            # Convert to local time
            if header == 'Date':
                date_tuple = email.utils.parsedate_tz(str(data))
                local_date = datetime.datetime.fromtimestamp(email.utils.mktime_tz(date_tuple))
                data = local_date.strftime('%a, %d %b %Y %H:%M:%S')

            info[header] = str(data)
        mails.append(info)

    session.logout()
    return mails

with open('/home/' + os.getlogin() + '/.config/awesome/evil/mail/conf.json', 'r') as f:
    accounts = json.load(f)

mails = []
for username, password in accounts.items():
    mails += get_emails_info(username, password)

print(json.dumps(mails))