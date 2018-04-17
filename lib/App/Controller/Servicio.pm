package App::Controller::Servicio;
use strict;
use warnings;
use Mojo::Base 'Mojolicious::Controller';
use App::Provider::Servicio;
#use Mojo::Log; use Data::Dumper;my $log = Mojo::Log->new;

sub listar {
  my $self = shift;
  $self->render(text => App::Provider::Servicio::listar());
}

1;
