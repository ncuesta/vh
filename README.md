# vh

Virtual Hosts manager for the CLI -- a dead simple script to add new virtual hosts
that will ease the local development of web apps with Apache.

**This is currently a WIP so things will not likely work** :)

## Prerequisites

Add this line to your `/etc/apache2/httpd.conf`:

    Include /etc/apache2/extra/httpd-vhosts.conf

## Installation

Add this line to your application's Gemfile:

    gem 'vh'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install vh

## Usage

Running `vh` is pretty straight-forward:

    vh path hostname

Where:

   * `path` is the path to the `DocumentRoot` of the Virtual Host, and
   * `hostname` is the hostname that will be used locally for the VH.

## License

```
Copyright (c) 2012 José Nahuel Cuesta Luengo

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
```
