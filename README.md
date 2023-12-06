# ![logo](./logo_chris.png) ChRIS


**Project Title: Observability in Cloud Processing with ChRIS**

**Project Members:**

*Timothy Borunov*

*Trevor Chan*

*Juehao Lin*

*Jakub J. Zolkos*

*Kwadwo Osafo*

## Demos
1. https://drive.google.com/file/d/1Axx8GrT3clQa5lssAnyzJHwH4feowfGC/view?usp=sharing
2. https://drive.google.com/file/d/1aYLyDDNu-SmBYTxwsuIl-jK45QH2584X/view?usp=sharing
3. https://drive.google.com/file/d/1z8EK8kX2ZMsnE-lOJcVe7RWCCgw8Tx6f/view?usp=share_link
4. https://drive.google.com/file/d/1OkuV4mA_2Lg1DOVdBiHQvjaF_nx1uTKo/view?usp=sharing
5. https://drive.google.com/file/d/1fSR-LywV1zZ0LXFZySAKkt9onQjbMQuZ/view?usp=sharing

## Slides
1. https://docs.google.com/presentation/d/1uQZDqBO68dm8y8CGtNuRPLEEiHiHIV6-TL68J6gDX1s/edit?usp=sharing
2. https://docs.google.com/presentation/d/104KnspHmhHB2cOUBCFunhCvKucEYojla4FEDy1epa-Q/edit?usp=sharing
3. https://docs.google.com/presentation/d/1yVFH7lIDybriKgPqWTtAD3MTj43_xSnPQzxWOS_pQPo/edit?usp=sharing
4. https://docs.google.com/presentation/d/1BI1rD-tRcoJzUx-eaui4UmoLWg_6-UTABwnEXXe-Dco/edit?usp=sharing
5. https://docs.google.com/presentation/d/1xKnhJAh5pmwp5lByy6W7FPNQM-zQxIx04AkgTJPpVnY/edit?usp=sharing

## Table of Contents

1. [Vision and Goals of the Project](#1-vision-and-goals-of-the-project)
2. [Users of the Project](#2-userspersonas-of-the-project)
3. [Scope and Features of the Project](#3-scope-and-features-of-the-project)
4. [Solution Concept](#4-solution-concept)
   - [Global Architecture of the Project](#global-architecture-of-the-project)
   - [Development of Observability Stack](#development-of-observability-stack)
   - [Deployment on the New England Research Cloud (NERC)](#deployment-on-the-new-england-research-cloud-nerc)
   - [Design Implications and Discussion](#design-implications-and-discussion)
5. [Minimum Acceptance Criteria](#5-minimum-acceptance-criteria)
6. [Release Planning](#6-release-planning)

---

## 1. Vision and Goals Of The Project

The ultimate vision of this project is to transform ChRIS, a container scheduler for complex medical analysis tasks, into a highly observable and data-driven medical analysis platform, while maintaining simplicity for end users. We plan to implement an observability stack for monitoring metrics about the ChRIS system such as CPU utilization for system admins maintaining the system in real-time, as well as metrics about the performance of individual ChRIS plugins. We are also planning on implementing visualizations for traces of the ChRIS system to track the source of a current issue ChRIS has with overhead delays. We will also test deploying ChRIS to the New England Research Cloud (NERC) with the observability stack.

High-Level Goals for improving ChRIS include:



* Implement robust observability stack for ChRIS to collect critical performance data of the system and individual plugins
* Provide a simple, understandable interface for visualizing and monitoring the observability data (e.g. Grafana dashboard) both for expert users such as system administrators and for non-expert medical researchers
* Configure observable instances of ChRIS with OpenShift and Helm
* Deploy ChRIS on the New England Research Cloud (NERC) with the observability stack and be able to run ChRIS plug-ins and obtain meaningful observability data

Below are definitions of some terms that will be frequently encountered in this README file:
* Plugin:
Container image used for running computational workflows
* Instrumentation:
Setting up a system such that its components emit meaningful traces, metrics and logs

## 2. End Users Of The Project

ChRIS observability tools will be used by healthcare system administrators and medical researchers/personnel to provide active statistics on the performance of ChRIS’s backend and individual tasks in the ChRIS container scheduling system. They will mainly be used by expert users for the sake of improving and maintaining the efficient functionality of the ChRIS system during its operation. However, it will also be available for the Medical employment sector in order to track the performance of their ChRIS plugins running medical data workflows.

##### System administrators (Primary users):



* Monitor performance metrics and maintain the system
* Track metrics such as CPU utilization and storage for finding any system errors and maintaining the service in real-time
* Will have access to a user-friendly interface (e.g. Grafana dashboard) with optional access to raw system logs

##### Non system admin users (Secondary users):



* Simple use-cases for non-expert users (e.g. medical researchers or personnel) to easily monitor the performance of their individual plugins
* Assumes that users have experience using the ChRIS UI to be able to effectively use/understand the monitoring data
* Be able to schedule their jobs more efficiently through an easy-to-use, interactive interface separate from the expert user interface

## 3. Scope and Features Of The Project

ChRIS is already a functional container scheduler used for performing data analytics tasks for medical professionals. However, the system currently does not have automated observability procedures tied to the ChRIS platform which can be used to view internal statistics and performance. Our scope will be not to improve the ChRIS system, but to utilize ChRIS using Openshift and to provide easy-to-use observability tools using a software stack.

The scope consists of two parts: Implementation of ChRIS with scripts for boot with Openshift, and research and implementation of an easy-to-boot observability software stack with a user interface. 

The primary scope of the project will consist of the following:



* Research observability stack alternatives to LGTM model and select optimal software for integration with ChRIS
    * Deploy backend for ChRIS container logging
    * Collect essential information about running container
* Implement observability architecture for a system administrator or researcher
    * Automatically collect and query generated log from containers
    * Visualize collected data on the administrator’s interface
* Learn how to utilize Openshift on the New England Research Cloud (NERC) and use that implementation with ChRIS
    * Deploy ChRIS on the NERC using OpenShift
    * Create a Helm project for deploying ChRIS and the observability stack on OpenShift
* Create an easily readable interface for end users (separate from administrator’s interface)
    * Implement a user-friendly dashboard UI
* Test and develop new observability methods and tools for usage with ChRIS
    * Explore possible optimization for logging and log storage
    * Explore the possibility of implementing an automatic alert system for system administrators

## 4. Solution Concept

### Global Architecture of the Project

The foundation of our project will revolve around the deployment of ChRIS in the New England Research Cloud (NERC), along with an observability stack which we will configure to ensure efficiency and robustness of deployment. Additionally, we aim to develop a robust configuration for ChRIS along with an efficient observability stack on OpenShift through the NERC, and we plan to deliver that through the Helm framework. Finally, we also seek to improve the observability capabilities of our deployed observability stack by using the data it collects to develop new modules or features, either in the observability stack or in the ChRIS application itself. Details of the architecture of the various components in our proposed system are highlighted in the subsections below.

### Development of Observability Stack:

Our observability stack will adopt the observability stack paradigm for collecting and monitoring metrics including CPU and memory usage, resource allocation patterns, and temporal distribution of medical analysis programs for system management purposes. Metrics will be collected and visualized in a dashboard for easy access and monitoring by system admins. It will consist of the following components providing functionality for log collection, visualization, traces and metrics:

- ##### Loki: Loki is a log aggregation system designed to store and query logs from all the deployed applications and infrastructure in ChRIS.

- ##### Grafana: Grafana is a multi-platform open-source analytics and interactive visualization web application. It provides easy visualization of data into charts, graphs, and alerts for the web when connected to supported data sources.

- #### Tempo: Tempo is a high-volume tracing backend which efficiently implements distributed tracing on a large scale without the need for specialized clusters. Tempo also allows for efficient capture and storage of individual, exact traces.

- #### OpenTelemetry: OpenTelemetry provides a single, open-source standard for instrumenting, generating, collecting and exporting telemetry data (logs, metrics, traces). OpenShift on NERC has pre-installed OpenTelemetry auto-instrumentation and collection operators, which can be connected to other tools in our deployed observability stack, such as Prometheus and Tempo, for further processing.

- ##### Prometheus: Prometheus collects and stores its metrics as time series data, i.e. metrics information is stored with the timestamp at which it was recorded, alongside optional key-value pairs called labels which can be sent to Grafana for visualization.

Although using this observability stack setup is our foremost design choice, we will be researching using OpenSource as our observability stack and plan to compare the efficiency of its performance to that of the LGTM stack implementation and choose the option with the best performance.

### Generating Visualizations of Observability Data (Metrics, Logs, Traces):

Our Observability stack features Grafana, the data visualization platform that is able to connect to the previously mentioned components such as Loki and Prometheus. As a part of our project, we will be ingesting the metrics, logs, and traces and creating meaningful visualizations and alerting that is able to perform the following:
* Visualize system performance metrics for system admins, and alert upon system exceeding a certain threshold
* Visualize / monitor for recent plugin failures, and alert users upon plugin failure
* Visualize plugin performance metrics for system admins, and alert if plugin is failing or stuck

### Deployment to the New England Research Cloud (NERC)

A big part of the project will also be testing and automating the deployment of ChRIS with the observability stack on the NERC. The model that we will be following is shown in **Figure 1**.

- ##### OpenShift: OpenShift is the RedHat container scheduler powered by Kubernetes that the New England Research Cloud uses for developing and deploying applications. We will be using OpenShift for deploying ChRIS onto the NERC so that we can test that our observability stack is gathering, storing, and visualizing metrics correctly.

- ##### Helm: Helm is a software packaging manager that makes it easier to deploy applications to OpenShift clusters. We will be creating a Helm project for automating deploying ChRIS and the observability stack onto OpenShift for ease of deployment to the NERC.

OpenShift on NERC possesses two tools and operators that we will be directly using in our observability stack; an in-built Prometheus tool and the OpenTelemetry operator. The OpenShift Prometheus tool will allow us to scrape simpler metrics such as CPU and memory usage which can then be exported to our deployed Grafana tool for display to our users. However, it does not collect more detailed metrics or HTTP requests, hence we plan to deploy our own instance of Prometheus which will allow us to do this. We will also use OpenTelemetry auto-instrumentation and collector tools to allow us to collect and aggregate all telemetry data (i.e. logs, metrics, traces), which can then be exported to the other tools on our observability stack.


![alt_text](./newdiag.JPG "Figure 1: Diagram of What Observability Stack Will Look Like in the NERC")


**Figure 1: Diagram of What Observability Stack Will Look Like in the NERC**

<img width="822" alt="Screen Shot 2023-10-23 at 3 08 41 PM" src="https://github.com/EC528-Fall-2023/ChRIS/assets/98369076/621594db-4ca9-44f7-a5a5-fcfd6fadd3b7">

**Figure 2: Visualizing Meaningful Data Collected from OpenShift's Built-in Observability**

### Design Implications and Discussion:



* Generate more data regarding the interactions between ChRIS and its plug-ins, and the Kubernetes environment (i.e. how the apps consume resources on this platform, possible bugs/optimizations, etc.)
* Promoting integration between high-level computing and the fields of healthcare and medical research
* Increasing accessibility of complex applications to end users on various cloud platforms (i.e. with ChRIS deployed on NERC, accessing complex and efficient medical tools becomes more ubiquitous and accessible to potential end users such as small clinics or medical researchers)
* Allow for easily understandable visualization of ChRIS system metrics for monitoring and system administration purposes
* Generate more data comparing the efficiency of different observability stack implementations, especially as related to observing applications with similar container management features as ChRIS

## 5. Acceptance Criteria

The minimum viable product is:

* A version of ChRIS which runs on NERC integrated with Openshift
* The version of ChRIS should also have attached observability tools able to run using the new Openshift applications
* Implement an automated alert systems that notifies system admins of anomalies and breaks in the system (but not for every plugin failure)
* Gather traces for debugging ChRIS's existing problem with overhead delays
* Helm project containing configuration for deploying ChRIS on Kubernetes with observability

Stretch goals are:



* Explore other observability options and possible optimizations, such as OpenObserve, ELK observability stack, etc.
* Create a user-friendly frontend on top of the observability stack
* Create an automated testing suite for analyzing the performance of the observability stack itself

## 6. Release Planning

### Release #1 (Sep 27 - Oct 11):

* Deploy backend and frontend for ChRIS on New England Research Cloud (NERC)
* Research each required part of observability stack for our project as well as topics in Openshift and ChRIS code

### Release #2 (Oct 11 - Oct 25):

* Deploy remaining parts of ChRIS (pfcon and pman) and test that plugins run successfully
* Start deploying Observability stack
   * Deploy Grafana and Prometheus on NERC, allowing collection of metrics on Openshift containers
   * Research into tracing tools and begin implementation
   * Deploy Open Telemetry core and collector (auto-instrumentation is not yet implemented)
* Split team to focus on metrics and logs, and traces separately

### Release #3 (Oct 26 - Nov 8):

* Deploy the rest of the Observability stack including Loki and Tempo
* Connect observability stack to gather metrics and logs

* Define what it looks like when a plugin fails (in metrics and logs) and set up alerting system for failing plugins
* Define what metrics are meaningful to observe and set up visualizations on Grafana for them

* Define which parts of ChRIS to implement traces to
* Start deploying traces (looking into auto-instrumentation vs. manually implementing tracing in ChRIS source code)

### Release #4 (Nov 8 - Nov 22):

**Finishing With MVP**
* Deploy the rest of Loki and connect with Grafana
* Start visualizing the traces provided by Tempo and OpenTelemetry

* Finalize panels and alerts for monitoring system performance
* Finalize panels and alerts for monitoring for plugin failures

**Reach Goals**
* Start deploying custom traces in the ChRIS source code (reach goal)

### Release #5 (Nov 22 - Dec 8):

* Finish components of MVP that are not finished
   * Alternatively, work on reach goals if finished with MVP
* Write documentation on what we've done, including what panels are being used, what they're monitoring, and their settings 

