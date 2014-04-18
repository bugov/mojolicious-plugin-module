package MyApp;
use Mojo::Base 'Mojolicious';

# This method will run once at server start
sub startup {
  my $self = shift;

  # Define path to confings, modules
  $self->plugin('Module', {
    conf_dir => './config',
    mod_dir => './module'
  });

  # Router
  my $r = $self->routes;

  # Normal route to controller
  $r->get('/')->to('example#welcome');
}

1;
