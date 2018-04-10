package App::Config::Helpers;
use App::Config::Constants;

my $data = \%App::Config::Constants::Data;

our %ViewHelpers = (
  loas_css => sub {
    my(@csss) = @_;
    my $rpta = '';
    for my $css(@csss){
      my $url = $data->{'STATIC_URL'};
      my $temp = '<link rel="stylesheet" type="text/css" href="' . $url . $css . '.css"/>';
      $rpta = $rpta . $temp;
    }
    return $rpta;
  },
  load_js => sub {
    my(@jss) = @_;
    my $rpta = '';
    for my $js(@jss){
      my $url = $data->{'STATIC_URL'};
      my $temp = '<script src="' . $url . $js . '.js" type="text/javascript"></script>';
      $rpta = $rpta . $temp;
    }
    return $rpta;
  },
  demo => sub {
    return 'HELPER DEMO';
  }
);

our $x = 1000;

1;
