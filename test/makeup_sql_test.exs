defmodule MakeupSqlTest do
  use ExUnit.Case
  doctest MakeupSql

  test "it works" do
    query = """
    WITH computed_dates AS (
       SELECT dates::date AS date
         FROM generate_series(
                current_date - $1::interval,
                current_date - interval '1 day',
                interval '1 day'
              ) AS dates
     )
      SELECT dates.date AS day, count(clicks.id) AS count
        FROM computed_dates AS dates
             LEFT JOIN clicks AS clicks ON date(clicks.inserted_at) = dates.date
       WHERE clicks.link_id = $2
    GROUP BY dates.date
    ORDER BY dates.date;
    """

    tokens = MakeupSql.lex(query)
    assert is_list(tokens)
    assert hd(tokens) == {:keyword_reserved, %{language: :sql}, "WITH"}
  end
end
