#!/usr/bin/env perl
use inc::Module::Install;

name 'Todo-App';
all_from 'lib/Todo/App.pm';

requires 'Rose::DB::Object';
requires 'DBI';
requires 'DBD::SQLite';
requires 'Dancer';
requires 'Template';
requires 'Plack';

auto_install;

WriteAll;
