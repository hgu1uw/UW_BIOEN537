from nanoSeq.nanoporeAlignment import nanoAlign
from nanoSeq.primer_design import primerdesign


nanoAlign.main('/Users/nello/PycharmProjects/pythonProject_nanopore/nanoSeq/test_/test_nanopore_alignment')
primerdesign.main('/Users/nello/PycharmProjects/pythonProject_nanopore/nanoSeq/test_/test_primer/reference_primer.fasta')

# The following code is used to setup the virtaul environment for package check locally
"""
 
 python setup.py sdist bdist_wheel
 python -m venv test_env
"""

