use v6;
use Test;
use Digest::xxHash;

plan 4;

{
    isa-ok xxhash_revision, Int,
        "xxhash_revision returns integer";
}

{
    isa-ok xxhash_src_uri, Str,
        "xxhash_src_uri returns string";
}

{
    my Int $rev = xxhash_revision;
    ok $rev >= 0,
        "xxhash_revision returns non-negative value";
}

{
    my Str $str = xxhash_src_uri;
    ok $str.trim ne "",
        "xxhash_src_uri returns non-empty string";
}

# vim: ft=perl6
