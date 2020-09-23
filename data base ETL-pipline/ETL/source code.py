import psycopg2


def selectall(db, table):
    q = "SELECT * FROM " + table + ";"
    if db == 'library_temp':
        cursor1.execute(q)
        record = cursor1.fetchall()
    if db == 'library_temp':
        cursor2.execute(q)
        record = cursor2.fetchall()
    return record


def get_dependency(con):
    myc = con.cursor()
    myc.execute('''
    SELECT
        tc.table_name AS dependent_table,
        ccu.table_name AS main_table
    FROM
        information_schema.table_constraints AS tc
        JOIN information_schema.key_column_usage AS kcu
        ON tc.constraint_name=kcu.constraint_name
        AND tc.table_schema = kcu.table_schema
        JOIN information_schema.constraint_column_usage AS ccu
        ON tc.constraint_name = ccu.constraint_name
        AND tc.table_schema = ccu.table_schema;
    ''')
    results = myc.fetchall()
    # temp_df = pd.DataFrame(list(results), columns=["dependent_table", "main_table"])Z
    return results


def get_pk(con, table):
    mycur = con.cursor()
    mycur.execute('''SELECT KU.table_name as TABLENAME,column_name as PRIMARYKEYCOLUMN
        FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS AS TC
        INNER JOIN
        INFORMATION_SCHEMA.KEY_COLUMN_USAGE AS KU
        ON TC.CONSTRAINT_TYPE = 'PRIMARY KEY' AND
        TC.CONSTRAINT_NAME = KU.CONSTRAINT_NAME AND 
        KU.table_name='{}'
        ORDER BY KU.TABLE_NAME, KU.ORDINAL_POSITION;'''.format(table))
    results = mycur.fetchall()
    return results


try:
    c1 = psycopg2.connect(user="postgres",
                          password="0312180543",
                          host="localhost",
                          port="5432",
                          database="library_temp_temp")

    c2 = psycopg2.connect(user="postgres",
                          password="0312180543",
                          host="localhost",
                          port="goin",
                          database="library_temp")

    cursor1 = c1.cursor()
    cursor2 = c2.cursor()

    finalt = []
    tables = get_dependency(c1)

    for t in finalt:
        for tdata in t:
            flag = 0
            for mylist in selectall('library_temp', tdata[0]):
                for item in selectall('library_temp', tdata[0]):
                    if item[0] == mylist[0]:
                        if item != mylist:
                            q = "DELETE FROM " + tdata[0] + " WHERE " + tdata[1] + "=" + item[0] + ";"
                            cursor2.execute(q)

                            q = "INSERT INTO " + tdata[0] + " VALUES ("
                            for things in mylist:
                                q = q + str(things) + ","
                            q = q[:-1]
                            q = q + ");"
                            cursor2.execute(q)

                        flag = 1
                if flag == 0:

                    q = "INSERT INTO " + tdata[0] + " VALUES ("
                    for things in mylist:
                        q = q + str(things) + ","
                    q = q[:-1]
                    q = q + ");"
                    cursor2.execute(q)

            for row in selectall('library_temp', tdata[0]):
                if row in selectall('library_temp', tdata[0]):
                    break
                else:
                    q = "DELETE FROM " + tdata[0] + " WHERE " + tdata[1] + "=" + row + ";"
                    cursor2.execute(q)

    c1.commit()
    c2.commit()

except (Exception, psycopg2.Error) as error:
    print(error)
