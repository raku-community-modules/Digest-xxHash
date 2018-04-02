use v6;
unit class Digest::xxHash::BuildTools;

# library info
has Str:D $!library-name = 'xxHash';
has Str:D $!library-version = '0.6.4';

# dir info
has Str:D $.dist-dir =
    sprintf(Q{%s}, $*CWD);
has Str:D $!dest-dir =
    sprintf(Q{%s/%s}, $!dist-dir, 'resources/libraries');
has Str:D $!ext-dir =
    sprintf(Q{%s/ext/%s-%s}, $!dist-dir, $!library-name, $!library-version);

# credit: https://github.com/retupmoca/P6-LibraryMake
has Str:D %!vars{Str:D} =
    CC       => $*VM.config<cc>,
    CCFLAGS  => $*VM.config<cflags>,
    CCOUT    => $*VM.config<ccout>,
    CCSHARED => $*VM.config<ccshared>,
    EXE      => $*VM.config<exe>,
    LD       => $*VM.config<ld>,
    LDFLAGS  => $*VM.config<ldflags>,
    LDOUT    => $*VM.config<ldout>,
    LDSHARED => $*VM.config<ldshared>,
    LDUSR    => $*VM.config<ldusr>.subst(/\%s/, ''),
    LIBS     => $*VM.config<ldlibs>,
    MAKE     => $*VM.config<make>,
    O        => $*VM.config<obj>,
    SO       => $*VM.config<dll>.subst(/^.*\%s/, '');

method build(--> Nil)
{
    my Str:D $cc =
        sprintf(Q{CC='%s %s'}, %!vars<CC>, %!vars<CCFLAGS>);
    my Str:D $ldflags =
        sprintf(Q{LDFLAGS='%s'}, %!vars<LDFLAGS>);
    my Str:D $moreflags =
        sprintf(Q{MOREFLAGS='%s %s'}, %!vars<LDSHARED>, %!vars<LIBS>);
    my Str:D $make-lib-cmdline =
        sprintf(
            Q{%s %s %s %s lib -C %s},
            %!vars<MAKE>,
            $cc,
            $ldflags,
            $moreflags,
            $!ext-dir
        );

    say('Building...');
    shell($make-lib-cmdline);
}

method install(--> Nil)
{
    say('Installing...');
    mkdir($!dest-dir);
    dir($!ext-dir)
        .grep(/libxxhash/)
        .map({ run(qqw<cp -dpr --no-preserve=ownership $_ $!dest-dir>) });
}

# vim: set filetype=perl6 foldmethod=marker foldlevel=0:
