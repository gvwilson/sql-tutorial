from sqlmodel import Field, Session, SQLModel, create_engine, select
import sys
from typing import Optional


class Department(SQLModel, table=True):
    ident: str = Field(default=None, primary_key=True)
    name: str
    building: str


# [keep]
class Staff(SQLModel, table=True):
    ident: str = Field(default=None, primary_key=True)
    personal: str
    family: str
    dept: Optional[str] = Field(default=None, foreign_key="department.ident")
    age: int


db_uri = f"sqlite:///{sys.argv[1]}"
engine = create_engine(db_uri)
SQLModel.metadata.create_all(engine)
with Session(engine) as session:
    statement = select(Department, Staff).where(Staff.dept == Department.ident)
    for dept, staff in session.exec(statement):
        print(f"{dept.name}: {staff.personal} {staff.family}")
# [/keep]
