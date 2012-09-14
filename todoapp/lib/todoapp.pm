package todoapp;
use Dancer ':syntax';
use Todo::DB::ORM::Task;

our $VERSION = '0.1';

get '/' => sub {
    template 'index';
};

true;
