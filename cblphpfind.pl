#!/usr/bin/perl
# The above line may need to be changed to point at your version of Perl

# Very simple web malware detection module.
# Author: CBL Team <cbl@cbl.abuseat.org>
# Version 0.02
# Change history:
#      .01->.02: search 100 lines, add socket to scriptpat (2011/11/25)

# List of access-control files to check
my $access = '(\.htaccess)';
# Patterns to look for in access-control files
my $accesspat = '(RewriteRule)';

my $MAXLINES = 100;

# List of files to check
my $scripts = '\.(php|pl|cgi)$';
# Patterns to look for
my $scriptpat = '(socket|r57|c99|web shell|passthru|shell_exec|phpinfo|base64_decode|edoced_46esab|PHPShell)';

for my $dir (@ARGV) {
    &recursion($dir, $access, $accesspat);
    &recursion($dir, $scripts, $scriptpat);
}

sub recursion {
    my ($dir, $filepat, $patterns) = @_;
    my (@list);
    opendir(I, "$dir") || die "Can't open $dir: $!";
    @list = readdir(I);
    closedir(I);
    for my $file (@list) {
        next if $file =~ /^\.\.?$/;     # skip . and ..
        my $currentfile = "$dir/$file";
        if (-d $currentfile) {
            &recursion($currentfile, $filepat, $patterns);
        } elsif ($currentfile =~ /$filepat/) {
#print $currentfile, "\n";
            open(I, "<$currentfile") || next;
            my $linecount = 1;
            while(<I>) {
                chomp;
                if ($_ =~ /$patterns/) {
                    my $pat = $1;
                    my $string = $_;
                    if ($string =~ /^(.*)$pat(.*)$/) {
                        $string = substr($1, length($1)-10, 10) .
                                  $pat .
                                  substr($2, 0, 10);
                    }
                    #$string =~ s/^.*(.{,10}$pat.{,10}).*$/... $1 .../;
                    print "$currentfile: Suspicious($pat): $string\n";
                    last;
                }
                last if $linecount++ > $MAXLINES;
             }
             close(I);
            #print $currentfile, "\n";
        }
    }
}

