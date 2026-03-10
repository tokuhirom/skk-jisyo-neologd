# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Converts mecab-ipadic-neologd dictionary into SKK-JISYO format. The output is `SKK-JISYO.neologd`, an EUC-JP encoded SKK dictionary file.

## Build Command

```
perl download.pl
```

This downloads the latest neologd seed dictionary, filters/converts entries, and produces `SKK-JISYO.neologd` via `skkdic-expr2`.

### Prerequisites

- Perl 5.10+
- `skktools` (provides `skkdic-expr2`)
- CPAN modules: `LWP::UserAgent`, `LWP::Protocol::https`, `Lingua::JA::Regular::Unicode`

Install deps: `cpanm -nv LWP::UserAgent LWP::Protocol::https Lingua::JA::Regular::Unicode`

## Architecture

Single-script project (`download.pl`) with three phases:

1. **Version detection** (`get_neologd_version`): Scrapes the neologd GitHub repo for the latest seed file version
2. **Download** (`download_dict`): Fetches and extracts the `.csv.xz` seed dictionary
3. **Conversion** (`main`): Parses mecab CSV entries, filters by part-of-speech and various heuristics, converts katakana readings to hiragana, validates EUC-JP encoding, sorts candidates by mecab cost, and outputs SKK dictionary format

### Key filtering rules in download.pl

- Only 名詞 (nouns) with 一般名詞 or 固有名詞 subtypes
- Excludes 地域 (region) entries
- Various character/length filters (ASCII-only, single-char, >20 chars, etc.)
- Entries must be valid in EUC-JP encoding

## CI

GitHub Actions workflow (`.github/workflows/update-dict.yml`) runs `perl download.pl` on a schedule (every 3 days) and auto-commits updated dictionary to master.
