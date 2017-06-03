# Find duplicate files in a directory structure.
# Filters by file size and then xxHash value.
# Written by Steve Schulze (thundergnat)
# released under Creative Commons 0 licence, free for any use

# set flags on the command line :
# --minsize=Int  - minimum file size to include: defaults to 5 bytes
# --recurse=Bool - recurse into subdirectories: defaults to True
# <directory-path> - which directory to start in: defaults to current

use Digest::xxHash;

sub MAIN( Str $dir = '.', Int :$minsize = 5, Bool :$recurse = True ) {
    my %files;
    my @dirs = $dir.IO.absolute.IO;
    while @dirs {
        my @files = @dirs.pop;
        while @files {
            for @files.pop.dir -> $path {
                %files{ $path.s }.push: $path if $path.f and $path.s >= $minsize;
                @dirs.push: $path if $path.d and $path.r and $recurse
            }
        }
    }

    for %files.sort( +*.key ).grep( *.value.elems > 1)».kv -> ($size, @list) {
        my %dups;
        @list.map: { %dups{ xxHash( $_.slurp :bin ) }.push: $_.Str };
        for %dups.grep( *.value.elems > 1)».value -> @dups {
            say sprintf("%9s : ", scale $size ),  @dups.join(', ');
        }
    }
}

sub scale ($bytes) {
    given $bytes {
        when $_ < 2**10 {  $bytes                    ~ ' B'  }
        when $_ < 2**20 { ($bytes / 2**10).round(.1) ~ ' KB' }
        when $_ < 2**30 { ($bytes / 2**20).round(.1) ~ ' MB' }
        default         { ($bytes / 2**30).round(.1) ~ ' GB' }
    }
}
