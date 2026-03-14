from setuptools import find_packages, setup

package_name = 'tennisrobot'

setup(
    name=package_name,
    version='0.0.0',
    packages=find_packages(exclude=['test']),
    data_files=[
        ('share/ament_index/resource_index/packages',
            ['resource/' + package_name]),
        ('share/' + package_name, ['package.xml']),
    ],
    install_requires=['setuptools'],
    zip_safe=True,
    maintainer='valery&nicolas',
    maintainer_email='valery.piot@outlook.com',
    description='Robot selfdriven: Package description',
    license='MIT: License for the project',
    extras_require={
        'test': [
            'pytest',
        ],
    },
    entry_points={
        'console_scripts': [
            'drive = tennisrobot.navigation.drive_node:main',
        ],
    },
)
