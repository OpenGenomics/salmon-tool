cwlVersion: v1.0
class: CommandLineTool

baseCommand: [salmon, quant, --libType, A, --output, salmon.out]

requirements:
    - class: DockerRequirement
      dockerPull: combinelab/salmon


inputs:
    fastq1:
      type: File
      inputBinding:
        prefix: "-1"
    fastq2:
      type: File
      inputBinding:
        prefix: "-2"
    index:
      type: Directory
      inputBinding:
        prefix: "-i"

outputs:
    outfile:
      type: File
      outputBinding:
        glob: salmon.out/quant.sf