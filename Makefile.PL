#!/usr/bin/env perl
use inc::Module::Install;

name 'Todo-App';
all_from 'todoapp/lib/Todo/App.pm';

requires 'Rose::DB::Object';
requires 'DBI';
requires 'DBD::SQLite';
requires 'Dancer';
requires 'Template';
requires 'Plack';
requires 'YAML';

auto_install;


my $db_class_maker =
  File::Spec->catdir('bin','make_db_classes');
 
install_script $db_class_maker;
 
postamble <<"EOP";
install :: install_db_class_maker
 
install_db_class_maker :
\t\$(PERL) $db_class_maker @ARGV

clean :: clean_generated_classes

clean_generated_classes :
\t\$(RM_RF) todoapp/lib/Todo/DB/ORM/

EOP

WriteAll;
