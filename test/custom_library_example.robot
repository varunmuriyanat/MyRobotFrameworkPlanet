| *** Settings ***    |
| Documentation       | Test the employee Python script
| Library             | OperatingSystem
| Library             | library/employee_lib.py

| *** Variables ***   |
| ${APPLICATION}      | python3 ../employee.py
| ${APPLICATION_PATH} | ../employee.py

| *** Test Cases ***            |                 |
| Empty Employees List          | [Documentation] | Verify the output of an empty employees list
| | [Setup]                     | Clear Employees List | ${APPLICATION_PATH}
| | ${output} =                 | Retrieve Employees List
| | Should Be Equal             | ${output}       | []

| Add Employee                  | [Documentation] | Verify adding an employee
| | [Setup]                     | Clear Employees List | ${APPLICATION_PATH}
| | Add Employee                | first_name=John | last_name=Doe
| | ${output} =                 | Retrieve Employees List
| | Should Be Equal             | ${output}       | ['John Doe']
| | [Teardown]                  | Clear Employees List | ${APPLICATION_PATH}

| *** Keywords ***              |
| Retrieve Employees List       | [Documentation] | Return the list of employees
| | ${rc}                       | ${output} =     | Run and Return RC and Output | ${APPLICATION} list_employees
| | Should Be Equal As Integers | ${rc}           | 0
| | [Return]                    | ${output}

| Add Employee                  | [Documentation] | Add an employee to the list of employees
|                               | [Arguments]     | ${first_name}
|                               | ...             | ${last_name}
| | ${rc}                       | ${output} =     | Run and Return RC and Output | ${APPLICATION} add_employee ${first_name} ${last_name}
| | Should Be Equal As Integers | ${rc}           | 0