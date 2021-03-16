# SynNet Protocol Starter



## Download

You can download the contents of this repository by executing:

    wget https://github.com/sdgamboa/synnet_protocol_starter/archive/main.zip
    unzip main.zip
    cd synnet_protocol_starter-main

Before using this protocol, you must source the `set_profile.sh` file:

    source set_profile.sh

Then, you must go to the `db` directory and decompress the data set files:

    cd $db
    tar -xvzf synnet_dataset.tar.gz

Now go to the analyses directory:

    cd $wdir/analyses

Now you're ready to start working with this example working directory for the 
construction of a SynNet.
