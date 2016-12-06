drop table if exists Checklist;

drop table if exists ChecklistItem;

CREATE TABLE Checklist (
	checklistId	INTEGER PRIMARY KEY AUTOINCREMENT,
	name	TEXT,
	iconName	TEXT
);
CREATE TABLE ChecklistItem (
	checklistItemID	INTEGER PRIMARY KEY AUTOINCREMENT,
	context	TEXT,
	checked	BOOL,
	shouldRemind	BOOL,
	dueDate	DATETIME,
	checklistId	INTEGER,
	constraint FK_Checklist_REFERENCE_Item foreign key (checklistItemID) references Checklist (checklistId)
);

