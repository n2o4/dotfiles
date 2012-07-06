-- n2o4 rc.lua 29.03.2012
-- Not the best but working nonetheless. 

require("awful")
require("awful.autofocus")
require("awful.rules")
require("beautiful")
require("naughty")
require("vicious")
--require("wicked")
require("debian.menu")

beautiful.init("/usr/share/awesome/themes/mytheme/theme.lua")

terminal = "urxvt"
editor = os.getenv("EDITOR") or "editor"
editor_cmd = terminal .. " -e " .. editor
browser = "x-www-browser"

modkey = "Mod4"

layouts =
{
    awful.layout.suit.floating,			-- 1
    awful.layout.suit.tile,				-- 2
    awful.layout.suit.tile.left,		-- 3
    awful.layout.suit.tile.bottom,		-- 4
    awful.layout.suit.tile.top,			-- 5
    awful.layout.suit.fair,				-- 6
    awful.layout.suit.fair.horizontal,	-- 7
    awful.layout.suit.spiral,			-- 8
    awful.layout.suit.spiral.dwindle,	-- 9
    awful.layout.suit.max,				-- 10
    awful.layout.suit.max.fullscreen,	-- 11
    awful.layout.suit.magnifier			-- 12
}

tags = {
	names = { " front ", " www ", " devel ", " misc ", " media " },
	layout= { layouts[4], layouts[1], layouts[4], layouts[4], layouts[6] }
}

for s = 1, screen.count() do
    -- Each screen has its own tag table.
    tags[s] = awful.tag(tags.names, s, tags.layout)
end

myawesomemenu = {
   { "restart", awesome.restart },
   { "configure", editor_cmd .. " " .. awesome.conffile },
}

browser = {
			{ "chromium", "chromium-browser"},
			{ "luakit", "luakit" }
}

office = { 
         { "libreoffice", "libreoffice"},
         { "writer", "libreoffice --writer"},
         { "impress", "libreoffice --impress"},
         { "calc", "libreoffice --calc"},
         { "math", "libreoffice --math"},
         { "draw", "libreoffice --draw"}
}

games = {
		{ "crawl", "urxvt -n crawl -e crawl"},
		{ "nethack", "urxvt -n nethack -e nethack"}

}

config = {
	{ "edit rc.lua", "geany /home/n2o4/.config/awesome/rc.lua" },
	{ "edit conky", "geany /home/n2o4/.conkyrc" },
	{ "edit screenrc", "geany /home/n2o4/.screenrc"},
	{ "edit xresources", "geany /home/n2o4/.Xresources"}
}

screenshot = {
	{ "now", "scrot '%Y-%m-%d--%s_$wx$h_scrot.png' -e 'mv $f /home/n2o4/images/screenshots &amp; feh /home/n2o4/images/screenshots/$f'" },
	{ "wait 5s", "scrot -d 5 '%Y-%m-%d--%s_$wx$h_scrot.png' -e 'mv $f /home/n2o4/images/screenshots &amp; feh /home/n2o4/images/screenshots/$f'" },
	{ "wait 10s", "scrot -d 10 '%Y-%m-%d--%s_$wx$h_scrot.png' -e 'mv $f /home/n2o4/images/screenshots &amp; feh /home/n2o4/images/screenshots/$f'"}
}

--logout = {
--	{ "suspend", "gksudo pm-suspend"},
--	{ "hibernate", "gksudo pm-hibernate"},
--	{ "suspend-hybrid", "gksudo pm-suspend-hybrid"},
--	{ "reboot", "gksudo reboot"},
--	{ "shutdown", "gksudo shutdown -h now"},
--	{ "logout", awesome.quit }
--}

mymainmenu = awful.menu({ items = { { "terminal", terminal },
                                    { "awesome", myawesomemenu, beautiful.awesome_icon },
                                    { "browsers", browser },
                                    { "libreoffice", office },
                                    { "games", games },
                                    { "config", config },
                                    { "screenshot", screenshot },
                                    { "Debian", debian.menu.Debian_menu.Debian },
                                    { "logout", '/usr/bin/shutdown_dialog.sh' }
                                  }
                        })

mylauncher = awful.widget.launcher({ image = image(beautiful.awesome_icon),
                                     menu = mymainmenu })

-- {{{ Wibox
datewidget = widget({ type = "textbox" })
vicious.register(datewidget, vicious.widgets.date, "%A %d.%m.%Y %H:%M", 10)

mysystray = widget({ type = "systray" })

mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
    awful.button({ },        1, awful.tag.viewonly),
    awful.button({ modkey }, 1, awful.client.movetotag),
    awful.button({ },        3, awful.tag.viewtoggle),
    awful.button({ modkey }, 3, awful.client.toggletag),
    awful.button({ },        4, awful.tag.viewnext),
    awful.button({ },        5, awful.tag.viewprev)
)

mytasklist = {}
mytasklist.buttons = awful.util.table.join(
    awful.button({ }, 1, function (c)
        if c == client.focus then
            c.minimized = true
        else
            if not c:isvisible() then
                awful.tag.viewonly(c:tags()[1])
            end
            client.focus = c
            c:raise()
        end
    end),
    awful.button({ }, 3, function ()
        if instance then
            instance:hide()
            instance = nil
        else
            instance = awful.menu.clients({ width=250 })
        end
    end),
    awful.button({ }, 4, function ()
        awful.client.focus.byidx(1)
        if client.focus then client.focus:raise() end
    end),
    awful.button({ }, 5, function ()
        awful.client.focus.byidx(-1)
        if client.focus then client.focus:raise() end
    end))
    
spacer       = widget({ type = "textbox"  })
spacer.text  = ' :: '
space        = widget({ type = "textbox" })
space.text    = ' '

-- Define icons
-- Battery icon
baticon = widget({ type = "imagebox" })
baticon.image = image("/home/n2o4/.config/awesome/icons/bat_full_02.png")
-- CPU icon
cpuicon = widget({ type = "imagebox" })
cpuicon.image = image("/home/n2o4/.config/awesome/icons/cpu.png")
-- MEM icon
memicon = widget({ type = "imagebox" })
memicon.image = image("/home/n2o4/.config/awesome/icons/mem.png")
-- Wifi icon
wificon = widget({ type = "imagebox" })
wificon.image = image("/home/n2o4/.config/awesome/icons/wifi_03.png")
-- Downspeed icon
downicon = widget({ type = "imagebox" })
downicon.image = image("/home/n2o4/.config/awesome/icons/net_down_01.png")
-- Upspeed icon
upicon = widget({ type = "imagebox"})
upicon.image = image("/home/n2o4/.config/awesome/icons/net_up_01.png")
-- Info icon
infoicon = widget({ type = "imagebox"})
infoicon.image = image("/home/n2o4/.config/awesome/icons/info_03.png")
-- MPD/Music icon
mpdicon = widget({ type = "imagebox"})
mpdicon.image = image("/home/n2o4/.config/awesome/icons/note.png")

mpdwidget = widget({ type = 'textbox' })
vicious.register(mpdwidget, vicious.widgets.mpd,
    function (widget, args)
        if args["{state}"] == ("Stop" or "N/A") then 
            return " MPD not running "
        else 
            return spacer.text .. args["{Artist}"]..' - '.. args["{Title}"]
        end
    end, 5)

batwidget = widget({ type = "textbox" })
vicious.register(batwidget, vicious.widgets.bat, ' $1 $2% $3', 60, "BAT0")

cpuwidget = widget({ type = "textbox" })
vicious.register(cpuwidget, vicious.widgets.cpu, ' $1%', 1)

memwidget = widget({ type = "textbox" })
vicious.register(memwidget, vicious.widgets.mem, ' $1% ($2MB/$3MB)', 1)

ssidwidget = widget({ type = "textbox" })
vicious.register(ssidwidget, vicious.widgets.wifi,
	function (widget, args)
		if args['{ssid}'] == 0 then return ''
	else return ' SSID: '..string.format("%s", args["{ssid}"])
		end
	end, 3, "wlan0")

wifiwidget = widget({ type = "textbox" })
vicious.register(wifiwidget, vicious.widgets.wifi,
    function (widget, args)
        if args['{link}'] == 0 then return ''
	else return ' '..string.format("%i%%", args["{link}"]/70*100)
        end
    end, 3, "wlan0")

netwidget = widget({ type = "textbox" })
vicious.register(netwidget, vicious.widgets.net, 
    function (widget, args)
	if args["{wlan0 carrier}"] == 1 then
	    return 'Down: '..args["{wlan0 down_kb}"]..' / Up: '..args["{wlan0 up_kb}"]
	else
            return 'Wlan not connected'
        end
    end, 3)

-- Weather widget
weatherwidget = widget({ type = "textbox" })
weather_t = awful.tooltip({ objects = { weatherwidget },})

vicious.register(weatherwidget, vicious.widgets.weather,
                function (widget, args)
                    weather_t:set_text("City: " .. args["{city}"] .."\nWind: " .. args["{windkmh}"] .. "km/h " .. args["{wind}"] .. "\nSky: " .. args["{sky}"] .. "\nHumidity: " .. args["{humid}"] .. "%")
                    return args["{tempc}"] .. "C"
                end, 1800, "EFHF")
                --'1800': check every 30 minutes.
                --'EFHF': Helsinki ICAO code.

for s = 1, screen.count() do
    mypromptbox[s] = awful.widget.prompt({ layout = awful.widget.layout.horizontal.leftright })
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
        awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
        awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
        awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
        awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, mytaglist.buttons)

    mytasklist[s] = awful.widget.tasklist(function(c)
        return awful.widget.tasklist.label.currenttags(c, s)
        end, mytasklist.buttons)

    mywibox[s] = {}
    mywibox[s][1] = awful.wibox({ position = "top",    screen = s, height = 16 })
    mywibox[s][2] = awful.wibox({ position = "bottom", screen = s, height = 16 })

    mywibox[s][1].widgets = {
		{
			mylauncher,
			space,
			mytaglist[s],
			space,
			mypromptbox[s],
			mylayoutbox[s],
			space,
			layout = awful.widget.layout.horizontal.leftright
		},
		spacer,
		datewidget,
		spacer,
		s == 1 and mysystray or nil,
		spacer,
        mytasklist[s],
        layout = awful.widget.layout.horizontal.rightleft
   }

   mywibox[s][2].widgets = {
		spacer,
        baticon,
		batwidget,
		spacer,
        cpuicon,
		cpuwidget,
		spacer,
        memicon,
		memwidget,
		spacer,
        wificon,
		ssidwidget, wifiwidget, spacer, netwidget,
		spacer,
		infoicon, space, weatherwidget,
		spacer,
        mpdicon,
		mpdwidget,
		space,
		layout = awful.widget.layout.horizontal.leftright
   } 
end
-- }}}


-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    awful.key({ }, "XF86AudioRaiseVolume", function () awful.util.spawn("amixer -q set Master 5%+") end),
    awful.key({ }, "XF86AudioLowerVolume", function () awful.util.spawn("amixer -q set Master 5%-") end),
    awful.key({ }, "XF86AudioMute",        function () awful.util.spawn("amixer -q set Master toggle") end),
    awful.key({ }, "XF86AudioPlay",        function () awful.util.spawn("ncmpcpp toggle", false) end),
    awful.key({ }, "XF86AudioStop",        function () awful.util.spawn("ncmpcpp stop",   false) end),
    awful.key({ }, "XF86AudioNext",        function () awful.util.spawn("ncmpcpp next",   false) end),
    awful.key({ }, "XF86AudioPrev",        function () awful.util.spawn("ncmpcpp prev",   false) end),

    awful.key({ modkey, }, "x",				function () awful.util.spawn("slock") end),

    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "w", function () mymainmenu:show({keygrabber=true}) end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

    awful.key({ modkey, "Control" }, "n", awful.client.restore),

    -- Prompt
    awful.key({ modkey },            "F2",     function () mypromptbox[mouse.screen]:run() end),

    -- Dmenu - bottom position
    awful.key({ modkey },            "r",
		function ()
			awful.util.spawn("dmenu_run -b -i -p 'Run command:' -nb '" ..
			beautiful.bg_normal .. "' -nf '" .. beautiful.fg_normal ..
			"' -sb '" .. beautiful.bg_focus ..
			"' -sf '" .. beautiful.fg_focus .. "'") 
		end),

    awful.key({ modkey, "Control" }, "x",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end)
)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey, "Shift"   }, "r",      function (c) c:redraw()                       end),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

-- Compute the maximum number of digit we need, limited to 9
keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags[s], keynumber));
end

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, keynumber do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        if tags[screen][i] then
                            awful.tag.viewonly(tags[screen][i])
                        end
                  end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      if tags[screen][i] then
                          awful.tag.viewtoggle(tags[screen][i])
                      end
                  end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.movetotag(tags[client.focus.screen][i])
                      end
                  end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.toggletag(tags[client.focus.screen][i])
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = true,
                     keys = clientkeys,
                     buttons = clientbuttons } },
    { rule = { class = "Geany" }, properties = { floating = true } },
    { rule = { class = "libreoffice" }, properties = { tag = tags [1][3], floating = true } },
    { rule = { class = "MPlayer" }, properties = { tag = tags [1][5], floating = true } },
    { rule = { class = "Vlc" }, properties = { tag = tags [1][5], floating = true } },
    { rule = { class = "FBReader" }, properties = { tag = tags [1][5], floating = true } },
    { rule = { class = "feh" }, properties = { floating = true } },
    { rule = { class = "Gpicview" }, properties = { tag = tags [1][5], floating = true, maximized_vertical = true, maximized_horizontal = true } },
    { rule = { class = "Zathura" }, properties = { tag = tags [1][3] } },
    { rule = { class = "gimp" }, properties = { floating = true } },
    { rule = { class = "Chromium" }, properties = { tag = tags [1][2] } },
    { rule = { class = "luakit" }, properties = { tag = tags [1][2] } },
    { rule = { name = "crawl" }, properties = { tag = tags [1][4] } },
    { rule = { name = "nethack" }, properties = { tag = tags [1][4] } },
    { rule = { class = "Xephyr" }, properties = { tag = tags [1][3], floating = true } },
}

-- {{{ Signals

batwidget:add_signal('mouse::enter', function()
                                        local fd = nil
                                        fd = io.popen("acpi -btai")
                                        local d = fd:read("*all"):gsub("\n+$", "")
                                        fd:close()
                                        batinfo = {
                                           naughty.notify({
                                                          text         = d
                                                          , timeout    = 0
                                                          , position   = "bottom_right"
                                                       })
                                        }
                                     end)
batwidget:add_signal('mouse::leave', function () naughty.destroy(batinfo[1]) end)

-- Signal function to execute when a new client appears.
client.add_signal("manage", function (c, startup)
    -- Add a titlebar
    -- awful.titlebar.add(c, { modkey = modkey })

    -- Enable sloppy focus
    c:add_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end
end)

function run_once(cmd)
    findme = cmd
    firstspace = cmd:find(" ")
    if firstspace then
        findme = cmd:sub(0, firstspace-1)
    end
    awful.util.spawn_with_shell("pgrep -u $USER -x " .. findme .. ">/dev/null||(" .. cmd .. ")")
end

run_once("volumeicon")
