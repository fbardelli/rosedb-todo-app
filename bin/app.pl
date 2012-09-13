#!/usr/bin/perl

use Dancer;
use DBI;

get '/hello/:name' => sub {
    return "Why, hello there " . param('name');
};

get '/showdb' => sub {
  my $dbh = DBI->connect("dbi:SQLite:dbname=db/todo","","");
  my $sth = $dbh->prepare('select * from status_code');
  $sth->execute;
  my $str ="";
  while (my $row = $sth->fetchrow_hashref){
    $str .= $row->{id} . ":" . $row->{name} . "\n";
  }
  return $str;
};

dance;
