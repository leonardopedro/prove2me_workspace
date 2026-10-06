-- Generated from ChapterGleasonPureMixed.lean — solution of BookProof.ChapterGleasonPureMixed.halfI_not_pure
import Mathlib
import Definitions.Def_ChapterGleasonPureMixed
open BookProof.ChapterGleasonPureMixed



open scoped BigOperators
open Matrix

set_option maxHeartbeats 1000000 in
theorem solution :
    ¬ IsPureState ((1/2 : ℝ) • (1 : Matrix (Fin 2) (Fin 2) ℝ)) := by

  rintro ⟨-, hidem, -⟩
  have := congrFun (congrFun hidem 0) 0
  simp [Matrix.mul_apply, Fin.sum_univ_two] at this
