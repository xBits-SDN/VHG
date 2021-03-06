base:
  '*':
   - hostsfile
   - monitoring
    
  'roles:broker':
    - match: grain
    - core.broker
    
  'roles:swift_proxy':
    - match: grain
    - require:
      -  sls: storage
    - storage
    - storage/proxy
    
  'roles:swift_object':
    - match: grain
    ####
    - require:
      - sls: storage
    - watch:
      - sls: storage/nodes
    ####
    - storage
#    - storage/nodes  #move to orch.sls

  'roles:core':
    - match: grain
    - core
    - docker
    
  'roles:worker':
    - match: grain
#    - core.worker
#    - worker#move to orch.sls

  'roles:admission':
    - match: grain
#    - core.admission #move to orch.sls

  'roles:frontend':
    - match: grain
#    - core.frontend #move to orch.sls

  'roles:vhg':
    - match: grain
    - core.vhg

  'roles:controller':
    - match: grain
    - core.workermonitoring
#    - core.admissionmonitoring
    - worker.manager
