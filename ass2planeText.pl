use strict;
use warnings;
use utf8;
use File::Find::Rule;

print "Folder: ";
chomp( my $dir = <STDIN> );
my @ass = File::Find::Rule->file->name('*.ass')->in($dir);

for my $ass (@ass){
	( my $txt = $ass ) =~ s{\.ass$}{\.txt};
	print $ass ."\n";

	open my $in, '<', $ass or die $!;
	open my $out, '>', $txt or die $!;

	while ( my $l = <$in> ){
		# Ass assumptions made in Aegisub
		if ( $l =~ m|^.+?: \d,\d:\d\d:\d\d\.\d\d,\d:\d\d:\d\d\.\d\d,.+?,,\d,\d,\d,,(.+)$| ){
			print {$out} $1 ."\n";
		}
	}

	close $in;
	close $out;
	
}

print "\nDone!\n";
system 'pause > nul';
