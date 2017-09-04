# Zenko Post-Processing Example Module

This is a development stack !

## Setup

Setup a minimum of two nodes in a docker swarm

```
$ docker-machine create default
$ docker-machine create s3server
```

Initialize docker swarm and add second node as a worker
###### From Default
```
$ docker swarm init --advertise-addr $(docker-machine ip default)
```

###### From s3server
Copy and run join command/token from previous command

Assign label for storage to persist on a single node  
Show nodes: *docker node ls*

```
$ docker node update --label-add io.zenko.type/storage <NODE_ID>
```

Verify label was applied to node

```
$ docker node inspect <NODE_ID> -f '{{ .Spec.Labels}}'
map[io.zenko.type:storage]
```

## Deploying the stack

```
$ docker stack deploy -c docker-stack.yml zenko-prod
```

### Initial Configuration

Run bash on the kafka container
```
$ docker exec -it <container_id> bash
```

Create the 'postproc' namespace and 'processing-populator' node

```
bin/zookeeper-shell.sh localhost:2181/postproc
create /processing-populator my_data
create /processing-populator logState
create /processing-populator/logState bucketFile_s3-recordlog
create /processing-populator/logState/bucketFile_s3-recordlog logOffset
quit
```

Create the post-processing topic
```
bin/kafka-topics.sh --create \
--zookeeper localhost:2181/postproc \
--replication-factor 1 \
--partitions 1 \
--topic post-processing
```
