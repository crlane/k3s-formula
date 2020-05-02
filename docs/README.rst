.. _readme:

k3s-formula
================

|img_travis| |img_sr|

.. |img_travis| image:: https://travis-ci.com/saltstack-formulas/k3s-formula.svg?branch=master
   :alt: Travis CI Build Status
   :scale: 100%
   :target: https://travis-ci.com/saltstack-formulas/k3s-formula
.. |img_sr| image:: https://img.shields.io/badge/%20%20%F0%9F%93%A6%F0%9F%9A%80-semantic--release-e10079.svg
   :alt: Semantic Release
   :scale: 100%
   :target: https://github.com/semantic-release/semantic-release

A SaltStack formula that is empty. It has dummy content to help with a quick
start on a new formula and it serves as a style guide.

.. contents:: **Table of Contents**

General notes
-------------

See the full `SaltStack Formulas installation and usage instructions
<https://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html>`_.

If you are interested in writing or contributing to formulas, please pay attention to the `Writing Formula Section
<https://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html#writing-formulas>`_.

If you want to use this formula, please pay attention to the ``FORMULA`` file and/or ``git tag``,
which contains the currently released version. This formula is versioned according to `Semantic Versioning <http://semver.org/>`_.

See `Formula Versioning Section <https://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html#versioning>`_ for more details.

If you need (non-default) configuration, please pay attention to the ``pillar.example`` file and/or `Special notes`_ section.

Contributing to this repo
-------------------------

**Commit message formatting is significant!!**

Please see `How to contribute <https://github.com/saltstack-formulas/.github/blob/master/CONTRIBUTING.rst>`_ for more details.

Special notes
-------------

.. <REMOVEME

Using this template
^^^^^^^^^^^^^^^^^^^

The easiest way to use this template formula as a base for a new formula is to use GitHub's **Use this template** button to create a new repository. For consistency with the rest of the formula ecosystem, name your formula repository following the pattern ``<formula theme>-formula``, where ``<formula theme>`` consists of lower-case alphabetic characters and numbers.

In the rest of this example we'll use ``example`` as the ``<formula theme>``.

Follow these steps to complete the conversion from ``template-formula`` to ``example-formula``. ::

  $ git clone git@github.com:YOUR-USERNAME/example-formula.git
  $ cd example-formula/
  $ bin/convert-formula.sh example
  $ git push --force

Alternatively, it's possible to clone ``template-formula`` into a new repository and perform the conversion there. For example::

  $ git clone https://github.com/saltstack-formulas/template-formula example-formula
  $ cd example-formula/
  $ bin/convert-formula.sh example

To take advantage of `semantic-release <https://github.com/semantic-release/semantic-release>`_ for automated changelog generation and release tagging, you will need a GitHub `Personal Access Token <https://help.github.com/en/github/authenticating-to-github/creating-a-personal-access-token-for-the-command-line>`_ with at least the **public_repo** scope.

In the Travis repository settings for your new repository, create an `environment variable <https://docs.travis-ci.com/user/environment-variables/#defining-variables-in-repository-settings>`_ named ``GH_TOKEN`` with the personal access token as value, restricted to the ``master`` branch for security.

.. REMOVEME>

Available states
----------------

.. contents::
   :local:

``k3s``
^^^^^^^^^^^^

*Meta-state (This is a state that includes other states)*.

This installs the k3s package,
manages the k3s configuration file and then
starts the associated k3s service.

``k3s.package``
^^^^^^^^^^^^^^^^^^^^

This state will install the k3s package only.

``k3s.service``
^^^^^^^^^^^^^^^^^^^^

This state will start the k3s service and has a dependency on ``k3s.config``
via include list.

``k3s.clean``
^^^^^^^^^^^^^^^^^^

*Meta-state (This is a state that includes other states)*.

this state will undo everything performed in the ``k3s`` meta-state in reverse order, i.e.
stops the service,
removes the configuration file and
then uninstalls the package.

``k3s.service.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^^

This state will stop the k3s service and disable it at boot time.

``k3s.package.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^^

This state will remove the k3s package and has a depency on
``k3s.config.clean`` via include list.

Testing
-------

Linux testing is done with ``kitchen-salt``.

Requirements
^^^^^^^^^^^^

* Ruby
* Docker

.. code-block:: bash

   $ gem install bundler
   $ bundle install
   $ bin/kitchen test [platform]

Where ``[platform]`` is the platform name defined in ``kitchen.yml``,
e.g. ``debian-9-2019-2-py3``.

``bin/kitchen converge``
^^^^^^^^^^^^^^^^^^^^^^^^

Creates the docker instance and runs the ``k3s`` main state, ready for testing.

``bin/kitchen verify``
^^^^^^^^^^^^^^^^^^^^^^

Runs the ``inspec`` tests on the actual instance.

``bin/kitchen destroy``
^^^^^^^^^^^^^^^^^^^^^^^

Removes the docker instance.

``bin/kitchen test``
^^^^^^^^^^^^^^^^^^^^

Runs all of the stages above in one go: i.e. ``destroy`` + ``converge`` + ``verify`` + ``destroy``.

``bin/kitchen login``
^^^^^^^^^^^^^^^^^^^^^

Gives you SSH access to the instance for manual testing.
