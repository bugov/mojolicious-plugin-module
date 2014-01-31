package Mojolicious::Plugin::Module;
use Mojo::Base 'Mojolicious::Plugin';
use Mojolicious::Plugin::Module::Manager;
our $VERSION = "0.01";

sub register {
  my ($self, $app, $conf) = @_;
  
  $conf ||= { conf_dir => 'conf', mod_dir  => 'mod' };
  $conf->{conf_dir} = 'conf' unless exists $conf->{conf_dir};
  $conf->{mod_dir}  = 'mod'  unless exists $conf->{mod_dir};
  
  Mojolicious::Plugin::Module::Manager->new->init($app, $conf);
}

1;

__END__

=pod

=head1 NAME

Mojolicious::Plugin::Module - Mojolicious Plugin.

=head1 OVERVIEW

Mojolicious::Plugin::Module is a Mojolicious plugin. This module helps to write more modular
applications with Mojo.

After

  $app->plugin('Module');

Mojolicious looks for C<conf/app.conf> where you can define (in JSON format) modules which
should be used.

For example C<app.conf> contains

  {
    "modules": ["Bugov::User", "Bugov::CommonModule"]
  }

Two modules will used. They should be located in C<mod/bugov/user> and C<mod/bugov/common_module>
directories.

=head2 Structure of module

  conf                                    # Some configs.
    module.conf                           # Main config of this module.
  lib
    Vendor
      ModuleName
        ... controllers, helpers, etc ... # The same what you can do in Mojolicious App.
      ModuleName.pm                       # Should extends Mojolicious::Plugin::Module::Abstract.
  templates
    vendor
      module_name
        ... templates ...                 # Templates used in this module.

=head1 METHODS

=over

=item add($name, $module)

C<$name> - required parameter. Defines package of module. For example "Vendor::ModuleName".

C<$module> - optional parameter. Module object which be finded as C<$name> in module manager.
If <$module> does not defined C<$name> will be loaded.

=item get($name)

Get module by C<$name>.

=back

=head1 SEE ALSO

L<Mojolicious::Plugin::Module::Abstract>, L<Mojolicious::Plugin::Module::Manager>,
L<Mojolicious::Guides>, L<http://mojolicio.us>.

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2014, Georgy Bazhukov.

This program is free software, you can redistribute it and/or modify it under
the terms of the Artistic License version 2.0.

=cut
