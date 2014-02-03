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
  my $app_path = $app->home;
  while (my($name, $mod) = each %{ $app->module->modules }) {
    my $path = $mod->config->{path};
    dircopy("$path/assets", "$app_path/public/assets") or
      croak("Can't copy $path/assets to $app_path/public") if -d "$path/assets";
  }
}

1;

__END__

=pod

=head1 NAME

Mojolicious::Plugin::Module::Assets - work with assets.

=head1 OVERVIEW

If your module has some static files, which should be able from public directory, use C<assets>
folder.