Class {
	#name : #WAContactBook,
	#superclass : #WAComponent,
	#instVars : [
		'contactBook'
	],
	#category : #ContactBook
}

{ #category : #'class initialization' }
WAContactBook class >> initialize [ 
(WAAdmin register: self asApplicationAt: 'contacts')
	addLibrary: JQDevelopmentLibrary;
	addLibrary: TBSDeploymentLibrary.
]

{ #category : #adding }
WAContactBook >> addContact [
(self call: WAContact new)
	ifNotNil: [ :contact | contactBook addContact: contact ]
]

{ #category : #adding }
WAContactBook >> contactBook [ 
^ contactBook ifNil: [ contactBook := ContactBook createDefault ]
]

{ #category : #adding }
WAContactBook >> contacts [ 
^ self contactBook contacts
]

{ #category : #adding }
WAContactBook >> contactsDo: aBlock [
self contacts do: aBlock
]

{ #category : #adding }
WAContactBook >> renderButtonsForContact: aContact on: html [ 
html tbsButtonGroup: [ 
	self 
		renderEditButtonForContact: aContact on: html;
		renderRemoveButtonForContact: aContact on: html ]
]

{ #category : #adding }
WAContactBook >> renderContact: aContact on: html [ 
	html tableRow:[
		html 
			tableData: aContact fullname;
			tableData: aContact  email;
			tableData: [ self renderPhotoOf: aContact on: html ];
			tableData: [ self renderButtonsForContact: aContact on: html ] ]
]

{ #category : #adding }
WAContactBook >> renderContactsOn: html [ 
html tbsTable: [ 
	html tableHead:[
		html
			tableHeading: 'Name';
			tableHeading: 'Email';
			tableHeading: 'Photo' ].
		self contactsDo: [ :contact | self renderContact: contact on: html ] ]
]

{ #category : #adding }
WAContactBook >> renderContentOn: html [
"Main entry point of the view. Render a title."

html 
	tbsContainer: [
		html heading 
			level: 1;
			with: 'My Contact Book'.
			html tbsForm: [ self renderContactsOn: html .
								 self renderGlobalButtonsOn: html ] ]
]

{ #category : #adding }
WAContactBook >> renderEditButtonForContact: aContact on: html [ 
html tbsButton 
	beSuccess;
	callback: [ self call: (WAContact editContact: aContact ) ];
	with: 'Edit'
]

{ #category : #adding }
WAContactBook >> renderGlobalButtonsOn: html [ 
html tbsButtonGroup: [ 
	html tbsButton 
		beSuccess;
		callback: [ self addContact ];
		with: 'New contact' ]
]

{ #category : #adding }
WAContactBook >> renderPhotoOf: aContact on: html [ 
html image url: aContact gravatarUrl 
]

{ #category : #adding }
WAContactBook >> renderRemoveButtonForContact: aContact on: html [ 
html tbsButton 
	beDanger;
	callback: [ self contactBook removeContact: aContact ];
	with: 'Remove'
]
