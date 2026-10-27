-- Generated from ChapterPauliSU2.lean — solution of BookProof.ChapterPauliSU2.su2_preserves_spatialNormSq
import Mathlib
import Definitions.Def_ChapterPauliSU2
import Theorems.Thm_BookProof_ChapterPauliSU2_su2_preserves_time
import Theorems.Thm_BookProof_ChapterPauliLorentz_spinorMap_preserves_mink
open BookProof.ChapterPauliSU2



open Matrix
open scoped BigOperators


open BookProof.ChapterPauliLorentz

set_option maxHeartbeats 1000000 in
theorem solution {T : Matrix (Fin 2) (Fin 2) ℂ}
    (hU : Tᴴ * T = 1) (hT : T.det = 1) (x : Fin 4 → ℝ) :
    spatialNormSq (vecOfMat (spinorAction T (hermMat x))) = spatialNormSq x := by

  have h_minkowski : mink (vecOfMat (spinorAction T (hermMat x))) = mink x := by
    have h1 : spinorAction T (hermMat x) = Tᴴ * hermMat x * T := by
      simp [spinorAction]
    rw [h1]
    exact spinorMap_preserves_mink T hT x
  convert congr_arg ( fun y => ( vecOfMat ( spinorAction T ( hermMat x ) ) ) 0 ^ 2 - y ) h_minkowski
      using 1 <;> norm_num [ mink, spatialNormSq ] ; focus (ring);
  rw [ su2_preserves_time hU x ] ; ring!;
