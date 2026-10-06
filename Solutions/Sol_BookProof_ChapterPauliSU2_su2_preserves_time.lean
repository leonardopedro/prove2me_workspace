-- Generated from ChapterPauliSU2.lean — solution of BookProof.ChapterPauliSU2.su2_preserves_time
import Mathlib
import Definitions.Def_ChapterPauliSU2
open BookProof.ChapterPauliSU2



open Matrix
open scoped BigOperators


open BookProof.ChapterPauliLorentz

set_option maxHeartbeats 1000000 in
theorem solution {T : Matrix (Fin 2) (Fin 2) ℂ} (hT : Tᴴ * T = 1)
    (x : Fin 4 → ℝ) :
    (vecOfMat (spinorAction T (hermMat x))) 0 = x 0 := by

  unfold vecOfMat spinorAction hermMat;
  simp_all [ ← Matrix.ext_iff, Fin.forall_fin_two, Matrix.mul_apply ];
  norm_num [ Complex.ext_iff ] at *;
  grind
