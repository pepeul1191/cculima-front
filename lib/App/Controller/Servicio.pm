package App::Controller::Servicio;
use strict;
use warnings;
use Mojo::Base 'Mojolicious::Controller';
use utf8;
use JSON;
use JSON::Parse 'parse_json';
use Encode qw(decode encode);
use App::Provider::Servicio;
use App::Provider::Archivo;
#use Mojo::Log; use Data::Dumper;my $log = Mojo::Log->new;
sub listar {
  my $self = shift;
  my %mensaje = App::Provider::Servicio::listar();
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
  my $servicio = decode_json($data);
  if($servicio->{'_id'} eq 'E'){
    %mensaje = App::Provider::Servicio::crear_detalle($data);
  }else{
    %mensaje = App::Provider::Servicio::editar_detalle($data);
  }
  if($mensaje{'codigo'} eq '200'){
    my $rpta = %mensaje{'mensaje'};
    $self->render(text =>  Encode::decode('utf8', $rpta), status => 200);
  }else{
    my $codigo = int(%mensaje{'codigo'});
    $self->render(text => Encode::decode('utf8', JSON::to_json \%mensaje), status => $codigo);
  }
}

sub asociar_foto {
  my $self = shift;
  my $servicio_id = $self->param('servicio_id');
  my $foto_id = $self->param('foto_id');
  my %mensaje = ();
  %mensaje = App::Provider::Servicio::asociar_foto($servicio_id, $foto_id);
  if($mensaje{'codigo'} eq '200'){
    my $rpta = %mensaje{'mensaje'};
    $self->render(text =>  Encode::decode('utf8', $rpta), status => 200);
  }else{
    my $codigo = int(%mensaje{'codigo'});
    $self->render(text => Encode::decode('utf8', JSON::to_json \%mensaje), status => $codigo);
  }
}

sub obtener {
  my $self = shift;
  my $servicio_id = $self->param('servicio_id');
  if ($servicio_id eq 'E'){
    $self->render(text =>  '[]', status => 200);
  }else{
    my %mensaje = ();
    %mensaje = App::Provider::Servicio::obtener($servicio_id);
    if($mensaje{'codigo'} eq '200'){
      my $rpta = parse_json($mensaje{'mensaje'});
      $rpta->{'foto_url'} = $App::Config::Constants::Data{'servicio_archivos'} . App::Provider::Archivo::nombre($rpta->{'foto_id'});
      $self->render(text =>  Encode::decode('utf8', JSON::to_json $rpta), status => 200);
    }else{
      my $codigo = int(%mensaje{'codigo'});
      $self->render(text => Encode::decode('utf8', JSON::to_json \%mensaje), status => $codigo);
    }
  }
}

sub guardar {
  my $self = shift;
  my $data = $self->param('data');
  my %mensaje = ();
  %mensaje = App::Provider::Servicio::guardar($data);
  if($mensaje{'codigo'} eq '200'){
    my $rpta = %mensaje{'mensaje'};
    $self->render(text =>  Encode::decode('utf8', $rpta), status => 200);
  }else{
    my $codigo = int(%mensaje{'codigo'});
    $self->render(text => Encode::decode('utf8', JSON::to_json \%mensaje), status => $codigo);
  }
}


1;
