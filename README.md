# skk-jisyo-neologd

## What's this?

Convert neologd to the SKK-JISYO format.

## Build for yourself

### required environment

skktools, Perl 5.10+ and following CPAN modules.

    cpanm -nv LWP::UserAgent LWP::Protocol::https Lingua::JA::Regular::Unicode

### Run the commands

    perl download.pl

## THANKS TO

This script is based on a script in the mozc-ut.

 * http://linuxplayers.g1.xrea.com/mozc-ut.html
 * https://osdn.net/users/utuhiro/pf/utuhiro/files/

And, the dictionary was generated from mecab-ipadic-neologd.

 * https://github.com/neologd/mecab-ipadic-neologd

