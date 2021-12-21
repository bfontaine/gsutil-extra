# gsutil-extra Changelog

## Unreleased

* Add support for URLs like `https://console.cloud.google.com/storage/browser/mybucket;tab=objects?...`

## 0.1.2 (2020/07/20)

* Improve the way we find the original `gsutil`
* Fix code for older Rubies
* Add support for URL `https://console.cloud.google.com/storage/browser`
* Fix HTTPS->GS for `_details` URLs
* Fix URL-encoded paths

## 0.1.1 (2018/09/06)

* Automatically find the original `gsutil`
* Support `GSUTIL_EXTRA_GSUTIL_PATH`
* Fix the code for Ruby 2.3

## 0.1.0 (2018/08/29)

First public release.
