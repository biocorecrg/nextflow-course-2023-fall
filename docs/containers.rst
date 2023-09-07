.. _containers-page:

*******************
Containers
*******************

Linux containers
================

What are containers?
---------------------

.. image:: https://www.synopsys.com/blogs/software-security/wp-content/uploads/2018/04/containers-rsa.jpg
  :width: 700

A Container can be seen as a **minimal virtual environment** that can be used in any Linux-compatible machine (and beyond).

Using containers is time- and resource-saving as they allow:

* Controlling for software installation and dependencies.
* Reproducibility of the analysis.

Containers allow us to use **exactly the same versions of the tools**.

Virtual machines or containers ?
----------------------------------

=====================================================  =====================================================
Virtualisation                                         Containerisation (aka lightweight virtualisation)
=====================================================  =====================================================
Abstraction of physical hardware                       Abstraction of application layer
Depends on hypervisor (software)                       Depends on host kernel (OS)
Do not confuse with hardware emulator                  Application and dependencies bundled all together
Enable virtual machines                                Every virtual machine with an OS (Operating System)
=====================================================  =====================================================

Virtual machines vs containers
----------------------------------------

.. image:: https://raw.githubusercontent.com/collabnix/dockerlabs/master/beginners/docker/images/vm-docker5.png
  :width: 800

`Source <https://dockerlabs.collabnix.com/beginners/difference-docker-vm.html>`__


**Pros and cons**

===== ===================================================== =====================================================
ADV   Virtualisation                                        Containerisation
===== ===================================================== =====================================================
PROS. * Very similar to a full OS.     			     * No need of full OS installation (less space).
      * High OS diversity       			     * Better portability
      							     * Faster than virtual machines.
							     * Easier automation.
							     * Easier distribution of recipes.
							     * Better portability.


CONS. * Need more space and resources.                       * Some cases might not be exactly the same as a full OS.
      * Slower than containers.                              * Still less OS diversity, even with current solutions
      * Not that good automation.
===== ===================================================== =====================================================


Docker
======

.. image:: https://connpass-tokyo.s3.amazonaws.com/thumbs/80/52/80521f18aec0945dfedbb471dad6aa1a.png
  :width: 400


What is Docker?
-------------------

* Platform for developing, shipping and running applications.
* Infrastructure as application / code.
* First version: 2013.
* Company: originally dotCloud (2010), later named Docker.
* Established `Open Container Initiative <https://www.opencontainers.org/>`__.

As a software:

* `Docker Community Edition <https://www.docker.com/products/container-runtime>`__.
* Docker Enterprise Edition.

There is an increasing number of alternative container technologies and providers. Many of them are actually based on software components originally from the Docker stack and they normally try to address some specific use cases or weakpoints. As a example, **Singularity**, that we introduce later in this couse, is focused in HPC environments. Another case, **Podman**, keeps a high functional compatibility with Docker but with a different focus on technology (not keeping a daemon) and permissions.


Docker components
--------------------

.. image:: http://apachebooster.com/kb/wp-content/uploads/2017/09/docker-architecture.png
  :width: 700

* Read-only templates.
* Containers are run from them.
* Images are not run.
* Images have several layers.

.. image:: https://i.stack.imgur.com/vGuay.png
  :width: 700

Images versus containers
----------------------------

* **Image**: A set of layers, read-only templates, inert.
* An instance of an image is called a **container**.

When you start an image, you have a running container of this image. You can have many running containers of the same image.

*"The image is the recipe, the container is the cake; you can make as many cakes as you like with a given recipe."*

https://stackoverflow.com/questions/23735149/what-is-the-difference-between-a-docker-image-and-a-container


Docker vocabulary
----------------------------

.. code-block:: console

  docker


.. image:: images/docker_vocab.png
  :width: 550

Get help:

.. code-block:: console

  docker run --help


.. image:: images/docker_run_help.png
  :width: 550


Using existing images
---------------------

Explore Docker hub
******************

Images can be stored locally or shared in a registry.


`Docker hub <https://hub.docker.com/>`__ is the main public registry for Docker images.


Let's search the keyword **ubuntu**:

.. image:: images/dockerhub_ubuntu.png
  :width: 900

docker pull: import image
*************************

* get latest image / latest release

.. code-block:: console

  docker pull ubuntu


.. image:: images/docker_pull.png
  :width: 650

* choose the version of Ubuntu you are fetching: check the different tags

.. image:: images/dockerhub_ubuntu_1804.png
  :width: 850

.. code-block:: console

  docker pull ubuntu:18.04


Biocontainers
*************

https://biocontainers.pro/

Specific directory of Bioinformatics related entries

* Entries in `Docker hub <https://hub.docker.com/u/biocontainers>`__ and/or `Quay.io <https://quay.io>`__ (RedHat registry)

* Normally created from `Bioconda <https://bioconda.github.io>`__

Example: **FastQC**

https://biocontainers.pro/#/tools/fastqc


.. code-block:: console

    docker pull biocontainers/fastqc:v0.11.9_cv7

docker images: list images
--------------------------

.. code-block:: console

  docker images

.. image:: images/docker_images_list.png
  :width: 650

Each image has a unique **IMAGE ID**.

docker run: run image, i.e. start a container
---------------------------------------------

Now we want to use what is **inside** the image.


**docker run** creates a fresh container (active instance of the image) from a **Docker (static) image**, and runs it.


The format is:

docker run image:tag **command**

.. code-block:: console

  docker run ubuntu:18.04 /bin/ls


.. image:: images/docker_run_ls.png
  :width: 200

Now execute **ls** in your current working directory: is the result the same?


You can execute any program/command that is stored inside the image:

.. code-block:: console

  docker run ubuntu:18.04 /bin/whoami
  docker run ubuntu:18.04 cat /etc/issue


You can either execute programs in the image from the command line (see above) or **execute a container interactively**, i.e. **"enter"** the container.

.. code-block:: console

  docker run -it ubuntu:18.04 /bin/bash


Run container as daemon (in background)

.. code-block:: console

  docker run -ti --detach ubuntu:18.04

  docker run --detach ubuntu:18.04 tail -f /dev/null
  

Run container as daemon (in background) with a given name

.. code-block:: console

  docker run -ti --detach --name myubuntu ubuntu:18.04

  docker run --detach --name myubuntu ubuntu:18.04 tail -f /dev/null


docker ps: check containers status
----------------------------------

List running containers:

.. code-block:: console

  docker ps


List all containers (whether they are running or not):

.. code-block:: console

  docker ps -a


Each container has a unique ID.

docker exec: execute process in running container
-------------------------------------------------

.. code-block:: console

  docker exec myubuntu uname -a


* Interactively

.. code-block:: console

  docker exec -it myubuntu /bin/bash


docker stop, start, restart: actions on container
-------------------------------------------------

Stop a running container:

.. code-block:: console

  docker stop myubuntu

  docker ps -a


Start a stopped container (does NOT create a new one):

.. code-block:: console

  docker start myubuntu

  docker ps -a


Restart a running container:

.. code-block:: console

  docker restart myubuntu

  docker ps -a


Run with restart enabled

.. code-block:: console

  docker run --restart=unless-stopped --detach --name myubuntu2 ubuntu:18.04 tail -f /dev/null

* Restart policies: no (default), always, on-failure, unless-stopped

Update restart policy

.. code-block:: console

  docker update --restart unless-stopped myubuntu


docker rm, docker rmi: clean up!
--------------------------------

.. code-block:: console

  docker rm myubuntu
  docker rm -f myubuntu


.. code-block:: console

  docker rmi ubuntu:18.04


Major clean
***********

Check used space

.. code-block:: console

  docker system df


Remove unused containers (and others) - **DO WITH CARE**

.. code-block:: console

  docker system prune


Remove ALL non-running containers, images, etc. - **DO WITH MUCH MORE CARE!!!**

.. code-block:: console

  docker system prune -a

* Reference: https://www.digitalocean.com/community/tutorials/how-to-remove-docker-images-containers-and-volumes


Volumes
-------

Docker containers are fully isolated. It is necessary to mount volumes in order to handle input/output files.

Syntax: **--volume/-v** *host:container*

.. code-block:: console

  mkdir data
  touch data/test
  # We can also copy the FASTQ we used in previous exercises... cp ...
  docker run --detach --volume $(pwd)/data:/scratch --name fastqc_container biocontainers/fastqc:v0.11.9_cv7 tail -f /dev/null
  docker exec -ti fastqc_container /bin/bash
  > ls -l /scratch
  # We can also run fastqc from here
  > cd /scratch; fastqc SRR6466185_1.fastq.gz 
  > exit


Singularity
===========


* Focus:
	* Reproducibility to scientific computing and the high-performance computing (HPC) world.
* Origin: Lawrence Berkeley National Laboratory. Later spin-off: Sylabs
* Version 1.0 -> 2016
* More information: `https://en.wikipedia.org/wiki/Singularity_(software) <https://en.wikipedia.org/wiki/Singularity_(software)>`__

Singularity architecture
---------------------------

.. image:: images/singularity_architecture.png
  :width: 800


===================================================== =====================================================
Strengths                                             Weaknesses
===================================================== =====================================================
No dependency of a daemon                             At the time of writing only good support in Linux
Can be run as a simple user                           Mac experimental. Desktop edition. Only running
Avoids permission headaches and hacks                 For some features you need root account (or sudo)
Image/container is a file (or directory)
More easily portable

Two types of images: Read-only (production)
Writable (development, via sandbox)

===================================================== =====================================================

**Trivia**

Nowadays, there may be some confusion since there are two projects:

* `Apptainer Singularity <https://github.com/apptainer/singularity>`__
* `Sylabs Singularity <https://sylabs.io/singularity/>`__

They "forked" in 2021. So far they share most of the codebase, but eventually this could be different, and software might have different functionality.

The former is already "End Of Life" and its development continues named as `Apptainer <http://apptainer.org/>`_, under the support of the Linux Foundation.

Container registries
--------------------

Container images, normally different versions of them, are stored in container repositories.

These repositories can be browser or discovered within, normally public, container registries.

Docker hub
**********

It is the first and most popular public container registry (which provides also private repositories).

* `Docker Hub <https://hub.docker.com>`__

Example:

`https://hub.docker.com/r/biocontainers/fastqc <https://hub.docker.com/r/biocontainers/fastqc>`__

.. code-block:: console

	singularity build fastqc-0.11.9_cv7.sif docker://biocontainers/fastqc:v0.11.9_cv7


Biocontainers
*************

* `Biocontainers <https://biocontainers.pro>`__

Website gathering Bioinformatics focused container images from different registries.

Originally Docker Hub was used, but now other registries are preferred.

Example: `https://biocontainers.pro/tools/fastqc <https://biocontainers.pro/tools/fastqc>`__

**Via quay.io**

`https://quay.io/repository/biocontainers/fastqc <https://quay.io/repository/biocontainers/fastqc>`__

.. code-block:: console

	singularity build fastqc-0.11.9.sif docker://quay.io/biocontainers/fastqc:0.11.9--0


**Via Galaxy project prebuilt images**

.. code-block:: console

	singularity pull --name fastqc-0.11.9.sif https://depot.galaxyproject.org/singularity/fastqc:0.11.9--0


Galaxy project provides all Bioinformatics software from the BioContainers initiative as Singularity prebuilt images. If download and conversion time of images is an issue, this might be the best option for those working in the biomedical field.

Link: https://depot.galaxyproject.org/singularity/

Running and executing containers
--------------------------------

Once we have some image files (or directories) ready, we can run processes.

Singularity shell
*****************

The straight-forward exploratory approach is equivalent to ``docker run -ti biocontainers/fastqc:v0.11.9_cv7 /bin/shell`` but with a more handy syntax.

.. code-block:: console

	singularity shell fastqc-0.11.9.sif


Move around the directories and notice how the isolation approach is different in comparison to Docker. You can access most of the host filesystem.

Singularity exec
****************

That is the most common way to execute Singularity (equivalent to ``docker exec``). That would be the normal approach in a HPC environment.

.. code-block:: console

    singularity exec fastqc-0.11.9.sif fastqc

a processing of a FASTQ file from *data* directory:

.. code-block:: console

    singularity exec fastqc-0.11.9_cv7.sif fastqc SRR6466185_1.fastq.gz


Singularity run
***************

This executes runscript from recipe definition (equivalent to ``docker run``). Not so common for HPC uses. More common for instances (servers).

.. code-block:: console

    singularity run fastqc-0.11.9.sif


Environment control
*******************

By default Singularity inherits a profile environment (e.g., PATH environment variable). This may be convenient in some circumstances, but it can also lead to unexpected problems when your own environment clashes with the default one from the image.

.. code-block:: console

    singularity shell -e fastqc-0.11.9.sif
    singularity exec -e fastqc-0.11.9.sif fastqc
    singularity run -e fastqc-0.11.9.sif


Compare ``env`` command with and without -e modifier.

.. code-block:: console

    singularity exec fastqc-0.11.9.sif env
    singularity exec -e fastqc-0.11.9.sif env

Exercise
********

Using the 2 fastq available files, process them outside and inside a mounted directory using fastqc.

.. raw:: html

   <details>
   <summary><a>Suggested solution</a></summary>


.. code-block:: console

	# Let's create a dummy directory
	mkdir data

	# Let's copy contents of data in that directory

	singularity exec fastqc.sif fastqc data/*fastq.gz

	# Check you have some HTMLs there. Remove them
	rm data/*html

	# Let's use shell
	singularity shell fastqc.sif
	> cd data
	> fastqc *fastq.gz
	> exit

	# Check you have some HTMLs there. Remove them
	singularity exec -B ./data:/scratch fastqc.sif fastqc /scratch/*fastq.gz

	# What happens here!
	singularity exec -B ./data:/scratch fastqc.sif bash -c 'fastqc /scratch/*fastq.gz'

.. raw:: html

  </details>

