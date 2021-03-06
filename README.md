![Welcome to Autolab](https://github.com/autolab/Autolab/blob/master/public/images/autolab_logo.png)

Autolab is a course management service, initially developed by a team of students at Carnegie Mellon University, that enables instructors to offer autograded programming assignments to their students over the Web. The two key ideas in Autolab are *autograding*, that is, programs evaluating other programs, and *scoreboards*.

Autolab also provides other services that instructors expect in a course management system, including gradebooks, rosters, handins/handouts, lab writeups, code annotation, manual grading, late penalties, grace days, cheat checking, meetings, partners, and bulk emails.

**Autograding.** Each time a student submits their work, the system autogrades it and stores the results in a gradebook. Autograders and the programs they evaluate can be written in any language and use any software packages. The model for a traditional programming class is that students work on their code, hand it in once, and then get feedback a week or two later, at which point they've already moved on to the next assignment. Autograding, on the other hand, allows students to get immediate feedback on their performance.

**Scoreboard.** The latest autograded scores for each student are displayed, rank ordered, on a real-time scoreboard. The scoreboard is a fun and powerful motivation for students. When coupled with autograding, it creates a sense of community and a healthy competition that seems to benefit everyone. Students anonymize themselves on the scoreboard by giving themselves nicknames. A mix of curiosity and competitiveness drives the stronger students to be at the top of the scoreboard, and all students have a clear idea of what they need for full credit. In our experience, everyone wins.

Since 2010, Autolab has had a transformative impact on education at CMU. Each semester, it is used by about 3,000 CMU students in courses in Pittsburgh, Silicon Valley, Qatar, and Rwanda. In Fall, 2014, we are releasing Autolab as an open-source system, where it will be available to schools all over the world, and hopefully have the same impact it's had at CMU.

This is the main repository that includes the application layer of the project. Installing other services are optional but highly recommended for full functionality. For further information:

* [Tango Service] (https://github.com/autolab/Tango)


## Getting Started


1. Install rbenv (Basic GitHub Checkout method): [Github rbenv](https://github.com/sstephenson/rbenv)


2. Install ruby-build (as an rbenv plugin): [Github ruby-build](https://github.com/sstephenson/ruby-build)
	```sh
	git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
	```

	_(You might need to restart your shell at this point in order to start using your newly installed rbenv)_
3. Install the version of ruby in the text file `.ruby-version`:
	```sh
	rbenv install 2.1.2
	```
 At this point, confirm that `rbenv` is working (depending on your shell, you might need to logout and log back in):

  ```
  $ which ruby
  ~/.rbenv/shims/ruby

  $ which rake
  ~/.rbenv/shims/rake
  ```

5. Install `bundler`:

  ```
  gem install bundler
  rbenv rehash
  ```

5. `cd` into `autolab-src` and install the required gems:

  ```sh
  bundle install
  ```
  You need to have MySQL installed before hand.


5.  Configure your database next. You need to fill the `username` and `password` fields on 		`config/database.yml.template` and rename it to `config/database.yml`. Depending on how you installed MySQL and which platform you're running on, you might have to change the database socket setting in this file. Search online to determine where your MySQL server's socket is if you don't already know.

6. Create and initialize the database tables:

	```sh
	bundle exec rake db:create
	bundle exec rake db:migrate
	```
   Do not forget to use `bundle exec` in fron of every rake/rails command.


7. (Optional) Populate dummy data for development purposes:

	```sh
	rake autolab:populate
	```

	(#TODO: make it so that setup.sh initiates the directories)


8. Start rails server:

	```sh
	bundle exec rails s -p 3000
	```

9. Go to <yoururl>:3000 to see if the application is running. You can use the `Developer Login` option with the email "admin@foo.bar".


## Testing

You can run the tests by:

```sh
bundle exec rake spec
```

We have a very limited testing suite at the moment, but we are working on it.

## Contributing

We encourage you to contribute to Autolab! Please check out the
[Contributing to Autolab Guide](#) for guidelines about how to proceed. [Join us!](http://contributors.autolabproject.org)



## License

Autolab is released under the [Apache License 2.0](http://opensource.org/licenses/Apache-2.0).

## Using Autolab

Please feel free to use Autolab at your school/organization. If you run into any problems, you can reach the core developers at `autolab-dev@andrew.cmu.edu` and we would be happy to help. On a case by case basis, we also provide servers for free. (Especially if you are an NGO or small high-school classroom)
