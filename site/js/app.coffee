
BLOG_RSS = 'http://rss.indiedb.com/games/quarries-of-scred/news/feed/rss.xml'
DOWNLOAD_RSS = 'http://rss.indiedb.com/games/quarries-of-scred/downloads/feed/rss.xml'

ytplayer = null

initBlogFeed = ->
    $.ajax
        url: document.location.protocol + '//ajax.googleapis.com/ajax/services/feed/load?v=1.0&num=10&callback=?&q=' + encodeURIComponent(BLOG_RSS)
        dataType: 'json'
        # complete: ->
        #     displayContent()
        success: (data) ->
            if (data.responseData.feed && data.responseData.feed.entries)
                $.each data.responseData.feed.entries, (i, e) ->
                    console.trace(e)
                    articleDate = moment(e.publishedDate).format('MMMM Do YYYY')
                    link = e.link
                    title = '<a class="btn btn-default" href="' + link + '">' + e.title + '</a>'
                    dateLine = '<h2 class="article-date">' + articleDate + '</h2>'
                    thumbnail = '<a href="' + link + '"><img src="' + e.mediaGroups[0].contents[0].url + '" /></a>'

                    $('#blog-div').append title
                    $('#blog-div').append dateLine
                    $('#blog-div').append thumbnail

initDownloadFeed = ->
    $.ajax
        url: document.location.protocol + '//ajax.googleapis.com/ajax/services/feed/load?v=1.0&num=10&callback=?&q=' + encodeURIComponent(DOWNLOAD_RSS)
        dataType: 'json'
        # complete: ->
        #     displayContent()
        success: (data) ->
            if (data.responseData.feed && data.responseData.feed.entries)
                e = data.responseData.feed.entries[0]
                downloadLink = e.link
                $('.download-link').attr 'href', downloadLink

window.onYouTubePlayerReady = (playerId) ->
    ytplayer = document.getElementById("myytplayer");
    ytplayer.addEventListener("onStateChange", "onytplayerStateChange");

window.onytplayerStateChange = (newState) ->
    if newState is 1
        $('#vid-div').css 'z-index', 1001
    else
        $('#vid-div').css 'z-index', 1

window.loadytvideo = (videoId) ->
    ytplayer.loadVideoById videoId

animMonster = (monster) ->
    $(monster)
        .animate({bottom: '+=20px'}, 3000)
        .animate({bottom: '-=20px'}, 3000, -> 
            timespan = Math.floor(Math.random() * 300) + 200
            setTimeout animMonster, timespan, monster
        )

animStone = (stone) ->
    $(stone)
        .animate({right: '+=3px'}, 200)
        .animate({right: '-=3px'}, 200, -> 
            timespan = Math.floor(Math.random() * 50) + 50
            setTimeout animStone, timespan, stone
        )

$(window).load ->
    initBlogFeed()
    initDownloadFeed()

    params = { allowScriptAccess: "always" };
    atts = { id: "myytplayer" };
    swfobject.embedSWF("http://www.youtube.com/v/nc4V1j-rvq0?enablejsapi=1&playerapiid=ytplayer&version=3", 
                        "youtube", "425", "356", "8", null, null, params, atts);

    $('.monster').each ->
        animMonster(this)

    $('.stone').each ->
        animStone(this)

