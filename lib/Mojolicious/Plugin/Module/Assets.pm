package Mojolicious::Plugin::Module::Assets;
use Mojo::Base -base;
use Mojo::Util qw/decamelize/;
use File::Copy::Recursive qw/dircopy/;
use FindBin;
use Carp;

sub init {
  my ($self, $app) = @_;
  # Does not support Mojolicious Lite.
  return if $app->isa('Mojolicious::Lite');
  my $app_path = "$FindBin::Bin/..";
  while (my($name, $mod) = each %{ $app->module->modules }) {
    my $path = $mod->config->{path};
    dircopy("$path/assets", "$app_path/public/assets") or
      croak("Can't copy $path/assets to $app_path/public") if -d "$path/assets";
  }
}

1;