package App::Controller::Home;
use Mojo::Base 'Mojolicious::Controller';
use App::Config::Variables;
use JSON;
use Mojo::Log;
use utf8;
use Encode qw(decode encode);
binmode STDOUT, ':utf8';

my $log = Mojo::Log->new;

sub index {
  my $self = shift;
  $log->debug('Not sure what is happening here');
  my %data = (
    mensaje => JSON::false,
    titulo_pagina => 'Gestión de Accesos',
    modulo => 'Accesos'
  );
  my %locals = (
    title => 'Home',
    css => 'dist/accesos.min.css',
    js => 'dist/accesos.min.js',
    data => decode('utf8', encode_json \%data),
  );
  $self->render(
    template => 'home/index',
    variables => \%App::Config::Variables::Data,
    locals => \%locals,
  );
}

1;
