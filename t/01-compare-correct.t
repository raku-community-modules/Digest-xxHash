use v6;
use Test;
use Digest::xxHash;

plan 4;

my Str $file_for_tests = $*PROGRAM-NAME.IO.dirname ~ "/digest-from-file";

unless $file_for_tests.IO ~~ :f
{
    die ">>> File: '"
        ~ $file_for_tests
        ~ "' doesn't exist (it should be distributed along with this
           Digest::xxHash archive)!"
}

{
    is xxHash(""), 0x2CC5D05, "digest from empty string is correct";
}

{
    is xxHash("dupa"), 0x1A47C09D, "digest from string 'dupa' is correct";
}

{
    is xxHash(file => $file_for_tests), 0x1A47C09D,
        "digest from file content is correct";
}

{
    is xxHash(buf-u8 => Buf[uint8].new(0x64, 0x75, 0x70, 0x61)), 0x1A47C09D,
        "digest from uint8 buffer is correct";
}

# vim: ft=perl6
