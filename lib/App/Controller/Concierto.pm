package App::Controller::Concierto;
use strict;
use warnings;
use Mojo::Base 'Mojolicious::Controller';
use utf8;
use JSON;
use JSON::Parse 'parse_json';
use Encode qw(decode encode);
use App::Provider::Concierto;
use App::Provider::Archivo;
#use Mojo::Log; use Data::Dumper;my $log = Mojo::Log->new;
sub listar {
  my $self = shift;
  my %mensaje = App::Provider::Concierto::listar();
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
    %mensaje = App::Provider::Concierto::crear_detalle($data);
  }else{
    %mensaje = App::Provider::Concierto::editar_detalle($data);
  }
  if($mensaje{'codigo'} eq '200'){
    my $rpta = %mensaje{'mensaje'};
    $self->render(text =>  Encode::decode('utf8', $rpta), status => 200);
  }else{
    my $codigo = int(%mensaje{'codigo'});
    $self->render(text => Encode::decode('utf8', JSON::to_json \%mensaje), status => $codigo);
  }
}

sub asociar_calendario {
  my $self = shift;
  my $concierto_id = $self->param('concierto_id');
  my $fechas = $self->param('fechas');
  my %mensaje = ();
  %mensaje = App::Provider::Concierto::asociar_calendario($concierto_id, $fechas);
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
  my $concierto_id = $self->param('concierto_id');
  my $imagen_menu_id = $self->param('imagen_menu_id');
  my %mensaje = ();
  %mensaje = App::Provider::Concierto::asociar_imagen_menu($concierto_id, $imagen_menu_id);
  if($mensaje{'codigo'} eq '200'){
    my $rpta = %mensaje{'mensaje'};
    $self->render(text =>  Encode::decode('utf8', $rpta), status => 200);
  }else{
    my $codigo = int(%mensaje{'codigo'});
    $self->render(text => Encode::decode('utf8', JSON::to_json \%mensaje), status => $codigo);
  }
}

sub asociar_imagen_detalle {
  my $self = shift;
  my $concierto_id = $self->param('concierto_id');
  my $imagen_detalle_id = $self->param('imagen_detalle_id');
  my %mensaje = ();
  %mensaje = App::Provider::Concierto::asociar_imagen_detalle($concierto_id, $imagen_detalle_id);
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
  my $concierto_id = $self->param('concierto_id');
  if ($concierto_id eq 'E'){
    $self->render(text =>  '[]', status => 200);
  }else{
    my %mensaje = ();
    %mensaje = App::Provider::Concierto::obtener($concierto_id);
    if($mensaje{'codigo'} eq '200'){
      my $rpta = parse_json($mensaje{'mensaje'});
      $rpta->{'foto_menu_url'} = $App::Config::Constants::Data{'servicio_archivos'} . App::Provider::Archivo::nombre($rpta->{'foto_menu'});
      $rpta->{'foto_detalle_url'} = $App::Config::Constants::Data{'servicio_archivos'} . App::Provider::Archivo::nombre($rpta->{'foto_detalle'});
      $self->render(text =>  Encode::decode('utf8', JSON::to_json $rpta), status => 200);
    }else{
      my $codigo = int(%mensaje{'codigo'});
      $self->render(text => Encode::decode('utf8', JSON::to_json \%mensaje), status => $codigo);
    }
  }
}

sub obtener_calendario {
  my $self = shift;
  my $concierto_id = $self->param('concierto_id');
  if ($concierto_id eq 'E'){
    $self->render(text =>  '[]', status => 200);
  }else{
    my %mensaje = ();
    %mensaje = App::Provider::Concierto::obtener_calendario($concierto_id);
    if($mensaje{'codigo'} eq '200'){
      my $rpta = %mensaje{'mensaje'};
      $self->render(text =>  Encode::decode('utf8', $rpta), status => 200);
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
  %mensaje = App::Provider::Concierto::guardar($data);
  if($mensaje{'codigo'} eq '200'){
    my $rpta = %mensaje{'mensaje'};
    $self->render(text =>  Encode::decode('utf8', $rpta), status => 200);
  }else{
    my $codigo = int(%mensaje{'codigo'});
    $self->render(text => Encode::decode('utf8', JSON::to_json \%mensaje), status => $codigo);
  }
}

1;
