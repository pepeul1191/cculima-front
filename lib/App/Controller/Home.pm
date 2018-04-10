package App::Controller::Home;
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
use App::Helper::Home;

my $log = Mojo::Log->new;

sub index {
  my $self = shift;
  #$log->debug('Not sure what is happening here');
  my $helper = \%App::Config::Helpers::ViewHelpers;
  my $HomeHelper = \%App::Helper::Home::HomeHelper;
  my %data = (
    mensaje => JSON::false,
    titulo_pagina => 'Gestión de Accesos',
    modulo => 'Accesos'
  );
  my %locals = (
    title => 'Home',
    data => decode('utf8', encode_json \%data),
  );
  my %helpers = (
    css => $helper->{'loas_css'}($HomeHelper->{'index_css'}()),
    js => $helper->{'load_js'}($HomeHelper->{'index_js'}()),
  );
  $self->stash(constants => \%App::Config::Constants::Data);
  $self->stash(locals => \%locals);
  $self->stash(helpers => \%helpers);
  $self->render(template => 'home/index');
}

sub rest {
  my $self = shift;
  my $sistema_id = $self->param('sistema_id');
  try {
    my $url = %App::Config::Constants::Data{'servicio_eventos'} . 'externo/listar';
    my $client = REST::Client->new(); $client->GET($url);
    my $rpta = decode('utf8', $client->responseContent());
    $self->render(text => $rpta);
  }
  catch {
    my %rpta = ();
    $rpta{'tipo_mensaje'} = "error";
    my @temp = ('Se ha producido un error en el cliente REST', '' . $_);
    $rpta{'mensaje'} = [@temp];
    $self->render(text => Encode::decode('utf8', JSON::to_json \%rpta));
  };
}

1;
