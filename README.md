# skk-jisyo-neologd

## What's this?

Convert neologd to the SKK-JISYO format.

## Build for yourself

### required environment

Perl 5.10+ and following CPAN modules.

    cpanm -nv LWP::UserAgent LWP::Protocol::https Lingua::JA::Regular::Unicode

### Run the commands

    perl download.pl

## THANKS TO

This script is based on a script in the mozc-ut.

 * http://linuxplayers.g1.xrea.com/mozc-ut.html
 * https://osdn.net/users/utuhiro/pf/utuhiro/files/

And, the dictionary was generated from mecab-ipadic-neologd.

 * https://github.com/neologd/mecab-ipadic-neologd

## LICENSE

        The MIT License (MIT)

        Copyright © 2020 Tokuhiro Matsuno, http://64p.org/ <tokuhirom@gmail.com>

        Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

        The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

        THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

