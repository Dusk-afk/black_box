const sqlOnCreate = """
CREATE TABLE IF NOT EXISTS items (
  id TEXT PRIMARY KEY,
  item_class TEXT,
  name TEXT,
  room_no INTEGER,
  cubicle_no INTEGER,
  drawer_no INTEGER,
  ownership TEXT,
  usage_status TEXT,
  working_status TEXT,
  quantity NUMERIC,
  price NUMERIC
);
""";
