-- Generated from ChapterGhostField.lean — solution of BookProof.GhostField.brst_charge_nilpotent_ghost
import Mathlib
import Definitions.Def_ChapterGhostField
import Theorems.Thm_BookProof_GhostField_psiDag_sq
import Theorems.Thm_BookProof_GhostField_brst_charge_nilpotent
open BookProof.GhostField




open Matrix

set_option maxHeartbeats 1000000 in
theorem solution (b : Matrix (Fin 2) (Fin 2) ℂ)
    (hb : Commute b psiDag) : (b * psiDag) * (b * psiDag) = 0 := brst_charge_nilpotent b psiDag psiDag_sq hb
