#!/usr/bin/env python

from setuptools import setup


with open('requirements.txt') as f:
    required = f.read().splitlines()

setup(
    name='${library_name}',
    version='0.1.0',
    description='${library_description}',
    packages=['${library_name}'],
    install_requires=required
)
