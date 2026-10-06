-- Generated from ChapterLorentzGroup.lean — solution of BookProof.LorentzGroup.isLorentz_mul
import Mathlib
import Definitions.Def_ChapterLorentzGroup
open BookProof.LorentzGroup




open Matrix

set_option maxHeartbeats 1000000 in
theorem solution {a b : Matrix (Fin 4) (Fin 4) ℝ}
    (ha : IsLorentz a) (hb : IsLorentz b) : IsLorentz (a * b) := by

      unfold IsLorentz at *; simp_all [ Matrix.mul_assoc ] ;
      simp_all [ ← Matrix.mul_assoc ]
