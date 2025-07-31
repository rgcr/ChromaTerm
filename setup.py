import os
import codecs
from setuptools import find_packages, setup

here = os.path.abspath(os.path.dirname(__file__))
readme = None

requirements = ["psutil", "PyYAML>=5.1"]

test_requirements = []

with open("README.md", "r", encoding="utf-8") as f:
    readme = f.read()

about = dict()
with codecs.open(os.path.join(here, "chromaterm", "__version__.py"), "r", "utf-8") as f:
    exec(f.read(), about)

setup(
    name="chromaterm2",
    url="https://github.com/rgcr/ChromaTerm2",
    license="MIT",
    description="Color your Terminal with Regex! (Maintained fork of ChromaTerm)",
    version=about["__version__"],

    author=about["__author__"],
    author_email=about["__email__"],

    entry_points={"console_scripts": ["ct = chromaterm.cli:main"]},

    install_requires=requirements,
    setup_requires=requirements,
    tests_require=test_requirements,

    long_description=readme + "\n\n",
    long_description_content_type="text/markdown",
    packages=find_packages(),

    python_requires=">=3.9.0",
    classifiers=[
        "Intended Audience :: Information Technology",
        "Intended Audience :: System Administrators",
        "Intended Audience :: Telecommunications Industry",
        "License :: OSI Approved :: MIT License",
        "Programming Language :: Python :: 3",
        "Topic :: Terminals",
        "Topic :: Utilities",
    ],
)
