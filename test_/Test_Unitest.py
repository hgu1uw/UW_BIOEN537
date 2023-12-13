import unittest
from nanoSeq.nanoporeAlignment import nanoAlign
from nanoSeq.primer_design import primerdesign
import os

class TestNanoSeq(unittest.TestCase):

    def test_nanoAlign_main(self):
        # Call the function you want to test
        nanoAlign.main(
            '/Users/nello/PycharmProjects/pythonProject_nanopore/nanoSeq/test_/test_nanopore_alignment_simplified')

        # Define the default output directory
        default_output = '/Users/nello/PycharmProjects/pythonProject_nanopore/output/wf-tb-amr-report.html'

        # Check that the expected output files have been created
        self.assertTrue(os.path.exists(os.path.join(default_output)))

    def test_primerdesign_read_fasta(self):
        # Call the function you want to test
        result = primerdesign.read_fasta('/Users/nello/PycharmProjects/pythonProject_nanopore/nanoSeq/test_/test_primer/reference_primer.fasta')

        # Use an assert method to verify the result
        # This is just a placeholder, replace it with the actual condition you want to check
        self.assertIsInstance(result, str)

    def test_primerdesign_get_complementary_sequence(self):
        # Call the function you want to test
        sequence = primerdesign.read_fasta('/Users/nello/PycharmProjects/pythonProject_nanopore/nanoSeq/test_/test_primer/reference_primer.fasta')
        result = primerdesign.get_complementary_sequence(sequence)

        # Use an assert method to verify the result
        # This is just a placeholder, replace it with the actual condition you want to check
        self.assertIsInstance(result, str)

    def test_primerdesign_design_primers(self):
        # Call the function you want to test
        sequence = primerdesign.read_fasta('/Users/nello/PycharmProjects/pythonProject_nanopore/nanoSeq/test_/test_primer/reference_primer.fasta')
        result = primerdesign.design_primers(sequence)

        # Use an assert method to verify the result
        # This is just a placeholder, replace it with the actual condition you want to check
        self.assertIsInstance(result, list)

    def test_primerdesign_check_dimerization(self):
        # Call the function you want to test
        sequence = primerdesign.read_fasta('/Users/nello/PycharmProjects/pythonProject_nanopore/nanoSeq/test_/test_primer/reference_primer.fasta')
        primers = primerdesign.design_primers(sequence)
        result = primerdesign.check_dimerization(primers[0], primers[1])

        # Use an assert method to verify the result
        # This is just a placeholder, replace it with the actual condition you want to check
        self.assertIsInstance(result, bool)

    def test_primerdesign_main(self):
        # Call the function you want to test
        primerdesign.main(
            '/Users/nello/PycharmProjects/pythonProject_nanopore/nanoSeq/test_/test_primer/reference_primer.fasta')

        # Check that the expected output files have been created
        self.assertTrue(os.path.exists(
            '/Users/nello/PycharmProjects/pythonProject_nanopore/nanoSeq/test_/test_primer/highlighted_sequence1.fasta'))
        self.assertTrue(os.path.exists(
            '/Users/nello/PycharmProjects/pythonProject_nanopore/nanoSeq/test_/test_primer/highlighted_sequence2.fasta'))

# This allows the test to be run directly
if __name__ == '__main__':
    unittest.main()

# The following code is used to setup the virtaul environment for package check locally


# This command is used to generate distribution archives. You should be in the directory containing the setup.py file.
# The 'sdist' command creates a source distribution archive - a .tar.gz file.
# The 'bdist_wheel' command creates a built distribution - a .whl file.
# python setup.py sdist bdist_wheel

# This command creates a new virtual environment named 'test_env'.
# A virtual environment is an isolated Python environment where you can install packages without affecting your global Python installation.
# python -m venv test_env

# This command activates the virtual environment 'test_env'.
# After activation, any packages installed will be installed to this environment, and Python will use this environment's version and packages.
# source test_env/bin/activate


# This command lists all the installed packages in the current Python environment.
#pip list


# This command installs the package in the current Python environment.You should be in the directory containing the whl file - the <dist> directory.
# pip install nanoSeq-0.1-py3-none-any.whl