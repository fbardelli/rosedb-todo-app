package todoapp;
use Dancer ':syntax';
use Todo::DB::ORM::Task::Manager;

our $VERSION = '0.1';

get '/' => sub {
	template 'index';
};

get '/tasks' => sub {
	my $tasks = Todo::DB::ORM::Task::Manager->get_tasks_iterator;
	template 'tasks', { tasks => $tasks } ;
};

true;
