# This script adds back a prefix that previous versions of PowerDesigner
# inserted automatically in front of objects. The script takes a list of 
# names of PowerDesigner files (saved as XML file) and modify them in place,
# keeping a backup for every updated file with a .bak extension.
#
# Usage:
#    perl prefix.pl {file names}
#
# Version 1.0
#    2001-02-15  first version

   $BACKUP = '.bak';
   while (defined($name = shift(@ARGV))) {
      my(@contents, @orig);
      next if (!-f $name || !open(FILE, "<$name"));
      @contents = <FILE>;
      close(FILE);
      @orig = @contents;

      my($changed, @msgs);
      $changed = 0;

      # apply the modification rules
      if (&InsertPrefix(\@contents, 'SPdoObjDomn', 'T_', \@msgs)) { $changed = 1; }

      if ($changed) {
         print "... updating the file $name\n";
         my($line);
         foreach $line (@msgs) {
            print "    $line\n";
         }
         my($bak);
         $bak = $name.$BACKUP;
         # remove any file with the name of my backup
         if (-f $bak) { unlink($bak); }
         # write the backup file
         open(FILE, ">$bak");
         print FILE @orig;
         close(FILE);
         # write the modified file
         open(FILE, ">$name");
         print FILE @contents;
         close(FILE);
      }
   }

#-----------------------------------------------
# add the given prefix in from of the right objects
# parameters:
#    . reference of the array containing the model text
#    . name of the object type to look for
#    . prefix to add in front of these objects
#    . optional array into which to push messages
sub InsertPrefix
{
   my($cntref, $type, $prefix, $msgref) = @_;
   if (!$cntref || !defined($type) || !defined($prefix)) { return 0; }

   my($status, $line, $attName, $changed);
   $status = 0;
   $changed = 0;
   foreach $line (@$cntref) {
      if ($status == 0) {  # default status
         if ($line =~ /^\s*<o:$type/) {
            $status = 1;
         }
      } elsif ($status == 1) {  # within right Object type
         if ($line =~ /^\s*<c:/ ||
             $line =~ /^\s*<\/o:/) {
            # reset status when we get a collection,
            # or the end of the object
            $status = 0;
         } elsif ($line =~ /^\s*<a:Code>/) {
            # on Code line, replace if needed and reset status
            my($init, $middle, $finish, $modif);
            ($init, $middle, $finish) = $line =~ /^(.*<a:Code>)(.*)(<\/a:Code>.*)$/;
            if ($middle !~ /^$prefix/) {
               $modif = $prefix.$middle;
               $line = $init.$modif.$finish;
               $changed = 1;
               if ($msgref) {
                  push(@$msgref, "renaming $middle as $modif");
               }
            }
            $status = 0;
            next;
         }
      }
   }

   $changed;
}