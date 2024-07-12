# SynNet Protocol Starter



## Download

You can get a copy of this repository with:

    git clone https://github.com/sdgamboa/synnet_protocol_starter.git
    
Before using this protocol, you must source the `set_profile.sh` file:

    cd synnet_protocol_starter
    source set_profile.sh

Then, you must go to the `db` directory and decompress the data set files:

    cd $db
    curl https://zenodo.org/record/5546148/files/synnet_dataset.tar.gz?download=1 --output synnet_dataset.tar.gz
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


## Disclaimer

This is a modified version of the workflow
provided at https://github.com/zhaotao1987/SynNet-Pipeline. Please refer to
the original version for the latest developments. Be sure to cite the
original work of the workflow. This information can be found in the same URL
mentioned above.

The code in this repository is provided as is and therefore comes with no
warranty. The authors take no responsibility for any loses or inaccuracies.

If you find any errors in the code or typos you're welcome to post an issue.

Please refer to https://link.springer.com/protocol/10.1007/978-1-0716-2429-6_12
to read the full protocol proposed in this repository.

## ARCHIVE

This repository was archived on July 12, 2024.

