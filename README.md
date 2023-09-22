# ChRIS
---
## Table of Contents

- [Vision and Goals of the Project](#1-vision-and-goals-of-the-project)
- [Users/Personas of the Project](#2-userspersonas-of-the-project)
- [Scope and Features of the Project](#3-scope-and-features-of-the-project)
- [Solution Concept](#4-solution-concept)
- [Minimum Acceptance Criteria](#5-minimum-acceptance-criteria)
- [Release Planning](#6-release-planning)



---
## 1. Vision and Goals Of The Project

The ultimate vision of this project is to transform ChRIS, a container scheduler for complex medical analysis tasks, into a highly observable and data-driven medical analysis platform, while maintaining simplicity to the end user. We plan to implement an Observability stack 
High-Level Goals for improving ChRIS include:
- Providing a simple, non-complex user experience for (system administrators) non-expert users (Medical personnel), including a straightforward user-end alert system. (No longer needed)
- Implement robust observability solutions using the platform of Grafana within ChRIS to enable the collection of critical performance data, including CPU and memory usage, resource allocation patterns, and temporal distribution of medical analysis programs for system management purposes.
- Implement an automated alert system that is able to be parsed automatically for errors and error rates to inform system administrators to better understand problems as they are happening.
- A user-friendly dashboard UI that gives good observability on the whole ChRIS system for non-expert users
- Configuration of a highly robust and observable instance of ChRIS deployable with Kubernetes, through the use of a Helm project

## 2. Users/Personas of the Project
ChRIS observability tools will be used by Healthcare Professionals and Medical Researchers to bring advanced computational tools into their diagnosis process. The first primary users are targeted to be the aforementioned type of personnel from Boston Children's Hospital, who should be able to schedule their jobs efficiently through a convenient, interactive interface. ChRIS will also be managed by system administrators to maintain the ChRIS system functionality through monitoring various metrics such as CPU utlization and storage for maintaining the service in real-time.

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
### Global Architectural Structure Of the Project
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
  Query command (also known as “Querier”) that implements the Prometheus HTTP v1 API to query data in a Thanos cluster via PromQL.It gathers the data needed to evaluate the query from underlying StoreAPIs, evaluates the query, and returns the result to Grafana for visualization.
  
### Design Implications and Discussion
Note: I am not sure if using points is the best method of communication here, feel free to change this section to paragraphs
Generate more data regarding the interactions between ChRIS and its plug-ins, and the Kubernetes environment (i.e. how the apps consume resources on this platform, possible bugs/optimizations, etc)
Promoting integration between high-level computing and the fields of healthcare and medical research
Increasing accessibility of complex applications to end users on various cloud platforms (i.e. with ChRIS deployed on NERC, accessing complex and efficient medical tools becomes more ubiquitous and accessible to potential end users such as small clinics or medical researchers)
Generate more data comparing the efficiency of different observability stack implementations, especially as related to observing applications with similar container management features as ChRIS

## 5. Minimum Acceptance Criteria

- A version of ChRIS which runs on NERC integrated with Kubernetes and Openshift
- The version of ChRIS should also have attached observability tools able to run using the new Kubernetes and Openshift applications
- Both the ChRIS system and the additional observability should be able to boot off of an easy to run script with easily accessible configuration options, thus automating the task of running ChRIS with observability on Openshift with Kubernetes
- A Helm project containing working configuration for deploying ChRIS on Kubernetes with an integrated observability stack

## 6. Release Planning

### Release #1 (due by Week 5):

- Deploy backend for ChRIS on New England Research Cloud

### Release #2 (due by Week 7):

- Deploy Observability on NERC and connect it to ChRIS

### Release #3 (due by Week 9):

- Create the first prototype dashboards for expert and non-expert users

### Release #4 (due by Week 11):

- Implement a Dashboard in Observability that is useful to system admins and contains information about running containers

### Release #5 (due by Week 13):

- Implement an automated alert system that notifies system admins if the error rate/resource request of a container is higher than baseline


