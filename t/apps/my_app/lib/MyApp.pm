package MyApp;
use Mojo::Base 'Mojolicious';

# This method will run once at server start
sub startup {
  my $self = shift;

  # Define path to confings, modules
  $self->plugin('Module', {
    conf_dir => './t/apps/my_app/conf',
    mod_dir => './t/apps/my_app/mod'
  });

  # Router
  my $r = $self->routes;

  # Normal route to controller
  $r->get('/')->to('example#welcome');
}

1;
