# beets-docker

**beets-docker** is a Docker image for developing the [beets](http://beets.io/) music library manager. It allows running a development version of beets cleanly and separately from the host machine.

## Usage

Install [Docker](https://github.com/wsargent/docker-cheat-sheet#installation).

Clone the [beets source code](https://github.com/beetbox/beets).

Pull the image to your machine:

`docker pull elfalem/beets-docker:dev`

There are four [volumes](https://docs.docker.com/engine/tutorials/dockervolumes/#mount-a-host-directory-as-a-data-volume) to mount:

* `/downloads` - your working directory where music will be imported from
* `/music` - your music library location
* `/config` - directory containing your configuration file
* `/code` - the root directory where you have cloned the beets source code

Note: I've only tested the image with the default locations for the library database and music directory. If you've changed these in your configuration file, you probably have to mount those directories as well.

Start a container:

`docker run -it -v your/import/directory:/downloads -v your/music:/music -v your/config:/config -v your/code:/code --name="container-name" elfalem/beets-docker:dev`

* `--name` is an optional name for the container.

Inside the container, you can install beets from your source code:

`sudo pip install -e /code`

Password for `beets` user is `beets`.

You can now run beets in the container and any changes you make to the source code will be reflected.

You can also run tests using `tox` or `nosetests`.

You can exit the container by typing `exit`. The container is still around. You can resume with:

`docker start -ai container-name`

You can permanently remove the container with:

`docker rm container-name`

If you want to automatically remove the container when you exit, you can add `--rm` to the `docker run` command above.

## Other tags
In addition to the `:dev` image, there are two other tagged images in this repository.

* `:standard` - a regular debian image with beets pre-installed. It takes the same volumes as `:dev` except for `/code`. It also lacks packages used for testing.
* `:base` - the base image on which `:standard` and `:dev` are based on. It's just a debian image with python and vim.
