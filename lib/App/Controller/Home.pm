package App::Controller::Home;
use Mojo::Base 'Mojolicious::Controller';
use JSON;
use Mojo::Log;
use utf8;
use Encode qw(decode encode);
use Data::Dumper;
binmode STDOUT, ':utf8';
use App::Config::Constants;
use App::Config::Helpers;
use App::Helpers::Home;

my $log = Mojo::Log->new;

sub index {
  my $self = shift;
  #$log->debug('Not sure what is happening here');
  my $helper = \%App::Config::Helpers::ViewHelpers;
  my $HomeHelper = \%App::Helpers::Home::HomeHelper;
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

1;
