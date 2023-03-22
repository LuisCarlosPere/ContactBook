Class {
	#name : #Contact,
	#superclass : #Object,
	#instVars : [
		'fullname',
		'email'
	],
	#category : #ContactBook
}

{ #category : #'instance creation' }
Contact class >> newNamed: aNameString email: anEmaiString [
^ self new 
		fullname: aNameString ;
		email: anEmaiString ;
		yourself
]

{ #category : #accessing }
Contact >> email [

^ email.
]

{ #category : #accessing }
Contact >> email: aString [

email := aString.
]

{ #category : #accessing }
Contact >> fullname [

^ fullname.
]

{ #category : #accessing }
Contact >> fullname: aString [

fullname := aString.
]

{ #category : #accessing }
Contact >> gravatarUrl [
^ 'http://www.gravatar.com/avatar/', (MD5 hashMessage: email asString trimBoth asLowercase) hex, '.jpg'
]

{ #category : #accessing }
Contact >> printOn: aStream [
aStream 
	nextPutAll: self fullname;
	nextPutAll: ' <';
	nextPutAll: self email;
	nextPutAll: '>'
]
