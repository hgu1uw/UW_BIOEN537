from setuptools import setup, find_packages

setup(
    name='nanopore_alignment',
    version='0.1',
    packages=find_packages(),
    description='A Python package for nanopore sequence alignment and primer design',
    author='Nello',
    author_email='hgu1@uw.edu',
    url='https://github.com/hgu1uw/UW_BIOEN537.git',
    classifiers=[
        'Development Status :: 3 - Alpha',
        'Intended Audience :: Science/Research',
        'Topic :: Scientific/Engineering :: Bio-Informatics',
        'License :: OSI Approved :: MIT License',
        'Programming Language :: Python :: 3',
        'Programming Language :: Python :: 3.7',
        'Programming Language :: Python :: 3.8',
        'Programming Language :: Python :: 3.9',
    ],
    keywords='nanopore sequencing, primer design, bioinformatics',
)
