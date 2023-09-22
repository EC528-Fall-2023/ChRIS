# ChRIS
---
## Table of Contents

1. [Vision and Goals of the Project](#1-vision-and-goals-of-the-project)
2. [Users of the Project](#2-userspersonas-of-the-project)
3. [Scope and Features of the Project](#3-scope-and-features-of-the-project)
4. [Solution Concept](#4-solution-concept)
   - [Global Architecture of the Project](#global-architecture-of-the-project)
   - [Observability Stack Components](#observability-stack-components)
   - [Deployment on the New England Research Cloud (NERC)](#deployment-on-the-new-england-research-cloud-nerc)
   - [Design Implications and Discussion](#design-implications-and-discussion)
5. [Minimum Acceptance Criteria](#5-minimum-acceptance-criteria)
6. [Release Planning](#6-release-planning)

---
## 1. Vision and Goals Of The Project

The ultimate vision of this project is to transform ChRIS, a container scheduler for complex medical analysis tasks, into a highly observable and data-driven medical analysis platform, while maintaining simplicity to end users. We plan to implement an Observability stack for monitoring metrics about the ChRIS system such as CPU utilization for system admins maintaining the system in real time, and metrics about the performance of individual ChRIS plugins for end users.
High-Level Goals for improving ChRIS include:

- Implement robust observability stack within ChRIS to collect critical performance data of the system and individual user plugins
- Configure observable instance of ChRIS with OpenShift
- Deploy ChRIS on the New England Research Cloud (NERC) with the observability stack and be able to run and monitor useful data
- Configuration of a highly robust and observable instance of ChRIS deployable with OpenShift , through the use of a Helm project


## 2. Users/Personas Of The Project
ChRIS observability tools will be used by healthcare system administrators and medical researchers / personnel to provide active statistics on the performance of tasks in the ChRIS container scheduling system. They will be used by expert users working for the Medical employment sector in order to track medical data workflows for the sake of improving and maintaining efficient functionality of the ChRIS system during its operation.
### System administrators
- Monitor performance metrics and maintain the system
- Track metrics such as CPU utilization and storage for maintaining the service in real-time
- Will have access to a user friendly interface with optional access to raw system logs

### Standard users
- Simple use-cases for non-expert users
- Be able to schedule their jobs more efficiently through an easy-to-use, interactive interface separate from the expert user interface
- (Stretch goal) Implement an automated alert system that is able to be parsed automatically for errors and error rates to inform system administrators to better understand system problems as they are happening and fix those problems in real time
- (Stretch goal) A user-friendly dashboard that gives a simple front-end display for Observability metrics to be used by non-expert users (i.e. researchers or medical personnel) in the ChRIS UI. Metrics for end users would be for monitoring and measuring the performance of their own plugins for better understanding of things like how much RAM or CPUs their task requires.


## 3. Scope and Features of the Project

ChRIS is already a functional container scheduler used for performing data analytics tasks for medical professions. However, the system currently does not have automated observability procedures tied to the ChRIS platform which can be used to view internal statistics and performance. Our scope will be not to improve the ChRIS system but to utilize ChRIS using Openshift and to provide easy to use observability tools using a software stack.
The scope consists of two parts: Implementation of ChRIS with scripts for boot with Openshift, and research and implementation of an easy to boot observability software stack


The primary objectives of the project include:
- Deploying ChRIS on the New England Research Cloud (NERC) to make ChRIS function using Kubernetes and OpenShift
- Enhancing ChRIS system’s observability functionalities
- Developing a simple compelling interface for system monitoring
- Collect and display resource usage of containers running on ChRIS
- Creating a centralized, automated alert system that will notify system administrators about the important changes and issues within ChRIS

## 4. Solution Concept

This section highlights technical details regarding the implementation of our observability system, as well as discussing implications that could arise as a result of our research and design choices.
### Global Architecture Of the Project
The foundation of our project will revolve around the deployment of ChRIS unto NERC, along with an observability stack which we will configure to ensure efficiency and robustness of deployment. Details of the architecture of the components in our proposed observability stack are highlighted in the subsection below.
### Observability Stack Components
Our observability stack will generally follow the LGTM observability stack paradigm, consisting of the following components

- #### Grafana
  A multi-platform open-source analytics and interactive visualization web application. It provides visualization of data into charts, graphs, and alerts for the web when connected to supported data sources.
- #### Prometheus
  Collects and stores its metrics as time series data, i.e. metrics information is stored with the timestamp at which it was recorded, alongside optional key-value pairs called labels which can be sent to Grafana for visualization.
- #### Loki
  Log aggregation system designed to store and query logs from all the deployed applications and infrastructure in ChRIS.
- #### Thanos
  query command (also known as “Querier”) that implements the Prometheus HTTP v1 API to query data in a Thanos cluster via PromQL. It gathers the data needed to evaluate the query from underlying StoreAPIs, evaluates the query, and returns the result to Grafana for visualization. Thanos will allow us to efficiently store and transmit data.

Although using this observability stack setup is our foremost design choice, we will be researching using OpenSource as our observability stack and plan to compare the efficiency of its performance to that of the LGTM stack implementation.  

### Deployment on the New England Research Cloud (NERC)


  
### Design Implications and Discussion

- Generate more data regarding the interactions between ChRIS and its plug-ins, and the Kubernetes environment (i.e. how the apps consume resources on this platform, possible bugs/optimizations, etc)
- Promoting integration between high-level computing and the fields of healthcare and medical research
- Increasing accessibility of complex applications to end users on various cloud platforms (i.e. with ChRIS deployed on NERC, accessing complex and efficient medical tools becomes more ubiquitous and accessible to potential end users such as small clinics or medical researchers)
- Generate more data comparing the efficiency of different observability stack implementations, especially as related to observing applications with similar container management features as ChRIS

## 5. Minimum Acceptance Criteria

### Minimum Goals
- A version of ChRIS which runs on NERC integrated with Kubernetes and Openshift
- The version of ChRIS should also have attached observability tools able to run using the new Kubernetes and Openshift applications
- Both the ChRIS system and the additional observability should be able to boot off of an easy to run script with easily accessible configuration options, thus automating the task of running ChRIS with observability on Openshift with Kubernetes
- A Helm project containing working configuration for deploying ChRIS on Kubernetes with an integrated observability stack
- A pull request to the Helm repository (https://github.com/FNNDSC/charts)

### Stretch Goals
- Implement an automated alert system that notification system admins of system anomalies
- Explore other observability options and possible optimizations, such as OpenObserve etc.
- Create a user-friendly frontend on top of observability stack
- Create an automated testing suite for analyzing performance of the observability stack itself


## 6. Release Planning
### Release #1 (due by Week 5):
- Deploy backend for ChRIS on New England Research Cloud (NERC) and enable end-users to access ChRIS via NERC
### Release #2 (due by Week 7):
- Deploy observability on NERC and connect to ChRIS and enable system admins to collect logs generated from running containers
### Release #3 (due by Week 9):
- Implement a Dashboard in Observability that is useful to system admins and contain information about running containers
### Release #4 (due by Week 11):
- Work on finalizing version and submitting an official pull request to the ChRIS-helm project (https://github.com/FNNDSC/charts)
### Release #5 (due by Week 13):
- Work on stretch goals, including automated alert systems, friendly front end on top of observability stack, and/or automated function testing for existing dashboards




