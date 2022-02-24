local naughty	= require('naughty')
local beautiful = require('beautiful')
local awful		= require('awful')
local json		= require('lib.json')
local gears		= require('gears')

local CURRENT_WORKING_DIR = gears.filesystem.get_configuration_dir() .. 'evil/mail/'

local total_mails = 0
local db = {}
local db_tmp = {}

local send_notification = function (username, mail_id, text, timeout)
	local notif
	notif = naughty.notify({
		title = "NEW EMAIL BRO!",
		text = text,
		icon = beautiful.get_random_waifu(),
		timeout = timeout,
		run = function ()
            db[mail_id] = nil
            total_mails = total_mails - 1

			awesome.emit_signal('evil::mail', total_mails)

			-- Dismiss mail when click on the notification
			awful.spawn(string.format('python %sdismiss_mail.py %s %s', CURRENT_WORKING_DIR, username, mail_id))
			notif.die(naughty.notificationClosedReason.dismissedByUser)
		end
	})
end

local show_mail = function (mail, timeout)
    local msg = ''
    for _, header in ipairs({'From', 'To', 'Subject', 'Date'}) do
        msg = msg .. string.format('%s: %s\n', header, mail[header])
    end
    send_notification(mail['To'], mail['id'], msg, timeout)
end

awful.widget.watch('python ' .. CURRENT_WORKING_DIR .. 'get_unread_mails.py', 60, function (_, stdout)
	if stdout ~= '' then
		db_tmp = {}
		total_mails = 0

		local mails = json.decode(stdout)

		for _, m in ipairs(mails) do
			db_tmp[m['id']] = m
			total_mails = total_mails + 1

			if db[m['id']] == nil then
				db[m['id']] = m
				show_mail(m, 15)
			end
		end

		db = db_tmp
		awesome.emit_signal('evil::mail', total_mails)
	end
end)

awesome.connect_signal('evil::mail_showall', function ()
	for id in pairs(db) do
		show_mail(db[id], 0)
	end
end)
