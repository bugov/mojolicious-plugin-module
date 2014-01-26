package Mojolicious::Plugin::Module::Abstract;
use Mojo::Base -base;
use Mojo::Util 'decamelize';
use Mojo::JSON 'j';
use Hash::Merge::Simple qw/merge/;

has 'routes';
has 'config' => sub { {} };

sub init {
  my ($self, $app, $path) = @_;
  $self->init_config($app, $path);
  $self->init_routes($app);
  $self->init_templates($app);
  $self->startup($app);
}

sub init_routes {}

sub init_helpers {}

sub startup {}

sub init_templates {
  my ($self, $app) = @_;
  my $pkg = decamelize ref $self;
  $pkg =~ s/-/\//;
  
  return if !-d $self->config->{path}.'/templates/'.$pkg;
  my $paths = $app->renderer->paths;
  unshift @$paths, $self->config->{path}.'/templates/'.$pkg;
  $app->renderer->paths($paths);
}

sub init_config {
  my ($self, $app, $path) = @_;
  my $pkg = decamelize ref $self;
  $pkg =~ s/-/\//;
  my $fh;
  
  open($fh, "./conf/$pkg.conf") and do {
    local $/;
    $self->config(j<$fh>);
    close $fh;
  };
  $self->config({ %{$self->config}, path => $path });
  
  open($fh, $self->config->{path}.'/conf/module.conf') and do {
    local $/;
    my $config = j<$fh>;
    close $fh;
    $self->config(merge $config, $self->config);
  };
}

1;