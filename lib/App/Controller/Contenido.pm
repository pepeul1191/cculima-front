package App::Controller::Contenido;
use Mojo::Base 'Mojolicious::Controller';
use JSON;
use Mojo::Log;
use utf8;
use Encode qw(decode encode);
use Data::Dumper;
use REST::Client;
use Try::Tiny;
binmode STDOUT, ':utf8';
use App::Config::Constants;
use App::Config::Helpers;
use App::Helper::Contenido;

my $log = Mojo::Log->new;

sub index {
  my $self = shift;
  my $helper = \%App::Config::Helpers::ViewHelpers;
  my $ContenidoHelper = \%App::Helper::Contenido::ContenidoHelper;
  my %data = (
    mensaje => JSON::false,
    titulo_pagina => 'Gestión de Accesos',
    modulo => 'Contenido'
  );
  my %locals = (
    title => 'Home',
    data => decode('utf8', encode_json \%data),
    menu => '[{"url" : "accesos", "nombre" : "Accesos"},{"url" : "contenido", "nombre" : "Contenido"}]',
    items => '[{"subtitulo":"Contenidos","items":[{"item":"Gestión de Ambientes","url":"contenido/#/ambiente"},{"item":"Gestión de Servicios","url":"contenido/#/servicio"},{"item":"Gestión de Teatros","url":"contenido/#/teatro"},{"item":"Gestión de Exposiciones","url":"contenido/#/exposicion"},{"item":"Gestión de Conciertos","url":"contenido/#/concierto"},{"item":"Gestión de Stand Ups","url":"contenido/#/stand_up"}]}]',
  );
  my %helpers = (
    css => $helper->{'loas_css'}($ContenidoHelper->{'index_css'}()),
    js => $helper->{'load_js'}($ContenidoHelper->{'index_js'}()),
  );
  $self->stash(constants => \%App::Config::Constants::Data);
  $self->stash(locals => \%locals);
  $self->stash(helpers => \%helpers);
  $self->render(template => 'contenido/index');
}

1;
