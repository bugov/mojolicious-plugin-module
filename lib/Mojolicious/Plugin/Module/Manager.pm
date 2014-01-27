package Mojolicious::Plugin::Module::Manager;
use Mojo::Base -base;
use Mojo::Util qw/camelize decamelize/;
use Mojo::JSON 'j';
use Carp 'croak';
use Module::Load;
use FindBin;

has modules => sub {{}};
has mod_dir => '';
has 'app';

sub init {
  my ($self, $app, $conf) = @_;
  my $path = "$FindBin::Bin/..";
  my $conf_dir = $conf->{conf_dir};
  $self->mod_dir($conf->{mod_dir});
  $self->app($app);
  
  open(my $fh, "$path/$conf_dir/app.conf") or croak "Can't find '$path/$conf_dir/app.conf'";
  local $/;
  my $app_conf = j (<$fh>);
  close $fh;
  
  $self->add($_) for @{ $app_conf->{modules} };
  $app->helper(module => sub { $self });
}

sub add {
  my ($self, $name, $module) = @_;
  croak "Trying to reload module \"$name\"!\n" if exists $self->modules->{$name};
  return $self->modules->{$name} = $module if $module;
  
  my $path = decamelize $name;
  $path =~ s/-/\//;
  $path = "$FindBin::Bin/../".$self->mod_dir.'/'.$path;
  
  @::INC = ("$path/lib", @::INC);
  load $name;
  $name->new->init($self->app, $path);
}

sub get {
  my ($self, $name) = @_;
  return exists $self->modules->{$name} ? $self->modules->{$name} : undef;
}

1;