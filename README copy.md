# Release Engine
 
## Overview
 
Release Engine is a collection of reusable Azure DevOps deployment pipelines and PowerShell scripts developed by The Cloud Explorers. The primary goal of this project is to simplify the implementation of CI/CD pipelines, encompassing both application code and infrastructure.

## Features
 
- Reusable Pipelines: Predefined Azure DevOps pipelines that can be easily integrated into your projects.
- Infrastructure as Code: Manage and deploy infrastructure alongside application code.
- PowerShell Scripts: Ready-to-use PowerShell scripts for common deployment tasks.
- Simplified CI/CD: Streamline the setup and management of continuous integration and continuous deployment processes.
- Customizable Workflows: Adapt the pipelines and scripts to fit your specific requirements..

## Creating New Patterns

To create a new pattern, follow these steps:

1. **Folder Structure**: Create a new folder under `release-engine-example-workload-pattern/patterns/` with the name of your new pattern.
   - Example: `release-engine-example-workload-pattern/patterns/<new_pattern_name>/`.

2. **Required Files**: Each pattern must include the following files:
   - `workload.bicep`: Defines the infrastructure and resources for the pattern.
   - `workload.yml`: Configures the pipeline and deployment settings.

3. **Creating `workload.bicep`**:
   - Use the provided template as a starting point and customize it for your workload.
   - **Important**: Always check if Azure Verified Modules (AVM) are available for the required resource. If AVM is not available, you may use the resource directly, but document the reason for not using AVM.

4. **Creating `workload.yml`**:
   - Use the provided template and update the parameters and variables for your pattern.

5. **Testing the Pattern**:
   - Validate the `workload.bicep` file using Azure Bicep tools.
   - Test the pipeline configuration in a development environment.

6. **Documentation**:
   - Document the purpose and usage of the pattern in a `README.md` file within the pattern folder.
   - Include details about required parameters, deployment steps, and any dependencies.
