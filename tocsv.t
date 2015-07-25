use Test::Simple tests => 2;
use File::Temp qw/ tmpnam unlink0 /;

sub test_tocsv {
  local ($input, $expected_output) = @_;
  local ($infile, $inpath) = tmpnam();
  print $infile $input;
  close($infile);

  local $output = `./tocsv.pl $inpath` or die $!;
  
  ok($expected_output eq $output, <<HERE
Expected: 
$expected_output
Got: 
$output
HERE
  );

  unlink0($infile, $inpath);
};

test_tocsv(
  "1434478731 Lila  [2015.06.16 14:18:51 Tue]\n", 
  "1434478731, Lila\n"
);
test_tocsv(
  "1434478731 Dentist Ouch [2015.06.16 14:18:51 Tue]\n", 
  "1434478731, Dentist\n1434478731, Ouch\n"
);
test_tocsv(
  "1434478731 Lila  [2015.06.16 14:18:51 Tue]\n1434478732  [2015.06.16 14:18:51 Tue]\n", 
  "1434478731, Lila\n1434478732,"
);
