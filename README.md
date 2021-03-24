# SynNet Protocol Starter



## Download

You can get a copy of this repository with:

    git clone https://github.com/sdgamboa/synnet_protocol_starter.git
    
Before using this protocol, you must source the `set_profile.sh` file:

    cd synnet_protocol_starter
    source set_profile.sh

Then, you must go to the `db` directory and decompress the data set files:

    cd $db
    tar -xvzf synnet_dataset.tar.gz

Now you're ready to start working with this example working directory for the 
construction of a SynNet.

## Contents

| File/Directory | Description |
| :------------: | ----------- |
| [analyses](./analyses) | Directory where most analyses will take place following the protocol instructions. |
| [db](./db) | Directory where sample data sets and the SynNet are stored. |
| [files](./files) | Files that are helpful to complete this protocol (homology searches, list of ids, phylogeny, etc). |
| [scripts](./scripts) | Script files written in bash or R. |
| [set_profile.sh](./set_profile.sh) | File to be sourced before starting the steps of the protocol. |
