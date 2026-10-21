-- Generated from ChapterPauliSU2.lean — solution of BookProof.ChapterPauliSU2.spinorAction_isHermitian
import Mathlib
import Definitions.Def_ChapterPauliSU2
open BookProof.ChapterPauliSU2



open Matrix
open scoped BigOperators


open BookProof.ChapterPauliLorentz

set_option maxHeartbeats 1000000 in
theorem solution (T : Matrix (Fin 2) (Fin 2) ℂ)
    {X : Matrix (Fin 2) (Fin 2) ℂ} (hX : Xᴴ = X) :
    (spinorAction T X)ᴴ = spinorAction T X := by

  unfold spinorAction;
  simp [ hX, Matrix.mul_assoc ]
