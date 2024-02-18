# ADMINISTRATION

-As with any server, any app running on any server, that server will also need to be maintain and administered, as Jenkins is nothing more than an APP running on a system

-So you need to think about:
		-backing up that server and/or backing up specific files and folders
		-think about your restore strategy
		-a backup is only as good as the restore policy
		-because it is an actual application running on a system you need to think about how to monitor jenkins
		-scaling, as a system is only as good as how it can scale
		-you also need to understand how to manage jenkins, because there is a whole system underneath, and things like updates and patches that need to be done


# BACKUPS
It is crucial to have adequate backups of your Jenkins instance. Backups are
used to recover from accidental configuration changes. Recovering a file that
has been mistakenly erased or has been corrupted. Or just to recover a
previous setup.

-For Jenkins you can have available for Jenkins, and primarily for the system:
		-full backups
		-snapshots
		-decremental backups
Because you know, even though the application can still be running, but the system underneath itself still needs to also be backed up or patched up

### What needs to be backed up?
-The primary place to be backup is the Jenkins main directory:
$JENKINS_HOME

-In that Jenkins home folder, you are going to have your:
		-configuration files, the config.xml, which is the configuration for jenkins
		-you will also have the "jobs" folder, and these jobs are ALL of your pipelines
So all of these needs ot be backed up, or else you could lose literally lose every single CI pipeline, every single CD pipeline, so essentially, all of your work

### How to Backup Jenkins?
-When it comes to backup jenkins, there is not like a "specific" solution that you would use, it is kind of up to 3 different ways

-3 ways to create backups:
1) Filesystem snapshots, not recommended for long term solution, but good for like "daily" backups kind of thing
2) Using Plugins for backups (something like a plugin named ThinBackup)
3) Using custom shell script (writing a shell script that backs up the Jenkins instance) (in github look for a repo called "sue445/jenkins-backup-script")

### Using ThinBackup Plugin
To backup Jenkins using a plugin, you will first need to install a backup plugin.
Some of the most commonly used plugins are ThinBackup, Periodic Backup,
Google cloud Backup.

-For backing up using ThinkBack (or maybe even any other backup plugin) there are a few general steps that must be followed:
1) Creating a backup directory with read and write access (in the system/host where jenkins is running)
2) Selecting files that need backup

### Backing up using shell script
Please check out these popular repositories for your reference:
1) repository: https://github.com/sue445/jenkins-backup-script
2) gist: https://gist.github.com/abayer/527063a4519f205efc74
