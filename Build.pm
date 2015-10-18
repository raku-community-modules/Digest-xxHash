use v6;
use Panda::Common;
use Panda::Builder;

class Build is Panda::Builder
{
    method build(Str $path)
    {
        if $*DISTRO.is-win
        {
            note '                           _-';
            note '                         _-//';
            note '                      _-_/ /';
            note '                   _--_/ _/';
            note '                 _- _/ _/';
            note '          ___-(O) _/ _/  **************************';
            note '      __--  __   /_ /    * Please see the README  *';
            note '____--__----  /    \_    * for information on how *';
            note ' -----       /   \_  \_  * to install on windows. *';
            note '           //   // \__ \_**************************';
            note '         //   //      \_ \_';
            note '      ///   //          \__-';
            return;
        }
        my $string-to-execute = "make panda-install";
        say "Executing: $string-to-execute";
        my $retval = +shell $string-to-execute;
        if $retval != 0
        {
            note "*** xxhash library build failed with exit status {$retval}!";
            exit 1;
        }
    }
}

# vim: ft=perl6
