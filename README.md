# LilBloggy
#### An itty-bitty teenie-weenie tinny-little blogging app!

LilBloggy is a simple and minimal blogging web app that's designed to do only what it needs to, and to look good while doing it! LilBloggy doesn't solve any heretofore unsolved problems and it doesn't bring anything new or radical to the table. I don't expect anyone else will ever use. I wanted to start blogging and felt that, as a web app developer, it would be pretty silly to use someone else's package when a blog would be a fun little project to take on! That said, if anyone finds it useful that would be the icing on the cake!

## Config
TODO

## Themes
TODO

## Vue Components
LilBloggy uses VueJS single file components rather than traditional Ruby server-side templating and rendering. LilBloggy does this using my VueCK gem rather than depending on a server-side Javascript stack. Go check out VueCK for more info on that.

## Component Generator
Create a new component via the `new_vue` rake task:
```bash
$ rake new_vue test
created vue/test.vue
```
