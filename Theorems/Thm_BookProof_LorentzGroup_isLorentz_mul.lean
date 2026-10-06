-- Generated from ChapterLorentzGroup.lean — theorem BookProof.LorentzGroup.isLorentz_mul
import Mathlib
import Definitions.Def_ChapterLorentzGroup
open BookProof.LorentzGroup



open Matrix

theorem BookProof.LorentzGroup.isLorentz_mul {a b : Matrix (Fin 4) (Fin 4) ℝ}
    (ha : IsLorentz a) (hb : IsLorentz b) : IsLorentz (a * b) := by sorry
