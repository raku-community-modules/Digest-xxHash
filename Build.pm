use v6;
use lib 'lib';
use Digest::xxHash::BuildTools;

# for zef
class Build
{
    method build($dist-dir)
    {
        my Digest::xxHash::BuildTools $build-tools .= new(:$dist-dir);
        $build-tools.build;
        $build-tools.install;
    }
}

# vim: set filetype=perl6 foldmethod=marker foldlevel=0:
