#!/usr/bin/env nextflow

nextflow.enable.dsl=2

Channel
    .fromPath("{aa,bb,cc}.txt")
    .set {my_files}


my_files
    .collect()
    .map{
                ["my id", it[0], it[1] ]
}.view()
