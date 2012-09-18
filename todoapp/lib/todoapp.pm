package todoapp;
use Dancer ':syntax';
use Data::Dumper;
use Todo::DB::ORM::Task;
use Todo::DB::ORM::Task::Manager;
use Todo::DB::ORM::StatusCode::Manager;

our $VERSION = '0.1';

get '/tasks' => sub {
	my $tasks = Todo::DB::ORM::Task::Manager->get_tasks_iterator(
		sort_by => params->{sort_field} || 'id',
		(
			params->{filter}
			? (
				query => [
					or => [
						short_description => { like => '%' . params->{filter} . '%' },
						long_description  => { like => '%' . params->{filter} . '%' },
					]
				]
			  )
			: ()
		)
	);
	my $status_codes = Todo::DB::ORM::StatusCode::Manager->get_status_codes_iterator;
	template 'tasks',
	  { tasks => $tasks, status_codes => $status_codes, task_filter => params->{filter} };
};

post '/tasks' => sub {
	my $task = Todo::DB::ORM::Task->new(
		short_description => params->{short_description},
		long_description  => params->{long_description},
		start_date        => params->{start_date},
		end_date          => params->{end_date},
		status_id         => params->{status_id}
	);
	$task->save or die($!);
	return forward '/tasks', {}, { method => 'GET' };
};

del '/task/:task_id' => sub {
	my $task = Todo::DB::ORM::Task->new( id => params->{task_id} );
	$task->delete;
};

get '/task/:task_id' => sub {
	my $task = Todo::DB::ORM::Task->new( id => params->{task_id} );
	my $status_codes = Todo::DB::ORM::StatusCode::Manager->get_status_codes_iterator;
	$task->load;
	template 'task', { task => $task, status_codes => $status_codes };
};

put '/task/:task_id' => sub {
	my $updated = Todo::DB::ORM::Task::Manager->update_tasks(
		set => {
			short_description => params->{short_description},
			long_description  => params->{long_description},
			start_date        => params->{start_date},
			end_date          => params->{end_date},
			status_id         => params->{status_id},
			task_type_id      => 1,
			importance_id     => 1
		},
		where => [
			id  => params->{task_id},
		]
	);
};

true;
