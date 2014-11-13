class TodoApp < CommandLineApp
  def initialize(input, output)
    @input = input
    @output = output
    @projects_and_tasks = {}
  end

  def run
    print_project_menu

    app_running = true

    while app_running
      input = gets.chomp
      if input == 'list'
        list_projects
      elsif input == 'create'
        create_a_project
      elsif input == 'delete'
        delete_a_project
      elsif input == 'rename'
        rename_the_project
      elsif input == 'edit'
        edit_the_project
      elsif input == 'quit'
        app_running = false
      end
    end
  end

  def create_a_project
    puts "Please enter the new project name:\n"
    new_project = gets.chomp
    add_project(new_project)
    print_project_menu
  end

  def delete_a_project
    puts "Please enter the project name to delete:\n"
    project = gets.chomp
    if valid_project_name?(project)
      delete_project(project)
    end
  end

  def rename_the_project
    puts "Please enter the project name to rename:\n"
    project = gets.chomp
    if valid_project_name?(project)
      puts "Please enter the new project name:\n"
      new_project_name = gets.chomp
      delete_project(project)
      add_project(new_project_name)
    end
  end

  def edit_the_project
    puts "Which project would you like to edit?\n"
    puts "Projects:\n  *#{print_projects} "
    project = gets.chomp
    if valid_project_name?(project)
      puts "Editing Project: #{project} "
      print_task_menu
      editing_tasks_for_this(project)
    end
  end

  def editing_tasks_for_this(project)
    task_menu_running = true
    while task_menu_running
      task_input = gets.chomp
      if task_input == 'list'
        list_tasks(project)
      elsif task_input == 'create'
        create_a_task(project)
      elsif task_input == 'edit'
        edit_a_task(project)
      elsif task_input == 'complete'
        complete_a_task(project)
      elsif task_input == 'back'
        print_project_menu
        task_menu_running = false
      elsif task_input == 'quit'
        app_running = false
        task_menu_running = false
      end
    end
  end

  def create_a_task (project)
    puts "Please enter the task you would like to add."
    task = gets.chomp
    add_task_to_project(project, task)
  end

  def edit_a_task(project)
    puts "Please enter the task you would like to edit."
    task = gets.chomp
    if valid_task?(project, task)
      puts "Please enter the new task name:\n"
      new_task_name = gets.chomp
      delete_task(project, task)
      add_task_to_project(project, new_task_name)
    else
      puts "task not found: 'not here'"
    end
  end

  def complete_a_task(project)
    puts "Which task have you completed?"
    puts "  #{print_tasks(project)}"
    task = gets.chomp
    if valid_task?(project, task)
      delete_task(project, task)
      task = "#{task}: completed"
      add_task_to_project(project, task)
    else
      puts "task not found: 'not here'"
    end
  end

  #Printer

  def print_project_menu
    puts "Welcome"
    puts "'list' to list projects"
    puts "'create' to create a new project"
    puts "'edit' to edit a project"
    puts "'rename' to rename a project"
    puts "'delete' to rename a project"
  end

  def print_task_menu
    puts "'list' to list tasks"
    puts "'create' to create a new task"
    puts "'edit' to edit a task"
    puts "'complete' to complete a task and remove it from the list"
  end

  def list_projects
    puts "Projects:\n  #{print_projects} "
  end

  def list_tasks(project)
    puts "  #{print_tasks(project)}"
  end

  def print_tasks(project)
    print_tasks =''
    if @projects_and_tasks[project] == []
      "none"
    else
      print_tasks = @projects_and_tasks[project].each do |name|
         name
      end
    puts print_tasks.join(" ")
    end
  end

  def print_projects
    list_project_names = ''
    if @projects_and_tasks == {}
      "none"
    else
      list_project_names = @projects_and_tasks.keys
      list_project_names.join(" ")
    end
  end

  #Data
  def add_project(project)
    tasks = []
    @projects_and_tasks.merge!(project => tasks)
  end

  def valid_project_name?(project_name)
    if @projects_and_tasks.include?(project_name)
      true
    else
      false
    end
  end

  def delete_project(project)
    @projects_and_tasks.delete(project)
  end

  def add_task_to_project (project, task)
    @projects_and_tasks[project].push(task)
  end

  def valid_task?(project, task)
    if @projects_and_tasks[project].include?(task)
      true
    else
      false
    end
  end

  def delete_task(project, task)
    @projects_and_tasks[project].delete(task)
  end

  def real_puts message = ""
    $stdout.puts message
  end
end
