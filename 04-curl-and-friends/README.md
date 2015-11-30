# curl and friends

If you haven't done so already, please clone the git repo and `cd` into the `04-curl-and-friends` directory.

## curl and wget

`curl` and `wget` are quite similar tools. They are both used to download stuff from the Internet, but they are generally used for slightly different things:

* Use `wget` when you need to download a file and save it somewhere
* Use `curl` when you need to send a request to an HTTP API and view the response

## wget

Note: `wget` is not installed on OS X by default. Install it with Homebrew: `brew install wget`

```
$ wget http://www.google.com/robots.txt  ## download a file and save it in the current dir

$ wget -O /tmp/robotzzz.txt http://www.google.com/robots.txt  ## download a file and save it in a specific place
```

Not much more to say about `wget`. It's about as simple as it gets.

## curl

Unlike `wget`, which downloads the response to a file, `curl` writes the HTTP response body to stdout by default:

```
$ curl http://www.google.com/robots.txt | head
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100  7599    0  7599    0     0   265k      0 --:--:-- --:--:-- --:--:--  274k
User-agent: *
Disallow: /search
Allow: /search/about
Disallow: /sdch
Disallow: /groups
Disallow: /catalogs
Allow: /catalogs/about
Allow: /catalogs/p?
Disallow: /catalogues
Allow: /newsalerts
```

It also writes its progress to stderr. Use `-s` ("silent") to suppress this:

```
$ curl -s http://www.google.com/robots.txt | head
User-agent: *
Disallow: /search
Allow: /search/about
Disallow: /sdch
Disallow: /groups
Disallow: /catalogs
Allow: /catalogs/about
Allow: /catalogs/p?
Disallow: /catalogues
Allow: /newsalerts
```

Use `-v` ("verbose") to print out useful stuff like the request and response headers and the response's status code:

```
$ curl -s -v http://www.google.com/robots.txt 1>/dev/null
* Adding handle: conn: 0x7fdc34003a00
* Adding handle: send: 0
* Adding handle: recv: 0
* Curl_addHandleToPipeline: length: 1
* - Conn 0 (0x7fdc34003a00) send_pipe: 1, recv_pipe: 0
* About to connect() to www.google.com port 80 (#0)
*   Trying 64.233.184.106...
* Connected to www.google.com (64.233.184.106) port 80 (#0)
> GET /robots.txt HTTP/1.1
> User-Agent: curl/7.30.0
> Host: www.google.com
> Accept: */*
>
< HTTP/1.1 200 OK
< Vary: Accept-Encoding
< Content-Type: text/plain
< Date: Mon, 30 Nov 2015 15:33:34 GMT
< Expires: Mon, 30 Nov 2015 15:33:34 GMT
< Cache-Control: private, max-age=0
< Last-Modified: Thu, 12 Nov 2015 23:03:44 GMT
< X-Content-Type-Options: nosniff
* Server sffe is not blacklisted
< Server: sffe
< X-XSS-Protection: 1; mode=block
< Accept-Ranges: none
< Transfer-Encoding: chunked
<
{ [data not shown]
* Connection #0 to host www.google.com left intact
```

A useful feature of `curl`, quite rare amongst UNIX commands, is that you can pass the options and arguments in any order. e.g. you can write options such as `-v` after the URL: `$ curl http://www.google.com/robots.txt -v`.

### URL parameters

To pass parameters in the URL's query string, just include them in the URL:

```
$ curl 'http://my-api.com/search?q=hello&page-size=10'
```

Note: Depending on how your shell is configured, you will probably need to add single-quotes around the URL to stop the shell from interpreting the `&` and `?` characters.

### POSTing data

By default `curl` sends a `GET` request. You can change this using `-X`:

```
$ curl -X POST http://my-api.com/things
```

When sending a `POST` request, you usually want to send some data, e.g. as form fields or as JSON.

You can pass form fields using `-d` or `--data`:

```
$ curl -X POST http://my-api.com/things -d "name=Chris" -d "age=31"
```

Note: Using `-d` automatically implies `-X POST`, but I usually write it anyway just for better readability when I revisit the command later.

If you want to send form values that contain weird characters such as slashes, you need to tell `curl` to escape them:

```
$ curl -X POST http://my-api.com/things --data-urlencode "name=foo/%(bar)" -d "age=31"
```

You can also send a JSON body (or any other text) using `-d`:

```
$ curl -X POST http://my-api.com/things -d '{ "name": "Chris", "age": 31 }'
```

If you have a huge chunk of json to send, it may be easier to save it as a file and reference it using an `@`:

```
$ curl -X POST http://my-api.com/things -d @input.json
```

### Exercise

Perform a search on the Guardian Content API using curl. The URL is `http://content.guardianapis.com/search`. You will need to pass a URL parameter with the name `api-key` and the value `test`. CAPI should respond with a load of JSON.

## jq

`jq` is a tool for viewing, filtering and transforming JSON. If you work with JSON a lot, it's a lifesaver.

It can be installed with Homebrew: `brew install jq`.

The manual is excellent: [https://stedolan.github.io/jq/manual/](https://stedolan.github.io/jq/manual/)

### Hello jq!

Repeat the `curl` command you used to query the Content API, but this time pipe the result to `jq .`:

```
$ curl -s 'http://content.guardianapis.com/search?api-key=test' | jq .
```

Now the JSON response should be nicely formatted and colourful.

We have run `jq` by passing it an expression (`.`) and giving it some json on its stdin. It outputs its result to stdout.

`.` is the simplest possible filter. It simply returns its input, with the nice side-effect of formatting it prettily.

### Extracting values

Use dot-notation to only show some of the JSON:

```
$ json='
{
  "user": {
    "name": "Chris",
    "dob": {
      "year": 1984,
      "month": 8,
      "day": 27
    }
  }
}'

$ echo $json | jq .user.dob
{
  "year": 1984,
  "month": 8,
  "day": 27
}

$ echo $json | jq .user.dob.year
1984
```

To extract fields from elements of arrays, the syntax is a little bit different:

```
$ json='
{
  "users": [
    {
      "name": "Chris",
      "age": 31
    }, {
      "name": "Dave",
      "age": 99
    }
  ]
}'

$ echo $json | jq '.users[].name'
"Chris"
"Dave"
```

### Mapping over arrays

You can use `jq` to transform json, e.g. to rename fields or to flatten a nested structure.

A commonly used function is `map`, which takes a filter and applies it to every element of an array, returning a new array.

```
$ echo $json | jq '.users | map(.name)'
[
  "Chris",
  "Dave"
]
```

### Exercises

1. Use `curl` to search the Content API and `jq` to print out the `webTitle` field of each result.

2. Now alter your `jq` expression to print out both the `id` and `webTitle` fields. Rename `id` to `path`, and `webTitle` to `title`. The result should look like this. (Hint: use the `map` filter, and read [the manual](https://stedolan.github.io/jq/manual/)).

    ```
    [
      {
        "path": "politics/blog/live/2015/nov/30/corbyn-plp-syria-free-vote-mps-a-free-vote-on-syria-would-give-cameron-victory-on-a-plate-politics-live",
        "title": "PLP meets after Corbyn agrees free vote on Syria airstrikes - Politics live"
      },
      {
        "path": "sport/live/2015/nov/30/pakistan-v-england-third-t20-international-live",
        "title": "Pakistan v England: third T20 international – live!"
      },
      {
        "path": "sport/2015/nov/30/brady-has-never-been-so-pissed-off-after-loss-but-gronkowski-fears-ease",
        "title": "Brady has never been 'so pissed off' after loss but Gronkowski fears ease"
      },
      ...
    ]
    ```

### Special mention: xmllint

If XML is your bag, `xmllint` can pretty-print it for you:

```
$ curl -s 'http://content.guardianapis.com/search?api-key=test&format=xml' | xmllint --format -
<?xml version="1.0"?>
<response status="ok" user-tier="developer" total="1833801" current-page="1" pages="183381" start-index="1" page-size="10" order-by="newest">
  <results>
    <result web-url="http://www.theguardian.com/politics/blog/live/2015/nov/30/corbyn-plp-syria-free-vote-mps-a-free-vote-on-syria-would-give-cameron-victory-on-a-plate-politics-live" type="liveblog" section-id="politics" web-title="PLP meets after Corbyn agrees free vote on Syria airstrikes - Politics live" api-url="http://content.guardianapis.com/politics/blog/live/2015/nov/30/corbyn-plp-syria-free-vote-mps-a-free-vote-on-syria-would-give-cameron-victory-on-a-plate-politics-live" section-name="Politics" web-publication-date="2015-11-30T18:19:41Z" id="politics/blog/live/2015/nov/30/corbyn-plp-syria-free-vote-mps-a-free-vote-on-syria-would-give-cameron-victory-on-a-plate-politics-live"/>
    ...
```

## tmux

This is super-special bonus content that has nothing to do with `wget`, `curl` or `jq`.

`tmux` (short for "terminal multiplexer") lets you run multiple shells at the same time, arrange them into windows and panes, resize them, jump between them, etc.

To install on OS X, use Homebrew: `brew install tmux`. To run, simply type `tmux`.

`tmux` reads its config from `~/.tmux.conf`. I'll go through my `.tmux.conf`, explaining `tmux`'s features as I go.

```
$ cat ~/.tmux.conf
# Bind C-a, like screen
set -g prefix C-a
unbind C-b
bind C-a send-prefix

unbind %
bind \ split-window -h -c "#{pane_current_path}"
bind - split-window -v -c "#{pane_current_path}"
bind c new-window -c "#{pane_current_path}"
bind k select-pane -U
bind j select-pane -D
bind h select-pane -L
bind l select-pane -R
bind v last-window

# Arrow keys for resizing panes
bind -r Left resize-pane -L
bind -r Right resize-pane -R
bind -r Up resize-pane -U
bind -r Down resize-pane -D

# To move a window to a new pane in this window
bind @ command-prompt -p "create pane from:"  "join-pane -s ':%%'"

# Sane scrolling
set -g terminal-overrides 'xterm*:smcup@:rmcup@'
set-window-option -g mode-mouse on

# Use ZSH as shell
set-option -g default-shell /usr/local/bin/zsh

# Enable copy-paste
set-option -g default-command "reattach-to-user-namespace -l zsh"

# Use vim keybindings in copy mode
setw -g mode-keys vi

# Setup 'v' to begin selection as in Vim
bind -t vi-copy v begin-selection
bind -t vi-copy y copy-pipe "reattach-to-user-namespace pbcopy"

# Update default binding of `Enter` to also use copy-pipe
unbind -t vi-copy Enter
bind -t vi-copy Enter copy-pipe "reattach-to-user-namespace pbcopy"

# List of plugins
# Supports `github_username/repo` or full git URLs
set -g @tpm_plugins "              \
  tmux-plugins/tpm                 \
  tmux-plugins/tmux-resurrect      \
"
# Other examples:
# github_username/plugin_name    \
# git@github.com/user/plugin     \
# git@bitbucket.com/user/plugin  \

# initializes TMUX plugin manager
run-shell ~/.tmux/plugins/tpm/tpm
```
