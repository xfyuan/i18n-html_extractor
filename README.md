I18n HTML Extractor
---------------

A set of rake tasks to extract strings from html templates into locale files.

# Upgrades (2021 by xfyuan)

- add support for rails 6.x
- add many more erb directives support by regexp: link_to, content_for, select, xxx_tag, etc
- support rails-react's react_component method

# Introduction

I created this gem to resolve a practical problem: I had to deal with a big Rails project that had no i18n locales at all.

It's not yet 100% functional, but I'd like to improve it.

# Installation

It's not yet published as a gem, since it's not ready, but you can start use it by adding it to you Gemfile:

```ruby
gem 'i18n-html_extractor', github: 'xfyuan/i18n-html_extractor'
```

# How it works

It scans all your HTML templates for strings and moves them to locales file.

It's made of three rake tasks:

### List-only Mode

Running `rake i18n:extract_html:list`, you'll get a report of all files that contains strings that should be translated.

### Automatic Mode (Upgrade by xfyuan)

- Running `rake i18n:extract_html:auto`, all strings are moved to i18n all locale files.
- Running `rake i18n:extract_html:auto[app/views/users/_base.html.erb]`, all strings in that file are moved to i18n all locale files.
- Running `rake 'i18n:extract_html:auto[app/views/users/_base.html.erb, zh-CN]'`, all strings in that file are moved to i18n locale zh-CN file.
- Running `rake i18n:extract_html:auto[app/views/users/**/*.erb]`, all strings in `*.erb` files of `app/views/users` folders are moved to i18n all locale files.

### Interactive Mode

Running `rake i18n:extract_html:interactive`, you can decide, for every string, which one to move to translation, and it's translation for every language.
