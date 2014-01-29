use Test::More;
use Test::Mojo;
use Data::Dumper;

do "example/lite_app/lite_app.pl";
my $t = Test::Mojo->new;

$t->get_ok('/')->status_is(200);#->content_like(qr/Welcome to the Mojolicious/);
$t->get_ok('/test1')->status_is(200);#->content_like(qr/test1/);
$t->get_ok('/test2')->status_is(200);#->content_like(qr/test2/);
$t->get_ok('/test3')->status_is(404);

done_testing();