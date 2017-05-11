cwlVersion: v1.0
class: Workflow


hints:
  - class: synData
    input: index
    entity: syn8473371


inputs:

  index:
      type: File

  TUMOR_FASTQ_1:
      type: File

  TUMOR_FASTQ_2:
      type: File


outputs:

  OUTPUT:
    type: File
    outputSource: convert/outfile

steps:
  tar:
    run:
      requirements:
        - class: DockerRequirement
          dockerPull: combinelab/salmon
      class: CommandLineTool
      cwlVersion: v1.0
      baseCommand: [tar, xvzf]
      inputs:
        infile:
          type: File
          inputBinding:
            position: 1
      outputs:
        outfile:
          type: Directory
          outputBinding:
            glob: salmon_index
    in:
       infile: index
    out:
       - outfile
  salmon:
    run: salmon.cwl
    in:
      fastq1: TUMOR_FASTQ_1
      fastq2: TUMOR_FASTQ_2
      index: tar/outfile
    out:
      - outfile
  convert:
    in:
      infile: salmon/outfile
    out:
      - outfile
    run:
        cwlVersion: v1.0
        class: CommandLineTool
        requirements:
          - class: DockerRequirement
            dockerPull: combinelab/salmon
                         
        baseCommand: [ awk, "{print $1 \"\\t\" $4 }" ]

        stdout: output.txt

        inputs:
          infile:
            type: File
            inputBinding:
              position: 1

        outputs:
          outfile:
            type: File
            outputBinding:
              glob: output.txt

