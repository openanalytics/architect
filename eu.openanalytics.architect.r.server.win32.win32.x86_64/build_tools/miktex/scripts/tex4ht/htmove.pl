use File::Copy;
use File::Path;
use File::Basename;

&main ;

0;

sub is_absolute {
  my ($f) = @_;
  return $f =~ m@^([a-zA-Z]:)?[\\/]@ ;
}

sub canonicalize {
  my ($f) = @_;
  $f =~ s@/@\\@g;
  return $f;
}

sub main {
  my $src = &canonicalize($ARGV[0]);
  my $dst = &canonicalize($ARGV[1]);

  if (&is_absolute($src)) {
    if (-d $dst) {
      $dst = $dst . "\\" . &basename($src);
    }
  }
  else {
    if (-d $dst) {
      $dst = "$dst\\$src";
      &mkpath(&dirname($dst));
    }
  }

  if ($0 =~ m/htmove\.pl$/) {
    &move($src, $dst);
  }
  elsif ($0 =~ m/htcopy\.pl$/) {
    &copy($src, $dst);
  }
  else {
    print STDERR "$0: bad verb $ARGV[0]\n";
  }
}
