from setuptools import find_packages, setup

setup(
    name="my_bashtools",
    version="0.1",
    packages=find_packages(),
    entry_points={"console_scripts": ["tools=my_bashtools.cli:main"]},
    install_requires=[
        # list your dependencies here
    ],
    author="Carlo Emilio MONTANARI",
    author_email="carlo.emilio.montanari@cern.ch",
    description="A collection of useful bash tools",
    license="MIT",
    keywords="bash tools",
    url="https://github.com/carlidel/my_bashtools",
    include_package_data=True,
)
