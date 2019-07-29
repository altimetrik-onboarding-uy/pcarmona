<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Work_Item_Assignment_Notification</fullName>
        <description>Work Item Assignment Notification</description>
        <protected>false</protected>
        <recipients>
            <field>Assignee__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderAddress>pablorcarmona@hotmail.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Work_Item_Notification/Work_Item_Notification</template>
    </alerts>
    <fieldUpdates>
        <fullName>End_Date_Auto_Update</fullName>
        <description>When a work item gets to Done, the End Date is populated with the current date.</description>
        <field>End_Date__c</field>
        <formula>TODAY()</formula>
        <name>End Date Auto Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Start_Date_Auto_Update</fullName>
        <description>Whenever a work item goes from New to Ready, the Start Date is changed to the current Date</description>
        <field>Start_Date__c</field>
        <formula>TODAY()</formula>
        <name>Start Date Auto Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>End Date Auto Update</fullName>
        <actions>
            <name>End_Date_Auto_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Work_Item__c.Status__c</field>
            <operation>equals</operation>
            <value>Done</value>
        </criteriaItems>
        <description>When a work item gets to Done, the End Date is populated with the current date.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Start Date Auto Update</fullName>
        <actions>
            <name>Start_Date_Auto_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Work_Item__c.Status__c</field>
            <operation>equals</operation>
            <value>Ready</value>
        </criteriaItems>
        <description>Whenever a work item goes from New to Ready, the Start Date is changed to the current Date.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Work Item Assignment Notification</fullName>
        <actions>
            <name>Work_Item_Assignment_Notification</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Work_Item__c.Status__c</field>
            <operation>equals</operation>
            <value>New</value>
        </criteriaItems>
        <description>Whenever a Work Item is created, the Assignee has to receive an email containing the Work Item’s Name, Title, Description and a link to the work item.</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
