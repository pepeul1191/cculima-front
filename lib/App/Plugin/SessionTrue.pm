package App::Plugin::SessionTrue;
use Mojo::Base 'Mojolicious::Plugin';
use Mojo::Log;

my $log = Mojo::Log->new;

sub register {
  my ($self, $app) = @_;
  $app->routes->add_condition(sesion_true => sub {
    my ($route, $c, $captures, $session) = @_;
    if ($session == 1){
      $c->redirect_to(%App::Config::Variables::Data{'BASE_URL'});
    }
    return 1;
  });
}

1;
