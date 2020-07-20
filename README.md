# Gsutil-extra

This repo contains a command-line wrapper around [`gsutil`][gsutil]. It
augments Google’s tool with extra capabilities while retaining full
compatibility.

It works by rewriting the commands you type before passing them to `gsutil`.

[gsutil]: https://cloud.google.com/storage/docs/gsutil

## Install

Drop `gsutil` somewhere in your `PATH`, _before_ Google Cloud’s `bin`
directory. `which -a gsutil` should show _this_ `gsutil` first, then Google’s.

The script should find Google’s `gsutil` by itself, but if it doesn’t you can
tell it by setting the environment variable `GSUTIL_EXTRA_GSUTIL_PATH`.

You need to have Ruby installed.

## Usage

The new `gsutil` works exactly like Google’s one.

### Extra features

The config for those extra features is stored in `~/.gsutil-extra.yml`.

#### HTTPS URLs

`https://` URLs are automatically transformed into their `gs://` counterpart.

```shell
# normal gsutil
% gsutil ls https://console.cloud.google.com/storage/browser/my-bucket/foo
InvalidUrlError: Unrecognized scheme "https".

# gsutil-extra
% gsutil ls https://console.cloud.google.com/storage/browser/my-bucket/foo
gs://my-bucket/foo/bar-1.csv
gs://my-bucket/foo/bar-2.csv
gs://my-bucket/foo/bar-3.csv
...
```

See [gs2http][] to transform `gs://` URLs back to HTTPS in your browser.

[gs2http]: https://oscaro.github.io/gs2http/

#### Aliases

Aliases are stored in the config under the `aliases` key. They allow you to use
a special `@` syntax to save keystrokes on the paths you use the most often.

For example:
```yaml
# in ~/.gsutil-extra.yml
aliases:
  b: my-bucket
```

If you then use a path that starts with `@b` anywhere in any `gsutil`
command, it’ll replace it with `gs://my-bucket`.

```shell
# what you type
gsutil ls @b/banana

# what gsutil sees
gsutil ls gs://my-bucket/banana
```

Print all aliases with `gsutil aliases`:
```
$ gsutil aliases
@b = gs://my-bucket
```

#### git-like custom commands

If `gsutil-foo` is an executable in your `$PATH`, it’ll be called if you type
`gsutil foo ...`.

#### `:latest` shortcut

If you use `:latest` in a path component, it’s automatically replaced by the
last one of the possible values, lexicographically sorted.

For example:
```shell
% gsutil ls gs://my-bucket/banana/foo
gs://my-bucket/banana/foo/2016/
gs://my-bucket/banana/foo/2017/
gs://my-bucket/banana/foo/2018/

# what you type
% gsutil ls gs://my-bucket/banana/foo/:latest/
# what gsutil sees
% gsutil ls gs://my-bucket/banana/foo/2018/
```

Aliases can include it as well:

```yaml
aliases:
  lastbanana: my-bucket/banana/foo/:latest/
```

Note it’s slower than using the real value because we need to run a `gsutil ls`
first to get all possible values.

You can’t use `:latest` twice in the same URL.

#### Implicit arguments

If `settings.always_parallelize` is `true` in the config, a `-m` option is
automatically prepended to `cp`, `mv`, and `rm` commands, if not already
present.

```yaml
# in ~/.gsutil-extra.yml
settings:
  always_parallelize: true
```

```shell
# what you type
gsutil cp mydir gs://foo/

# what gsutil sees
gsutil -m cp mydir gs://foo/
```

### Bash completion

An experimental Bash completion script is provided (see
`gsutil-completion.bash`) but it’s not compatible with Google Cloud’s. It only
completes custom paths:

```shell
% gsutil ls @b/banana/foo/:latest/<tab>

# this is transformed into:
% gsutil ls gs://my-bucket/banana/foo/2018/
```

It doesn’t complete partial paths nor commands nor arguments.

## License

Copyright © 2017-2020 Oscaro
