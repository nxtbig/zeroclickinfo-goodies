package DDG::Goodie::PercentOf;
# ABSTRACT: Operations with percentuals

use strict;
use DDG::Goodie;

zci answer_type => "percent_of";
zci is_cached   => 1;

name "PercentOf";
description "Makes Operations with percentuals";
primary_example_queries "4-50%", "349*16%";

code_url "https://github.com/duckduckgo/zeroclickinfo-goodies/blob/master/lib/DDG/Goodie/PercentOf/PercentOf.pm";
attribution github => ["puskin94", "puskin"];

my $result;

triggers query_nowhitespace => qr/\d{1,3}\%$/;

handle query_nowhitespace => sub {

    return unless $_ =~ qr/^(?:\p{Currency_Symbol})*\s*(\d+\.?\d*)\s*(\+|\*|\/|\-)\s*(\d+\.?\d*)\%$/;

    my $partRes = ($1 * $3) / 100;

    if ($2 eq '-') {
        $result = ( $1 - ( $partRes ) );
    } elsif ($2 eq '+') {
        $result = ( $1 + ( $partRes ) );
    } elsif ($2 eq '*') {
        $result = ( $partRes );
    } elsif ($2 eq '/') {
        $result = ( $1 / ( $partRes ) );
    }

    my $text = "Result: $result";

    return $text,
    structured_answer => {
        input => [$_],
        operation => 'Calculate',
        result => $result
    };
};

1;

