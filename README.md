# skk-jisyo-neologd

mecab-ipadic-neologd を SKK辞書形式に変換した辞書です。

## Download

[GitHub Releases](https://github.com/tokuhirom/skk-jisyo-neologd/releases) から `SKK-JISYO.neologd` をダウンロードしてください。

## Build for yourself

### Prerequisites

skktools, Perl 5.10+ and following CPAN modules.

    cpanm -nv Lingua::JA::Regular::Unicode

### Run

    perl download.pl 20200910

## Thanks to

This script is based on a script in the mozc-ut.

 * http://linuxplayers.g1.xrea.com/mozc-ut.html
 * https://osdn.net/users/utuhiro/pf/utuhiro/files/

And, the dictionary was generated from mecab-ipadic-neologd.

 * https://github.com/neologd/mecab-ipadic-neologd
