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
    modulo => 'Accesos'
  );
  my %locals = (
    title => 'Home',
    data => decode('utf8', encode_json \%data),
    menu => '[{"url" : "accesos", "nombre" : "Accesos"},{"url" : "libros", "nombre" : "Libros"}]',
    items => '[{"subtitulo":"","items":[{"item":"Gestión de Sistemas","url":"#/sistema"},{"item":"Gestión de Usuarios","url":"#/usuario"}]}]',
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
