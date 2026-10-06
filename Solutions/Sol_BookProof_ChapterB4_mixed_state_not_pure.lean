-- Generated from ChapterB4.lean — solution of BookProof.ChapterB4.mixed_state_not_pure
import Mathlib
import Definitions.Def_ChapterB4
open BookProof.ChapterB4




open Matrix

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution :
    ¬ IsPureState ((1 / 2 : ℝ) • (1 : Matrix (Fin 2) (Fin 2) ℝ)) := by

  rintro ⟨v, hv, hρ⟩
  have e00 : v 0 * v 0 = 1 / 2 := by
    have := congrFun (congrFun hρ 0) 0
    simpa [Matrix.one_apply] using this.symm
  have e01 : v 0 * v 1 = 0 := by
    have := congrFun (congrFun hρ 0) 1
    simpa [Matrix.one_apply] using this.symm
  have e11 : v 1 * v 1 = 1 / 2 := by
    have := congrFun (congrFun hρ 1) 1
    simpa [Matrix.one_apply] using this.symm
  nlinarith [e00, e01, e11]
