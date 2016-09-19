#!/usr/bin/perl
#
# getquote
#
# Get quotes for various markets with a focus on cryptocurrencies
#
# Markets:
#
# BitcoinAverage (BTC/USD)
# Coinabul (Gold, Silver)
# Havelock Investments
# Cryptostocks
# Google Finance
# Rate-Exchange
#

use strict;

use Finance::Quote;
use HTTP::Request;
use LWP::UserAgent;
use JSON;
use POSIX qw(strftime);

my $timeout = 60;

my $symbol = $ARGV[0];
my $price;

if (!$symbol) {
    print STDERR "Usage: getquote TICKER\n";
    exit 1;
}

sub request {
    my $url = shift;
    print STDERR "Looking up $symbol\n";
    my $req = HTTP::Request->new('GET', $url);
    my $ua = LWP::UserAgent->new(agent => 'perl/' . $^V);
    $ua->timeout($timeout);
    $ua->ssl_opts(verify_hostname => 0);
    my $res = $ua->request($req);
    return $res->is_success ? $res->decoded_content : undef;
}

sub json_req {
    my $content = request(shift);
    return $content ? decode_json($content) : undef;
}

sub getquote {
    if ($symbol eq '$' or $symbol eq 'USD') {
        if (my $ticker = json_req('https://api.bitcoinaverage.com/ticker/USD')) {
            return sprintf '%.8f BTC', 1/$ticker->{last};
        }
    }

    if ($symbol eq 'BTC') {
        if (my $ticker = json_req('https://api.bitcoinaverage.com/ticker/USD')) {
            return '$' . $ticker->{last};
        }
    }

    my %coinabul_markets = (
        AU => 'Gold',
        AG => 'Silver',
    );

    my %poloniex_markets = (
        ETH => 'USDT',
        PPC => 'BTC',
        LTC => 'USDT',
        XPM => 'BTC',
        NMC => 'BTC',
    );

    my %cryptostocks_markets = (
        BTCINVEST => 1,
        GREEN => 1,
    );

    my %havelock_markets = (
        KCIM => 1,
        AM => 'AM1',
        HIF => 1,
        MS => 1,
        RENT => 1,
        SFI => 1,
        VTX => 1
    );

    my %rateexchange_markets = (
        '€' => 'EUR',
        '£' => 'GBP',
        '¥' => 'JPY',
        EUR => 1,
        GBP => 1,
        JPY => 1,
        CAD => 1,
        HKD => 1,
        MXN => 1,
        INR => 1,
        DKK => 1,
        CNY => 1,
        RUB => 1,
    );

    if ($symbol eq 'FAIR') {
        if (my $market = json_req('https://getfaircoin.net/api/ticker')) {
            my $amount = $market->{USD}->{last};
            return '$' . $amount;
        }
    }

    if (my $base = $poloniex_markets{$symbol}) {
        my $ticker = $base . '_' . $symbol;
        if (my $market = json_req('https://poloniex.com/public?command=returnTicker')) {
            my $amount = $market->{$ticker}->{last};
            return $base eq 'USDT' ? '$' . $amount : $amount . ' ' . $base;
        }
    }

    if (my $marketid = $coinabul_markets{$symbol}) {
        if (my $market = json_req('http://coinabul.com/api.php')) {
            return '$' . $market->{$marketid}->{USD};
        }
    }

    if ($cryptostocks_markets{$symbol}) {
        if (my $info = json_req('https://cryptostocks.com/api/get_security_info.json?ticker=' . $symbol)) {
            if ($info and $info->{return_code} == 0) {
                return $info->{last_price} . ' ' . $info->{currency};
            }
        }
    }

    if ($havelock_markets{$symbol}) {
        if ($havelock_markets{$symbol} != 1) {
            $symbol = $havelock_markets{$symbol};
        }
        if (my $ticker = json_req('https://www.havelockinvestments.com/r/ticker')) {
            if (my $details = $ticker->{$symbol}) {
                return $details->{last} . ' BTC';
            }
        }
    }

    if ($rateexchange_markets{$symbol}) {
        if ($rateexchange_markets{$symbol} != 1) {
            $symbol = $rateexchange_markets{$symbol};
        }
        if (my $info = json_req('https://rate-exchange.herokuapp.com/fetchRate?to=USD&from=' . $symbol)) {
            if ($info and $info->{Rate}) {
                return '$' . $info->{Rate};
            }
        }
    }

    if ($_ = request('http://www.google.com/finance/info?infotype=infoquoteall&q=' . $symbol)) {
        s/\/\/.*/[/;
        my $info = decode_json($_);
        if ($info and $info->[0]) {
            return '$' . $info->[0]->{l};
        }
    }
}

if (my $price = getquote()) {
    print strftime("%Y/%m/%d %H:%M:%S ", localtime(time())),
        $symbol, ' ', $price, "\n";
} else {
    exit 1;
}
