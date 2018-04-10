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

my $log = Mojo::Log->new;

sub index {
  my $self = shift;
  #$log->debug('Not sure what is happening here');
  my $helper = \%App::Config::Helpers::ViewHelpers;
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
    css => $helper->{'loas_css'}(
      'bower_components/bootstrap/dist/css/bootstrap.min',
  		'bower_components/font-awesome/css/font-awesome.min',
  		'css/style'
    ),
    js => $helper->{'load_js'}(
      'bower_components/jquery/dist/jquery.min',
      'bower_components/bootstrap/dist/js/bootstrap.min',
    ),
  );
  $log->debug('1 +++++++++++++++++++++++++++++++++++++++++++');
  print("\n");
  print(Dumper($locals{'title'}));
  print("\n");
  $log->debug('2 +++++++++++++++++++++++++++++++++++++++++++');
  $self->stash(constants => \%App::Config::Constants::Data);
  $self->stash(locals => \%locals);
  $self->stash(helpers => \%helpers);
  $self->render(template => 'home/index');
}

1;
