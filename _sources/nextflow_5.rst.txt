.. _nextflow_5-page:

*******************
Nextflow 5
*******************



Running nextflow on the CRG HPC
==================================
For running on the CRG HPC you can use the `executor SGE <https://www.nextflow.io/docs/latest/executor.html#sge>`__

The HPC has several tools already installed that can be "loaded" as modules, for instance you might want to load **singularity version 3.7.0** for being used with your pipelines.

For doing so you can add this string of code to your **.bashrc**, that is a file that is run every time you log to a remote computer in the HPC or you submit a job:

.. code-block:: console

  vim $HOME/.bashrc

Then add this at the end

.. code-block:: console

  #EasyBuild
  module use /software/as/el7.2/EasyBuild/CRG/modules/all
  module load Singularity/3.7.0

 
