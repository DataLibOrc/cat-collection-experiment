#!/usr/bin/perl

=pod
DataLibOrc
catfile1.pl
=cut

=pod
The point of this file is to be able to take a text file and 
*Display it
*Add to it
=cut 

use feature ':5.10'; #For use of modern features


TOP:

my $catlist = './catlist.txt'; #catlist, see loop3.pl for initial setup
my $datetime = localtime();

START:
say "Welcome to the Streamlined Cat Edit File";
sleep(1);

SELECT:
say "Please choose from the following";
say "(VIEW) - View current list";
say "(ADD) = Add to current list";
say "(EXIT) - Exit the program";
$user_response = <>;
chomp($user_response);

if ($user_response eq "VIEW") {
	VIEW:
	say "-----------------------------------------";
	open (my $fh, '<:encoding(UTF-8)', $catlist)
	or die "Could not open file '$catlist', $!";

	while (my $row = <$fh>) {
		chomp ($row);
		print "$row\n";
	}
	say "LIST GENERATED AT $datetime";
	say "-----------------------------------------";
	goto SELECT;
} elsif ($user_response eq "ADD") {
	ADD:
	open(my $fh, '>>', $catlist)
	or die "Could not open file '$catlist', $!";
	ADD2:
	say "Please input the name of the cat you wish to add to the repositroy";
	$catname = <>;
	chomp($catname);
	print $fh "\n$catname --- ADDED BY USER";
	say "$catname sucessfully added";
	say "----------------------------------------";
	ADDCHOICE:
	say "Please choose from the following";
	say "(ADD) to add another cat";
	say "(MENU) to go to the main menu";
	$user_response2 = <>;
	chomp ($user_response2);				#lacking the chomp command will cause all user responses to be viewed as invalid inputs due to extra blankspace

	if ($user_response2 eq "ADD") {
		goto ADD;
	} elsif ($user_response2 eq "MENU") {
		goto SELECT;
	} else {
		say "Please enter a valid command";
		goto ADDCHOICE;
	}
	

} elsif ($user_response eq "EXIT") {
	EXIT:
	say "Thank you";
	sleep(2);
	say "End of program";
	exit;
} else {
	say "PLEASE ENTER A VALID COMMAND";
	goto START;
}