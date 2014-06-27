== Freeze

Freeze is my app for keeping bookmarked what I've seen on the internet. It is like the old google reader or tinytinyRSS. I just have added some features that I need and I am going to extend it.

I feel it is really important to keep stored what I find interesting on the internet. I felt so many times that I can't find something that I have already read. With this app, I can add tags and comments in an article, add it to a category or star it. Through the application I can distiguish the articles I read, saw or clicked (and ordered them by date).

Browser bookmarking isn't enough because I am using many devices. I also want a fast search, taggings, comments and some additional functionality.

I also want to fetch facebook, twitter, stackoverflow, github, youtube updates and have all the information in one place.

=== Usage
It is a typical Rails 4.1 app with ruby 2.1.2. It depends on redis and sidekiq for fetching the feeds as a background job. I have used sidetiq to schedule the feed fetching every 15 minutes. Follow the steps to grab the app:
1. `git clone git@github.com:johndel/freeze.git`
2. bundle
3. change database.yml
4. check the db/seeds and change the user as you wish. I have my feeds that I follow, so make sure to add yours (or suggest me some more to follow!)
5. run `rake db:dev:init` (check the custom rake command at lib/tasks/db.rake). This command will also add my feeds, remove the 03_feeds.rb if you don't want them
6. run `sidekiq` and add it as a daemon if you want it to always run

=== Further information
It fetches the feeds every 15 minutes. If you want to change it go to `workers/article_fetcher.rb`. If you have questions, check sidetiq
I have the following functionality which I really wanted and I haven't found it in any other rss reader:
- **seen**: When I hover on an article, I want it to be marked as read and as seen.
- **clicked**: When I click on an article I want it to be marked as clicked.
- **starred**: The classic starred article which many rss readers have.

The reason of the above (seen and clicked tracking) is that I have gathered many feeds and I don't know which one really interested me and which one I skipped. I was seeing and choosing what to read by instinct. So with the above additions, I can track which feeds I usually see but don't click, which I click and which I skip by clicking "Mark it all as read" (and I don't see at all). I will create also a page with basic statistics for them.

I also have a *worked* fields on the feeds which I use for tracking when a feed is dead. With this, I won't have unecessary feeds which won't work.

=== TODO
- Add the functionality for adding comments and tags on each article.
- Add the above fetchers so I will have all the information I want in one place. I also plan to add custom articles when I want to.
- Add search (preferably elasticsearch) for making really easy to find the information I want.
- Import/Export functionality. The import can be done with a bit manual way right now.
- Check valid feeds as a background job every week.
- Add realtime unread articles. I may do it by adding in the frontend an ember app and some node.js.
- Add amazon RDS database in order not to lose anything, ever.
- Use it and improve the UI to fit my needs. There are lots of nice UI/UX things that google reader has done correctly. TinyTiny has also some nice things (like showing the count of the unread articles on the title), so I am going to add them as well.

Tell me a feature that you want and I may add it! Just have in mind that this app is maybe the most used app by me, so I am really opinionated about how I want it to be. I hope you like it, if not just change it to your needs (and tell me the feature because I may haven't thought about it)!





