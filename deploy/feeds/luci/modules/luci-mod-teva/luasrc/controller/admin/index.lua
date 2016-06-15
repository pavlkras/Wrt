-- Copyright 2008 Steven Barth <steven@midlink.org>
-- Licensed to the public under the Apache License 2.0.
local http = require "luci.http"
module("luci.controller.admin.index", package.seeall)

function index()
	local root = node()
	if not root.target then
		root.target = alias("admin")
		root.index = true
	end

	local page   = node("admin")
--	page.target  = firstchild()
--      ������� �� �������� �� �������� wi-fi
	page.target=  { type = "firstchild", target = function() luci.http.redirect("/cgi-bin/teva/admin/network/wireless_join?device=radio0") end } 


	page.title   = _("Administration")
	page.order   = 10
		
     --[[   page.sysauth = "root"
	page.sysauth_authenticator = "htmlauth"        ��� �������� ���� ����� ���������� ����������� ]]--
	page.ucidata = true
	page.index = true

	-- Empty services menu to be populated by addons



end

function action_logout()
	local dsp = require "luci.dispatcher"
	local utl = require "luci.util"
	local sid = dsp.context.authsession

	if sid then
		utl.ubus("session", "destroy", { ubus_rpc_session = sid })

		dsp.context.urltoken.stok = nil

		luci.http.header("Set-Cookie", "sysauth=%s; expires=%s; path=%s/" %{
			sid, 'Thu, 01 Jan 1970 01:00:00 GMT', dsp.build_url()
		})
	end

	luci.http.redirect(luci.dispatcher.build_url())
end
