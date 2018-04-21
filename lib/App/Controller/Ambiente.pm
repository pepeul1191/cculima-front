package App::Controller::Ambiente;
use strict;
use warnings;
use Mojo::Base 'Mojolicious::Controller';
use utf8;
use JSON;
use JSON::Parse 'parse_json';
use Net::FTP;
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
    # generar nombre del archivo  a subir a '/tmp' con el servicio de archivos
    my $nombre_tmp = $mensaje{'mensaje'};
    my $nombre_original = $file->{'filename'};
    my @temp_nombre_original = split /[.]/, $nombre_original;
    my $extension =@temp_nombre_original[length @temp_nombre_original - 1];
    # nomber el archivo a /tmp
    $file->move_to('/tmp/' . $nombre_tmp . '.' . $extension);
    # subir archivo de /tmp por FTP
    my $ftp_params = \%App::Config::Constants::FTP;
    my $ftp = Net::FTP->new($ftp_params->{'host'}, Debug => $ftp_params->{'debug'})
      or die "Cannot connect to some.host.name: $@";
    $ftp->login($ftp_params->{'user'}, $ftp_params->{'pass'})
      or die "Cannot login ", $ftp->message;
    $ftp->cwd($ftp_params->{'directorio'})
      or die "Cannot change working directory ", $ftp->message;
    $ftp->binary();
    $ftp->put('/tmp/' . $nombre_tmp . '.' . $extension, $nombre_tmp . '.' . $extension)
      or die "put failed ", $ftp->message;
    $ftp->quit;
    # mandar al servicio de archivos los metadatos del archivo subido y retonar id
    my %archivo = (
      'id' => $nombre_tmp,
      #'nombre' => 'Corbett',
      'nombre_generado' => $nombre_tmp . '.' . $extension,
      'extension' => $extension,
      'ruta' => $ftp_params->{'directorio'} . $nombre_tmp . '.' . $extension,
      #:altura => ,
      #:anchura => ,
      #:mime => ,
    );
    my %mensaje2 = App::Provider::Archivo::crear(%archivo);
    if($mensaje2{'codigo'} eq '200'){
      my $temp = %mensaje2{'mensaje'};
      my $rpta = parse_json($temp);
      push $rpta->{'mensaje'}, $App::Config::Constants::Data{'servicio_archivos'} . $nombre_tmp . '.' . $extension;
      $self->render(text =>  JSON::to_json $rpta, status => 200);
    }else{
      my $codigo = int(%mensaje2{'codigo'});
      $self->render(text => Encode::decode('utf8', JSON::to_json \%mensaje2), status => $codigo);
    }
  }else{
    my $codigo = int(%mensaje{'codigo'});
    $self->render(text => Encode::decode('utf8', JSON::to_json \%mensaje), status => $codigo);
  }
}

1;
