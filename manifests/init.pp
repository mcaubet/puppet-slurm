# slurm/init.pp
#
# Installs SLURM with configuration according to node type.
#
# @param node_type Specifies the node type which defines the configuration that will be applied to that node.
#
# version 20170816
#
# Copyright (c) CERN, 2016-2017
# Authors: - Philippe Ganz <phganz@cern.ch>
#          - Carolina Lindqvist <calindqv@cern.ch>
#          - Pablo Llopis <pablo.llopis@cern.ch>
# License: GNU GPL v3 or later.
#

class slurm (
  Enum['worker','head','db','db-head','client','none'] $node_type,
) {

  case $node_type {
    'worker': {
      class{'::slurm::workernode':}
    }

    'head': {
      class{'::slurm::headnode':}
    }

    'db': {
      class{'::slurm::dbnode':}
    }

    'db-head': {
      class{'::slurm::headnode':}
      class{'::slurm::dbnode':}
    }

    'client': {
      class{'::slurm::client':}
    }

    'none': {
      notify{'The slurm module is included in your hostgroup but you did not provide any role in hiera. If it is intentional please do not consider this message.':}
    }

    default: {}
  }
}
