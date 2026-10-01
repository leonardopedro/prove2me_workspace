-- Generated from ChapterGhostField.lean — theorem BookProof.GhostField.brst_charge_nilpotent_ghost
import Mathlib
import Definitions.Def_ChapterGhostField
open BookProof.GhostField



open Matrix

theorem BookProof.GhostField.brst_charge_nilpotent_ghost (b : Matrix (Fin 2) (Fin 2) ℂ)
    (hb : Commute b psiDag) : (b * psiDag) * (b * psiDag) = 0 := by sorry
