package todoapp;
use Dancer ':syntax';
use Data::Dumper;
use Todo::DB::ORM::Task;
use Todo::DB::ORM::Task::Manager;
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
	my $iterators = get_table_iterators();
	#my $status_codes = Todo::DB::ORM::StatusCode::Manager->get_status_codes_iterator;
	template 'tasks',
	  { tasks => $tasks, iterators => $iterators, task_filter => params->{filter} };
};

post '/tasks' => sub {
	my $task = Todo::DB::ORM::Task->new(
		short_description => params->{short_description},
		long_description  => params->{long_description},
		start_date        => params->{start_date},
		end_date          => params->{end_date},
		status_id         => params->{status_id},
		task_type_id	  => params->{task_type_id},
		importance_id     => params->{importance_id}
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
	my $iterators = get_table_iterators();
	$task->load;
	template 'task', { task => $task, iterators => $iterators };
};

put '/task/:task_id' => sub {
	my $updated = Todo::DB::ORM::Task::Manager->update_tasks(
		set => {
			short_description => params->{short_description},
			long_description  => params->{long_description},
			start_date        => params->{start_date},
			end_date          => params->{end_date},
			status_id         => params->{status_id},
			task_type_id	  => params->{task_type_id},
			importance_id     => params->{importance_id}
		},
		where => [
			id  => params->{task_id},
		]
	);
};

sub get_table_iterators {
	require Todo::DB::ORM::StatusCode::Manager;
	require Todo::DB::ORM::Importance::Manager;
	require Todo::DB::ORM::TaskType::Manager;
	return {
		status_codes => Todo::DB::ORM::StatusCode::Manager->get_status_codes_iterator,
		task_types   => Todo::DB::ORM::TaskType::Manager->get_task_types_iterator,
		importance   => Todo::DB::ORM::Importance::Manager->get_importance_iterator
	};
}

true;
