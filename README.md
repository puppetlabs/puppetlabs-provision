# Cloud Provisioner Module

This Puppet Module is designed for provisioning compute instances across various cloud providers, including **AWS**, **Azure**, and **GCP**. It incorporates Puppet Bolt plans to facilitate the creation, updating, or destruction of compute resources in these different cloud environments. The provided plans automate routine lifecycle activities, aiming to enhance operational speed and minimize the risk of human error associated with manual execution of these tasks.

The provisioning module is capable of deploying and managing compute resources across different architectures and instance types, ranging from Micro and Small to Standard, Large, and Extra Large configurations.

## Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with provision](#setup)
    * [What provision affects](#what-provision-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with provision](#beginning-with-provision)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Description

The module has been crafted and developed by the CAT (Modules) Team to simplify the process of provisioning and configuring new nodes within the existing PE architecture. It provides a fixed set of compute resource sizes, including Micro, Small, Standard, Large, and XLarge.

Through the `provision::create` Bolt plan user can provision new compute resources in supported Cloud providers. Conversely, using `provision::destroy` the user can destroy the existing provisioned compute resources.

Each Bolt plan requires cloud-independent parameters, as well as cloud-specific parameters, tailored to the cloud provider. Sensible default values are provided, where possible.

## Setup

### Setup Requirements

The provisioning module currently supports [Puppet Bolt](https://www.puppet.com/docs/bolt/latest/bolt.html) plans.
Below are more dependencies which will require to work with provisioning module : 
- **Puppet Bolt** - The orchestration tool to automate manual work.
- **Terraform** - The provisioning module uses HashiCorp Terraform (1.5.7) to interact with Cloud APIs. 

#### Configure AWS

Before start provisioning resources in AWS, will require to configure the API keys in environment variables. The module can work with both profile (`AWS_PROFILE`) as well as keys (`AWS_ACCESS_KEY_ID` & `AWS_SECRET_ACCESS_KEY`) by exporting respective values in environment variables.


### Beginning with provision

1. Clone this repository: `git clone https://github.com/puppetlabs/puppetlabs-provision.git && cd puppetlabs-provision`
2. Install module dependencies: `bolt module install --no-resolve`
3. Run plan to provision a node: `bolt plan run provision::create --params @params.json`. The `params.json` file should contain the parameters you pass to the plan.
4. Wait. This is best executed from a bastion host or alternatively, a fast connection with good bandwidth.

## Usage

# Common Parameter requirements

* `provider`: The default is `aws`. This parameter requires the name of the supported cloud provider for the module. The module currently supports AWS, Azure, and GCP clouds.
* `resource_name`: The default is 'provision'. This parameter represents the name of the resource that you intend to provision. Users have the flexibility to input any alphanumeric values for this parameter.
* `image`: This parameter specifies the name of the image from which the user intends to provision a resource.
* `region`: The default is cloud-specific. This parameter designates the name of the geographical region where the compute resource will be provisioned.
* `os_type`: Default is **linux**, this parameter is required to determine which version of the Puppet Agent to install, once the instance is provisioned.
* `provider_options`: This is a list of parameters specific to cloud providers. Please refer to respective cloud provider docs for detailed options - [AWS](/AWS_PARAMETERS.md), [Azure](/AZURE_PARAMETERS.md) & [GCP](/GCP_PARAMETERS.md). 

# PE-specific parameters

* `pe_server`: The hostname of PE server to install the agent and request the certificate from.
* `environment`: Default is **production**, the name of environment for the Puppet agent.

## Limitations

The provision module leverages [Terraform][https://github.com/hashicorp/terraform/tree/v1.5.7] as its underlying tool to interact with various cloud providers, facilitating the provisioning of compute resources. To manage the state effectively, this module incorporates the optional input parameter `resource_name` and saves the state in a file based on this parameter. It appends a timestamp to uniquely identify the state file, allowing users to execute further operations if necessary. When using the `provision::destroy` Bolt plan, it is essential for the user to provide the correct resource name to target and remove the desired resource.
