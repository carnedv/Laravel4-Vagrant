class mysql 
{
    $mysqlPassword = ""
 
    package 
    { 
        "mysql-server":
            ensure  => present,
            require => Exec['apt-get update']
    }

    service 
    { 
        "mysql":
            enable => true,
            ensure => running,
            require => Package["mysql-server"],
    }

    # Make sure that any previously setup boxes are gracefully 
    # transitioned to the new empty root password.
    exec
    {
    	"set-mysql-password":
            onlyif => "mysqladmin -uroot -proot status",
            command => "mysqladmin -uroot -proot password $mysqlPassword",
            require => Service["mysql"],
    }
}
