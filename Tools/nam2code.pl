$status = 0;
while (defined($line = <>)) {
   $line =~ s/\s*$//;
   if ($status == 0) {  # default status
      if ($line =~ /^\s*<o:SPdoObjTabl/ ||
          $line =~ /^\s*<o:SPdoObjColn/) {
         $status = 1;
         $attName = '';
      }
   } elsif ($status == 1) {  # within Object
      if ($line =~ /^\s*<c:/ ||
          $line =~ /^\s*<\/o:/) {
         # reset status when we get a collection,
         # or the end of the object
         $status = 0;
      } elsif ($line =~ /^\s*<a:Name/) {
         # prepare a Code line as a copy of the Name line
         $attName = $line;
         $attName =~ s/a:Name/a:Code/g;
      } elsif ($line =~ /^\s*<a:Code/) {
         # on Code line, replace and reset status
         print $attName,"\n";
         $status = 0;
         next;
      }
   }
   print $line,"\n";
}
