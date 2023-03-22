Class {
	#name : #WAContact,
	#superclass : #WAComponent,
	#instVars : [
		'contact'
	],
	#category : #ContactBook
}

{ #category : #'as yet unclassified' }
WAContact class >> editContact: aContact [
^ self new 
	setContact: aContact;
	yourself
]

{ #category : #accessing }
WAContact >> contact [ 
^ contact
]

{ #category : #accessing }
WAContact >> initialize [ 
	super initialize.
	contact := Contact new.
]

{ #category : #accessing }
WAContact >> renderButtonsOn: html [ 
	html tbsFormGroup: [ 
		html tbsButtonGroup: [ 
			self
				renderSubmitButtonOn: html;
				renderCancelButtonOn: html  ] ]
]

{ #category : #accessing }
WAContact >> renderCancelButtonOn: html [ 
	html tbsButton 
		beDanger;
		callback: [ self answer: nil ];
		with: 'Cancel'
]

{ #category : #accessing }
WAContact >> renderContentOn: html [ 
	html tbsContainer: [ 
		html heading with: 'Contact Editing' .
		html tbsForm with: [ 
			self renderFieldsOn: html.
			self renderButtonsOn: html ] ]
]

{ #category : #accessing }
WAContact >> renderEmailFieldOn: html [ 
	html tbsFormGroup: [ 
		html label: 'Email'.
		html emailInput 
			tbsFormControl;
			placeholder: 'your@email.com';
			callback: [ :value | self contact email: value ];
			value: (self contact email ifNil: '') ]
]

{ #category : #accessing }
WAContact >> renderFieldsOn: html [ 
	self renderFullnameFieldOn: html.
	self renderEmailFieldOn: html.
]

{ #category : #accessing }
WAContact >> renderFullnameFieldOn: html [ 
	html tbsFormGroup: [ 
		html label: 'Fullname'.
		html textInput 
			tbsFormControl;
			placeholder: 'fullname';
			callback: [ :value | self contact fullname: value ];
			value: (self contact fullname ifNil: '') ]
]

{ #category : #accessing }
WAContact >> renderSubmitButtonOn: html [ 
	html tbsSubmitButton 
		beSuccess;
		bePrimary;
		callback: [ self answer: self contact ];
		with: 'Save'
]

{ #category : #accessing }
WAContact >> setContact: aContact [
	contact := aContact
]
