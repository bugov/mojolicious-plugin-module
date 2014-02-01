package Mojolicious::Plugin::Module::Assets;
use Mojo::Base -base;
use Mojo::Util qw/decamelize/;

sub init {
  my ($self, $app) = @_;
  
  while (my($name, $mod) = each %{ $app->module->modules }) {
    my $prefix = decamelize $name;
    $prefix = s/-/\//g;
    my $path = $mod->config->{path};
    # search and copy assets
  }
}

1;