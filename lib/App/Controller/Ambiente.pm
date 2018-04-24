package App::Controller::Ambiente;
use strict;
use warnings;
use Mojo::Base 'Mojolicious::Controller';
use utf8;
use JSON;
use JSON::Parse 'parse_json';
use Net::FTP;
use Encode qw(decode encode);
use Try::Tiny;
use App::Provider::Ambiente;
use App::Provider::Archivo;
use App::Config::Constants;
#use Mojo::Log; use Data::Dumper;my $log = Mojo::Log->new;
sub listar {
  my $self = shift;
  my %mensaje = App::Provider::Ambiente::listar();
  if($mensaje{'codigo'} eq '200'){
    my $rpta = %mensaje{'mensaje'};
    $self->render(text =>  Encode::decode('utf8', $rpta), status => 200);
  }else{
    my $codigo = int(%mensaje{'codigo'});
    $self->render(text => Encode::decode('utf8', JSON::to_json \%mensaje), status => $codigo);
  }
}

sub guardar_detalle {
  my $self = shift;
  my $data = $self->param('data');
  my %mensaje = ();
  #$log->debug("1 +++++++++++++++++++++++++++++++++++++++++");
  my $ambiente = decode_json($data);
  if($ambiente->{'_id'} eq 'E'){
    %mensaje = App::Provider::Ambiente::crear_detalle($data);
  }else{
    %mensaje = App::Provider::Ambiente::editar_detalle($data);
  }
  if($mensaje{'codigo'} eq '200'){
    my $rpta = %mensaje{'mensaje'};
    $self->render(text =>  Encode::decode('utf8', $rpta), status => 200);
  }else{
    my $codigo = int(%mensaje{'codigo'});
    $self->render(text => Encode::decode('utf8', JSON::to_json \%mensaje), status => $codigo);
  }
}

sub asociar_imagen_princial {
  my $self = shift;
  my $ambiente_id = $self->param('ambiente_id');
  my $imagen_principal_id = $self->param('imagen_principal_id');
  my %mensaje = ();
  %mensaje = App::Provider::Ambiente::asociar_imagen_princial($ambiente_id, $imagen_principal_id);
  if($mensaje{'codigo'} eq '200'){
    my $rpta = %mensaje{'mensaje'};
    $self->render(text =>  Encode::decode('utf8', $rpta), status => 200);
  }else{
    my $codigo = int(%mensaje{'codigo'});
    $self->render(text => Encode::decode('utf8', JSON::to_json \%mensaje), status => $codigo);
  }
}

sub asociar_imagen_menu {
  my $self = shift;
  my $ambiente_id = $self->param('ambiente_id');
  my $imagen_menu_id = $self->param('imagen_menu_id');
  my %mensaje = ();
  %mensaje = App::Provider::Ambiente::asociar_imagen_menu($ambiente_id, $imagen_menu_id);
  if($mensaje{'codigo'} eq '200'){
    my $rpta = %mensaje{'mensaje'};
    $self->render(text =>  Encode::decode('utf8', $rpta), status => 200);
  }else{
    my $codigo = int(%mensaje{'codigo'});
    $self->render(text => Encode::decode('utf8', JSON::to_json \%mensaje), status => $codigo);
  }
}

sub galeria_guardar {
  my $self = shift;
  my $data = $self->param('data');
  my %mensaje = ();
  %mensaje = App::Provider::Ambiente::galeria_guardar($data);
  if($mensaje{'codigo'} eq '200'){
    my $rpta = %mensaje{'mensaje'};
    $self->render(text =>  Encode::decode('utf8', $rpta), status => 200);
  }else{
    my $codigo = int(%mensaje{'codigo'});
    $self->render(text => Encode::decode('utf8', JSON::to_json \%mensaje), status => $codigo);
  }
}

sub listar_galeria {
  my $self = shift;
  my $ambiente_id = $self->param('ambiente_id');
  if ($ambiente_id eq 'E'){
    $self->render(text =>  '[]', status => 200);
  }else{
    my %mensaje = ();
    %mensaje = App::Provider::Ambiente::listar_galeria($ambiente_id);
    if($mensaje{'codigo'} eq '200'){
      my $rpta = %mensaje{'mensaje'};
      $self->render(text =>  Encode::decode('utf8', $rpta), status => 200);
    }else{
      my $codigo = int(%mensaje{'codigo'});
      $self->render(text => Encode::decode('utf8', JSON::to_json \%mensaje), status => $codigo);
    }
  }
}

sub obtener {
  my $self = shift;
  my $ambiente_id = $self->param('ambiente_id');
  if ($ambiente_id eq 'E'){
    $self->render(text =>  '[]', status => 200);
  }else{
    my %mensaje = ();
    %mensaje = App::Provider::Ambiente::obtener($ambiente_id);
    if($mensaje{'codigo'} eq '200'){
      my $rpta = parse_json($mensaje{'mensaje'});
      $rpta->{'foto_principal_url'} = $App::Config::Constants::Data{'servicio_archivos'} . App::Provider::Archivo::nombre($rpta->{'foto_principal'});
      $rpta->{'foto_menu_url'} = $App::Config::Constants::Data{'servicio_archivos'} . App::Provider::Archivo::nombre($rpta->{'foto_menu'});
      $self->render(text =>  Encode::decode('utf8', JSON::to_json $rpta), status => 200);
    }else{
      my $codigo = int(%mensaje{'codigo'});
      $self->render(text => Encode::decode('utf8', JSON::to_json \%mensaje), status => $codigo);
    }
  }
}

sub galeria_obtener_ruta_foto {
  my $self = shift;
  my $imagen_id = $self->param('imagen_id');
  my $imagen_url = $App::Config::Constants::Data{'servicio_archivos'} . App::Provider::Archivo::nombre($imagen_id);
  $self->render(text => $imagen_url, status => 200);
}

1;
