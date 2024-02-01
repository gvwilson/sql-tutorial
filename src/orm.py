from sqlmodel import Field, Session, SQLModel, create_engine, select


class Department(SQLModel, table=True):
    ident: str = Field(default=None, primary_key=True)
    name: str
    building: str


engine = create_engine("sqlite:///db/assays.db")
with Session(engine) as session:
    statement = select(Department)
    for result in session.exec(statement).all():
        print(result)
