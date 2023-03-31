config.load_autoconfig(False)
config.set('auto_save.session', True)
config.set('url.default_page', 'https://google.com')
config.set('url.start_pages', ['https://google.com'])
config.set('url.searchengines', {
    "DEFAULT": 'https://google.com/search?q={}',
    "yt": 'https://youtube.com/results?search_query={}',
    "am": 'https://amazon.co.uk/s?k={}'
})

config.bind('<Ctrl-h>', 'tab-prev')
config.bind('<Ctrl-l>', 'tab-next')
