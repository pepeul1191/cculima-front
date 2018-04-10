package App::Controller::Departamento;
use Mojo::Base 'Mojolicious::Controller';
use App::Config::Constants;
use JSON;
use Try::Tiny;
use Mojo::Log;
use utf8;
use Encode qw(decode encode);
use App::Model::Departamento;
binmode STDOUT, ':utf8';

my $log = Mojo::Log->new;

sub listar {
  my $self = shift;
  my $model= 'App::Model::Departamento';
  my $Departamento = $model->new();
  try {
    my @rpta = $Departamento->listar();
    $self->render(text => Encode::decode('utf8', JSON::to_json \@rpta));
  }
  catch {
    my %rpta = ();
    $rpta{'tipo_mensaje'} = "error";
    my @temp = ('Se ha producido un error en listar la tabla de departamentos', '' . $_);
    $rpta{'mensaje'} = [@temp];
    $self->render(text => Encode::decode('utf8', JSON::to_json \%rpta));
  };
}

sub guardar {
  my $self = shift;
  my $data = JSON::XS::decode_json(Encode::encode_utf8(param('data')));
  my @nuevos = @{$data->{'nuevos'}};
  my @editados = @{$data->{'editados'}};
  my @eliminados = @{$data->{'eliminados'}};
  my @array_nuevos;
  my %rpta = ();
  my $model= 'App::Model::Departamento';
  my $Departamento= $model->new();
  try {
    for my $nuevo(@nuevos){
      if ($nuevo) {
        my $temp_id = $nuevo->{'id'};
        my $nombre = $nuevo->{'nombre'};
        my $id_generado = $Departamento->crear($nombre);
        my %temp = ();
        $temp{'temporal'} = $temp_id;
        $temp{'nuevo_id'} = $id_generado;
        push @array_nuevos, {%temp};
      }
    }
    for my $editado(@editados){
      if ($editado) {
        my $id = $editado->{'id'};
        my $nombre = $editado->{'nombre'};
        $Departamento->editar($id,$nombre);
      }
    }
    for my $eliminado(@eliminados){
      $Departamento->eliminar($eliminado);
    }
    $rpta{'tipo_mensaje'} = "success";
    my @temp = ("Se ha registrado los cambios en los departamentos", [@array_nuevos]);
    $rpta{'mensaje'} = [@temp];
    $Departamento->commit();
  } catch {
    #warn "got dbi error: $_";
    $rpta{'tipo_mensaje'} = "error";
    my @temp = ("Se ha producido un error en guardar la tabla de departamentos", "" . $_);
    $rpta{'mensaje'} = [@temp];
    $Departamento->rollback();
  };
  $self->render(text => Encode::decode('utf8', JSON::to_json \%rpta));
}

1;
