package todoapp;
use Dancer ':syntax';
use Todo::DB::ORM::Task;
use Todo::DB::ORM::Task::Manager;
use Todo::DB::ORM::StatusCode::Manager;

our $VERSION = '0.1';

get '/' => sub {
	template 'index';
};

get '/tasks' => sub {
	my $tasks = Todo::DB::ORM::Task::Manager->get_tasks_iterator;
	my $status_codes = Todo::DB::ORM::StatusCode::Manager->get_status_code_iterator;
	template 'tasks', { tasks => $tasks, status_codes => $status_codes };
};

post '/tasks' => sub {
	my $task = Todo::DB::ORM::Task->new(
		short_description  => params->{short_description},
		long_description   => params->{long_description},
		start_date         => params->{start_date},
		end_date           => params->{end_date},
		status             => params->{status}
	);
	$task->save;
	return forward '/tasks', {}, { method => 'GET' };
};

del '/task/:task_id' => sub {
	my $task = Todo::DB::ORM::Task->new( id => params->{task_id} );
	$task->delete;
};

true;
