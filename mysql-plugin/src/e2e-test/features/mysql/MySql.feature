#
# Copyright © 2022 Cask Data, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License"); you may not
# use this file except in compliance with the License. You may obtain a copy of
# the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations under
# the License.
#

@Mysql
Feature: Mysql - Verify Mysql source data transfer
  @MYSQL_SOURCE_TEST @MYSQL_SINK_TEST @Mysql_Required
  Scenario: To verify data is getting transferred from Mysql to Mysql successfully
    Given Open Datafusion Project to configure pipeline
    When Expand Plugin group in the LHS plugins list: "Source"
    When Select plugin: "MySQL" from the plugins list as: "Source"
    When Expand Plugin group in the LHS plugins list: "Sink"
    When Select plugin: "MySQL" from the plugins list as: "Sink"
    Then Connect plugins: "MySQL" and "MySQL2" to establish connection
    Then Navigate to the properties page of plugin: "MySQL"
    Then Select dropdown plugin property: "select-jdbcPluginName" with option value: "driver"
    Then Replace input plugin property: "host" with value: "host"
    Then Replace input plugin property: "port" with value: "port"
    Then Replace input plugin property: "user" with value: "username"
    Then Replace input plugin property: "password" with value: "password"
    Then Enter input plugin property: "referenceName" with value: "sourceRef"
    Then Replace input plugin property: "database" with value: "database"
    Then Enter textarea plugin property: "importQuery" with value: "selectQuery"
    Then Click on the Get Schema button
    Then Verify the Output Schema matches the Expected Schema: "outputSchema"
    Then Validate "MySQL" plugin properties
    Then Close the Plugin Properties page
    Then Navigate to the properties page of plugin: "MySQL2"
    Then Select dropdown plugin property: "select-jdbcPluginName" with option value: "driver"
    Then Replace input plugin property: "host" with value: "host"
    Then Replace input plugin property: "port" with value: "port"
    Then Replace input plugin property: "database" with value: "database"
    Then Replace input plugin property: "tableName" with value: "targetTable"
    Then Replace input plugin property: "user" with value: "username"
    Then Replace input plugin property: "password" with value: "password"
    Then Enter input plugin property: "referenceName" with value: "targetRef"
    Then Validate "MySQL2" plugin properties
    Then Close the Plugin Properties page
    Then Save the pipeline
    Then Preview and run the pipeline
    Then Verify the preview of pipeline is "success"
    Then Click on preview data for MySQL sink
    Then Verify preview output schema matches the outputSchema captured in properties
    Then Close the preview data
    Then Deploy the pipeline
    Then Run the Pipeline in Runtime
    Then Wait till pipeline is in running state
    Then Open and capture logs
    Then Verify the pipeline status is "Succeeded"
    Then Get count of no of records transferred to target MySQL Table
    Then Validate records transferred to target table is equal to number of records from source table
