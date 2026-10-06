-- Generated from ChapterEulerNState.lean — solution of BookProof.ChapterEulerNState.tailProd_nonneg
import Mathlib
import Definitions.Def_ChapterEulerNState
open BookProof.ChapterEulerNState



open scoped BigOperators

set_option maxHeartbeats 1000000 in
theorem solution (θ : ℕ → ℝ) (m : ℕ) : 0 ≤ tailProd θ m := Finset.prod_nonneg fun _ _ => sq_nonneg _
