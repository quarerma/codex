migrations=(
  "20240619140621_first_look_at_database"
  "20240619143424_class_specifications"
  "20240619201334_add_initial_feats"
  "20240620190329_remodel_relations"
  "20240621155414_update_migration"
  "20240821203334_rework_database"
  "20240823195101_user_role"
  "20240825183012_description_to_subclass"
  "20240825183058_add_description_to_class"
  "20240826171948_change_afinity"
  "20240902151014_defense_speed"
  "20240902175355_change_how_feats_afinity_works"
  "20240902181036_feat_not_null_on_origin"
  "20240902181609_origin_type_on_feats"
  "20240903225317_conditions"
  "20240914021414_starter_feat_boolean"
  "20240914172504_"
  "20240914175133_add_damage_type"
  "20240916145412_delete_initialfeats"
  "20240918212310_optional_damage"
  "20240918234633_make_damage_string"
  "20240919212558_custom_item_type"
  "20240919212849_revert_change"
  "20240920014945_remove_unique_from_name"
  "20240920142054_custom_description"
  "20250113224034_optional_char_campaign_note"
)

for migration in "${migrations[@]}"; do
  npx prisma migrate resolve --applied "$migration"
done