# Exporting data
To backup the data from a running installation.

## Get the bucket ID
You can get it from the InfluxDB web interface (http://influx.<hostname>) in load-data/buckets.
Or from the CLI : 
```
$ docker exec influxdb influx bucket ls
ID			Name		Retention	Shard group duration	Organization ID		Schema Type
86837325fb605d64	DHBW		infinite	168h0m0s		b1050fa410f1393d	implicit
d2f35e9702dc5f56	_monitoring	168h0m0s	24h0m0s			b1050fa410f1393d	implicit
cea2d713f7d6a422	_tasks		72h0m0s		24h0m0s			b1050fa410f1393d	implicit
```

In that case the bucket ID is 86837325fb605d64.

## Start the export
Move to the path where you want to do the export.

Run the influxd export to lp (line protocol) : 
```
docker exec influxdb influxd inspect export-lp \
  --bucket-id 86837325fb605d64 \
  --engine-path /var/lib/influxdb2/engine \
  --output-path - \
  --compress > backup.lp.gz
```
Making sure to replace the bucket-id and output file with the appropriate values.

You now have a backup, download it with scp or sftp and see [Migrating for previous installation](/README.md#migrating-from-previous-installation) for how to use it.
