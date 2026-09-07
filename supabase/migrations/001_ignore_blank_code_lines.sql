-- Apply in the Supabase SQL Editor. New and existing blank lines are removed.
create or replace function public.admin_create_code(
  p_title text,
  p_lines text[]
)
returns uuid
language plpgsql
security definer
set search_path = public
as $$
declare
  v_id uuid;
  v_lines text[];
begin
  if not public.is_admin() then
    raise exception 'FORBIDDEN';
  end if;

  select coalesce(array_agg(line_text order by ord), '{}'::text[])
  into v_lines
  from unnest(p_lines) with ordinality as x(line_text, ord)
  where btrim(line_text) <> '';

  if cardinality(v_lines) < 1 then
    raise exception 'EMPTY';
  end if;

  insert into public.codes(title)
  values (p_title)
  returning id into v_id;

  insert into public.code_lines(code_id, line_text, correct_position)
  select v_id, line_text, ord::int
  from unnest(v_lines) with ordinality as x(line_text, ord);

  return v_id;
end;
$$;

-- Use only before an exam begins. It removes blank lines from existing questions
-- and renumbers their remaining correct positions.
delete from public.code_lines where btrim(line_text) = '';
update public.code_lines set correct_position = correct_position + 1000000;
with renumbered as (
  select id, row_number() over (partition by code_id order by correct_position) as position
  from public.code_lines
)
update public.code_lines line
set correct_position = renumbered.position
from renumbered
where line.id = renumbered.id;

notify pgrst, 'reload schema';
