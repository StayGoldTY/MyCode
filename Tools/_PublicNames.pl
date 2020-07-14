# Change PublicName to _PublicName
# used for .XOL upgrade
#
# usage:
#    perl _PubName.pl [options] PublicNamesFile inFile outFile
#    options:
#       -o : overwrite existing output file
#       -v : verbose output
#
# history:
#   20010723  ae   d'après une idée originale de pmd (transfile)

## use strict; # for testing

my($USAGE);
$USAGE = 'perl _PubName.pl [options] PublicNamesFile inFile outFile';

# process options
%main::opts = ();
while (($#ARGV >= 0) && (substr($ARGV[0],0,1) eq '-')) {
   my($opt);
   $opt = shift(@ARGV);
   if ($opt =~ /^-v/i) {
      $main::opts{'Verbose'} = 1;
   }
   elsif ($opt =~ /^-o/i) {
      $main::opts{'Overwrite'} = 1;
   }
}

# retrieve public names file
my($param, $input, $output, $isdir);
$param = shift(@ARGV);
if (!$param) {
   print "$USAGE\n";
   exit(1);
}
if (!-f $param) {
   print "*** error: invalid public names file '$param'\n$USAGE\n";
   exit(1);
}
$input = shift(@ARGV);
if (!$input) { print "$USAGE\n"; exit(1); }
if (-d $input) {
   $isdir = 1;
}
elsif (!-f $input) {
   print "*** error: invalid input file '$input'\n$USAGE\n";
   exit(1);
}
$output = shift(@ARGV);
if (!$output) { print "$USAGE\n"; exit(1); }
if ($isdir && !-d $output) { print "$USAGE\n"; exit(1); }
if ($input eq $output) {
   print "*** error: input and output names must not be the same\n$USAGE\n";
   exit(1);
}
if (!$isdir && -f $output && !$main::opts{'Overwrite'}) {
   print "*** error: output file '$output' already exists\n$USAGE\n";
   exit(1);
}

# read public names file
my(@pnStr);
@pnStr = ();
&ReadParam($param, \@pnStr);
$main::numStr = $#pnStr + 1;

# sort @pnStr on descending length and ascending strings
&SortConvert(\@pnStr);

# work...
if ($isdir)  { &ProcessDir($input, $output, \@pnStr); }
else         { &ProcessFile($input, $output, \@pnStr); }

exit(0);

#------------------------------------------------------------------------------
# read the parameter file
sub ReadParam
{
   my($param, $pnref) = @_;
   if (!$param || !-f $param)  { return 0; }
   if (!open(INFILE, "<$param")) {
      print "*** warning: unable to open public names file '$param'\n";
      return 0;
   }
   my($line, $num);
   $num = 0;
   while (defined($line = <INFILE>)) {
      $num++;
      $line =~ s/^\s*//;
      next if ($line eq '');
      $line =~ s/\s*$//;
      next if ($line =~ /^#/);

      push(@$pnref, $line);
   }
   close(INFILE);
   1;
}

#------------------------------------------------------------------------------
# process all the files from a given directory
sub ProcessDir
{
   my($input, $output, $pnref) = @_;
   if (!$input || !$output || !-d $input || !-d $output) { return 0; }
   opendir(INDIR, $input);

   my(@files, $name);
   @files = readdir(INDIR);
   closedir(INDIR);
   foreach $name (sort @files) {
      next if ($name =~ /^\./);
      next if (!-f "$input\\$name");
      &ProcessFile("$input\\$name", "$output\\$name", $pnref);
   }

   1;
}

#------------------------------------------------------------------------------
# translate strings within a file
sub ProcessFile
{
   my($input, $output, $pnref) = @_;
   if (!$input || !$output || !-f $input) { return 0; }
   if (!open(INFILE, "<$input")) {
      print "*** warning: unable to open input file '$input'\n";
      return 0;
   }
   my($filename);
   $filename = $input;
   $filename =~ s/^.*\\//g;
   $filename =~ s/^.*://g;
   $filename =~ tr/A-Z/a-z/;

   if ($main::opts{'Verbose'}) { print "... processing file '$input'\n"; }
   if ($main::opts{'Verbose'} && -f $output && !$main::opts{'Overwrite'}) {
      print "... the output file '$output' already existed\n";
   }
   
   my(@buffer, $i);
   @buffer = <INFILE>;
   close(INFILE);
   for ($i=0; $i<=$#buffer; $i++) { $buffer[$i] =~ s/[\n\r]*$//; }
   my($lines) = join("\n", @buffer);

   open(OUTFILE, ">$output");
   my($changed, $manip);
   $manip = $lines;
   $changed = 0;
   # translate strings
   for ($i=0; $i<$main::numStr; $i++) {
      my($inStr, $outStr);
      # Definition
      $inStr = ">" . $$pnref[$i] . "<";
      $outStr = ">_" . $$pnref[$i] . "<";
      if ($manip =~ /\Q$inStr\E/) {
         $changed++;
         $manip =~ s/\Q$inStr\E/$outStr/g;
      }
      # Local reference
      $inStr = "%" . $$pnref[$i] . "%";
      $outStr = "%_" . $$pnref[$i] . "%";
      if ($manip =~ /\Q$inStr\E/) {
         $changed++;
         $manip =~ s/\Q$inStr\E/$outStr/g;
      }
      # Qualified reference
      $inStr = "." . $$pnref[$i] . "%";
      $outStr = "._" . $$pnref[$i] . "%";
      if ($manip =~ /\Q$inStr\E/) {
         $changed++;
         $manip =~ s/\Q$inStr\E/$outStr/g;
      }
   }
   
   # write the right string
   if ($changed) { print OUTFILE $manip; }
   else          { print OUTFILE $lines; }
   close(OUTFILE);

   if ($main::opts{'Verbose'} && $changed) { print "... $changed substitutions\n"; }

   1;
}

#------------------------------------------------------------------------------
# sort one array by descending length (at least); keep other arrays synchronized with the first
sub SortConvert
{
   my($pnref) = @_;
   my($i,$j,$n,$s);
   $n = $#$pnref;
   if ($n == -1) { return; }
   # good old bubble
   for ($i=0; $i<=$n-1; $i++) {
      for ($j=$i+1; $j<=$n; $j++) {
         if (length($$pnref[$i]) < length($$pnref[$j])) {
            $s = $$pnref[$i];
            $$pnref[$i] = $$pnref[$j];
            $$pnref[$j] = $s;
         }
      }
   }
}
