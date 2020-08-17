#!/usr/bin/perl
use strict;
use warnings;
use utf8;
use v5.10.0;
use LWP::UserAgent;
use Encode ();
use Lingua::JA::Regular::Unicode qw/katakana2hiragana/;

binmode(STDOUT, ":utf8");

my $force = 0;

&main; exit;

sub main {
    my $neologd_version = get_neologd_version();
    my $fname = download_dict($neologd_version, $force);

    open my $fh, '<:encoding(utf-8)', $fname
        or die "Cannot open $fname: $!";
    my $ofname = 'SKK-JISYO.neologd.src';
    open my $ofh, '>', $ofname
        or die "Cannot open $ofname";

    while (<$fh>) {
        chomp;
        my @s = split /,/, $_;
        my ($表層形, $左文脈ID, $右文脈ID, $コスト, $品詞1, $品詞2, $品詞3, $品詞4, $品詞5, $品詞6, $原形, $読み, $発音) = split /,/, $_;

        next if $表層形 =~ /^[#\$\(-]/;
        # 数字から始まる表記を除外
        next if $表層形 =~ /^[0-9]/;
        next if $品詞1 ne '名詞';
        next if $品詞2 ne '一般名詞' && $品詞2 ne '固有名詞';
        next if $品詞3 eq '地域';
        next if $表層形 ne $原形; # 表記と原形が一致しないエントリを除外
        next if $表層形 =~ /\[/; # \[ が入っていると skkdic-expr2 が segv するし、読みがなに記号が入っているのはおかしい。
        next if $表層形 =~ /;/; # ; は SKK 辞書的にはコメント。
        next if $表層形 =~ /，/; # 全角コンマ入りのエントリには有用なものはなさそうだった。

		# 表記が20文字を超える場合は除外
        next if length($表層形) > 20;
		# シングルバイト文字のみの表記を除外
        next if $表層形 =~ /^\p{ASCII}+$/;
		# 1文字の表記を除外
        next if length($表層形) == 1;
		# 数字を3個以上含む表記を除外
        next if $表層形 =~ /\d+.*\d.*\d/;
		# 頻出表現をもじった表記を除外（一花カナウ いつかかなう）
		next if $表層形 eq '一花カナウ';
		next if $表層形 =~ /!$/; # /朝ズバッ!/ のようなエントリを除外
        next if $表層形 eq $読み;

        my $よみ = katakana2hiragana($読み);
        eval {
            say {$ofh} Encode::encode('euc-jp', "${よみ} /${表層形}/", Encode::FB_CROAK);
        };
        die $@ if $@ && $@ !~ /does not map to euc-jp/;
    }

    system('skkdic-expr2 -o SKK-JISYO.neologd SKK-JISYO.neologd.src') == 0
        or die "Cannot cleanup the dictionary";
}

sub get_neologd_version {
    my $url = "https://github.com/neologd/mecab-ipadic-neologd/tree/master/seed";
    my $ua = LWP::UserAgent->new();
    my $res = $ua->get($url);
    $res->is_success or die "Cannot get $url: " . $res->status_line;
    if ($res->content =~ /mecab-user-dict-seed.(\S+)\.csv.xz/) {
        return $1;
    } else {
        die "Cannot parse version number from $url: " . $res->content;
    }
}

sub download_dict {
    my ($neologd_version, $force) = shift;

    my $xz_fname = "mecab-user-dict-seed.${neologd_version}.csv.xz";

    my $txt_fname = $xz_fname;
    $txt_fname =~ s/\.xz$//;

    if ((!-e $txt_fname) || $force) {
        unlink $xz_fname if $xz_fname;

        my $url = "https://github.com/neologd/mecab-ipadic-neologd/raw/master/seed/${xz_fname}";
        system('wget', '-nc', $url) == 0
            or die "Cannot download $url";

        system('xz', '-d', $xz_fname) == 0
            or die "Cannot extract $xz_fname";
    }

    return $txt_fname;
}


__END__

=head1 LICENSE

        The MIT License (MIT)

        Copyright © 2020 Tokuhiro Matsuno, http://64p.org/ <tokuhirom@gmail.com>

        Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

        The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

        THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

