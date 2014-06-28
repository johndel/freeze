$ ->
  $(".category_link").on "dblclick", ->
    $(this).next(".category_feeds").slideToggle()

  $(".show_all_articles").on "click", ->
    $(".article").show()

  $(".article.unread").hover ->
    $(this).removeClass("unread").addClass("read")
    $(this).unbind('mouseenter').unbind('mouseleave')
    articleid = $(this).data("articleid")
    $.ajax
      type: "PUT"
      url: "articles/" + articleid + "/read"

  $(".remove_article").on "click", ->
    $(this).parent().parent().remove()
    category = $(".list-group-item[data-categoryid=" + $(this).data("categoryid") + "]")
    category_badge = $(".list-group-item[data-categoryid=" + $(this).data("categoryid") + "]").find(".badge:first")

    feedid = $(this).data("feedid")
    feed_badge = $(".feed_list a[data-feedid=" + feedid + "] .badge")
    feed_text = feed_badge.text()
    if(feed_text > 1)
      feed_badge.text(feed_text - 1)
    else
      $(".feed_list a[data-feedid=" + feedid + "]").parent().remove();
    if(category_badge.text() > 1)
      category_badge.text(category_badge.text() - 1)
    else
      category.remove()
    $(".show_all_articles .badge").text($(".show_all_articles .badge").text() - 1)


  $(".article_title_link").on "mousedown", ->
    this_article = $(this)
    articleid = this_article.data("articleid")
    $.ajax(
      type: "PUT"
      url: "articles/" + articleid + "/click"
    )

  $(".unread_feed").on "click", ->
    feedid = $(this).data("feedid")
    $(".article").hide()
    $(".article[data-feedid=" + feedid + "]").show()

  $(".unread_feed").on "dblclick", ->
    feed = $(this)
    feedid = $(this).data("feedid")
    feed_badge = $(".feed_list a[data-feedid=" + feedid + "] .badge")
    $(".show_all_articles .badge").text(parseInt($(".show_all_articles .badge").text()) - parseInt(feed_badge.text()))
    $.ajax(
      type: "PUT"
      url: "/feeds/" + feedid + "/read_all"
    ).done ->
      if(feed.parent().parent().children().size() == 1)
        feed.parent().parent().remove()
      else
        feed.parent().remove()
      $(".article[data-feedid=" + feedid + "]").remove()
      # if()
