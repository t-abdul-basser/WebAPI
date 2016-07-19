select gender_concept_id, concept_name as gender
from @tableQualifier.person p
join @tableQualifier.concept c on p.gender_concept_id = c.concept_id
where person_id = @personId
