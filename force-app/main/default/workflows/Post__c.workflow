<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Post_approved</fullName>
        <description>Post approved</description>
        <protected>false</protected>
        <recipients>
            <field>Author_Writer__c</field>
            <type>contactLookup</type>
        </recipients>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderAddress>pablorcarmona@hotmail.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Work_Item_Notification/Post_approved</template>
    </alerts>
    <alerts>
        <fullName>Post_rejected</fullName>
        <description>Post rejected</description>
        <protected>false</protected>
        <recipients>
            <field>Author_Writer__c</field>
            <type>contactLookup</type>
        </recipients>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderAddress>pablorcarmona@hotmail.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Work_Item_Notification/Post_rejected</template>
    </alerts>
    <fieldUpdates>
        <fullName>Post_Approval_process</fullName>
        <field>Status__c</field>
        <literalValue>Ready</literalValue>
        <name>Post Approval process</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Post_Approval_process_check</fullName>
        <field>Approved__c</field>
        <literalValue>1</literalValue>
        <name>Post Approval process check</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Post_Approval_process_reject</fullName>
        <field>Status__c</field>
        <literalValue>Draft</literalValue>
        <name>Post Approval process reject</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Post_Auto_Status_on_creation</fullName>
        <description>Whenever a Post is first created, it’s automatically set to “Draft” status</description>
        <field>Status__c</field>
        <literalValue>Draft</literalValue>
        <name>Post Auto Status on creation</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Post_Published_Date_on_creation</fullName>
        <field>Published_Date__c</field>
        <formula>TODAY()</formula>
        <name>Post Published Date on creation</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Post Approval process step</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Post__c.Status__c</field>
            <operation>equals</operation>
            <value>Under Review</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Post Auto Status on creation</fullName>
        <actions>
            <name>Post_Auto_Status_on_creation</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Post_Published_Date_on_creation</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Post__c.Status__c</field>
            <operation>notEqual</operation>
            <value>Ready</value>
        </criteriaItems>
        <description>Whenever a Post is first created, it’s automatically set to “Draft” status</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
