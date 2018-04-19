package App::Controller::Ambiente;
use strict;
use warnings;
use Mojo::Base 'Mojolicious::Controller';
use utf8;
use JSON;
use Encode qw(decode encode);
use App::Provider::Ambiente;
use App::Provider::Archivo;
use Mojo::Log; use Data::Dumper;my $log = Mojo::Log->new;
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

sub subir_princial{
  my $self = shift;
  my $file = $self->param('myFile');
  my %mensaje = App::Provider::Archivo::obtener_id();
  if($mensaje{'codigo'} eq '200'){
    $log->debug('1 +++++++++++++++++++++++++++++++++++++++++');
    my $nombre_tmp = $mensaje{'mensaje'};
    my $nombre_original = $file->{'filename'};
    my @temp_nombre_original = split /[.]/, $nombre_original;
    my $extension =@temp_nombre_original[length @temp_nombre_original - 1];
    $file->move_to('/tmp/' . $nombre_tmp . '.' . $extension);
    $log->debug('2 +++++++++++++++++++++++++++++++++++++++++');

    $self->render(text =>  'XD', status => 200);
  }else{
    my $codigo = int(%mensaje{'codigo'});
    $self->render(text => Encode::decode('utf8', JSON::to_json \%mensaje), status => $codigo);
  }
}

1;
