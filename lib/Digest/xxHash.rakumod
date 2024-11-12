use NativeCall;

unit module Digest::xxHash;

# xxHash C wrapper functions (/usr/lib/libxxhash.so) {{{

# unsigned int XXH32 (const void* input, size_t length, unsigned seed);
sub XXH32(
    CArray[int8],
    size_t,
    uint32
    --> uint32
) is native('xxhash', v0.8.2)
{*}

# unsigned long long XXH64 (const void* input, size_t length, unsigned long long seed);
sub XXH64(
    CArray[int8],
    size_t,
    uint64
    --> uint64
) is native('xxhash', v0.8.2)
{*}

# end xxHash C wrapper functions (/usr/lib/libxxhash.so) }}}

# 32 or 64 bit {{{

proto sub xxHash(|) is export {*}
multi sub xxHash(
    Str $string,
    Str :$enc = 'UTF-8',
    Int :$seed = 0
    --> Int
) {
    my Int @data = $string.encode($enc).list;
    build-xxhash(@data, $seed);
}

multi sub xxHash(Str :$file!, Int :$seed = 0 --> Int) {
    xxHash($file.IO.slurp(:bin), :$seed);
}

multi sub xxHash(IO $fh, Int :$seed = 0 --> Int) {
    xxHash($fh.slurp(:bin), :$seed);
}

multi sub xxHash(Buf[uint8] $buf-u8, Int :$seed = 0 --> Int) {
    my Int @data = $buf-u8.list;
    build-xxhash(@data, $seed);
}

multi sub build-xxhash(
    Int @data,
    Int $seed = 0,
    $? where { $*KERNEL.bits == 64 }
    --> Int
) {
    build-xxhash64(@data, $seed);
}

multi sub build-xxhash(
    Int @data,
    Int $seed = 0,
    $?
    --> Int
) {
    build-xxhash32(@data, $seed);
}

# end 32 or 64 bit }}}
# 32 bit only {{{

proto sub xxHash32(|) is export {*}
multi sub xxHash32(
    Str $string,
    Str :$enc = 'UTF-8',
    Int :$seed = 0
    --> Int
) {
    my Int @data = $string.encode($enc).list;
    build-xxhash32(@data, $seed);
}

multi sub xxHash32(Str :$file!, Int :$seed = 0 --> Int) {
    xxHash32($file.IO.slurp(:bin), :$seed);
}

multi sub xxHash32(IO $fh, Int :$seed = 0 --> Int) {
    xxHash32($fh.slurp(:bin), :$seed);
}

multi sub xxHash32(Buf[uint8] $buf-u8, Int :$seed = 0 --> Int) {
    my Int @data = $buf-u8.list;
    build-xxhash32(@data, $seed);
}

sub build-xxhash32(Int @data, uint $seed = 0 --> uint)
{
    my @input := CArray[int8].new;
    my int $len;
    @input[$len++] = $_ for @data;
    XXH32(@input, $len, $seed);
}

# end 32 bit only }}}
# 64 bit only {{{

proto sub xxHash64(|) is export {*}
multi sub xxHash64(
    Str $string,
    Str :$enc = 'UTF-8',
    Int :$seed = 0
    --> Int
) {
    my Int @data = $string.encode($enc).list;
    build-xxhash64(@data, $seed);
}

multi sub xxHash64(Str :$file!, Int :$seed = 0 --> Int) {
    xxHash64($file.IO.slurp(:bin), :$seed);
}

multi sub xxHash64(IO $fh, Int :$seed = 0 --> Int) {
    xxHash64($fh.slurp(:bin), :$seed);
}

multi sub xxHash64(Buf[uint8] $buf-u8, Int :$seed = 0 --> Int) {
    my Int @data = $buf-u8.list;
    build-xxhash64(@data, $seed);
}

sub build-xxhash64(Int @data, uint64 $seed = 0 --> uint64)
{
    my @input := CArray[int8].new;
    my int $len;
    @input[$len++] = $_ for @data;
    XXH64(@input, $len, $seed);
}

# end 64 bit only }}}

=begin pod

=head1 NAME

Digest::xxHash - xxHash bindings for Raku

=head1 SYNOPSIS

=begin code :lang<raku>

# 32 or 64 bit xxHash from a string
say xxHash("dupa");

# 32 or 64 bit xxHash from a file
say xxHash(:file<filename.txt>);

# 32 or 64 bit xxHash from a file IO handle
say xxHash(filehandle);

# 32 or 64 bit xxHash from Buf
say xxHash(Buf[uint8].new(0x64, 0x75, 0x70, 0x61))

# You may call the 32 or 64 bit specific versions directly if desired,
# bypassing the architecture check.

# 32 bit
say xxHash32("dupa");

# 64 bit
say xxHash64("dupa");

=end code

=head1 DESCRIPTION

The Digest::xxHash distribution exports three subroutines: C<xxHash>,
C<xxHash32> and C<xxHash64>.

The C<xxHash> subroutine returns a 64 bit xxHash from a string (32
bit if no native 64 bit logic is available).

The C<xxHash32> and C<xxHash64> subroutines return a 32 bit / 64 bit
xxHash respectively (64 bit only if supported by architecture).

Depends on the L<libxxhash|https://github.com/Cyan4973/xxHash>
native library.

=head1 AUTHORS

=item Bartłomiej Palmowski
=item Andy Weidenbaum
=item Steve Schulze

=head1 COPYRIGHT AND LICENSE

Copyright 2013 - 2014 Bartłomiej Palmowski

Copyright 2013 - 2023 Andy Weidenbaum

Copyright 2024 Raku Community

This is free and unencumbered public domain software. For more
information, see http://unlicense.org/ or the accompanying UNLICENSE file.

=end pod

# vim: expandtab shiftwidth=4
