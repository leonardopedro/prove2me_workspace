-- Generated from ChapterEulerNState.lean — theorem BookProof.ChapterEulerNState.exists_theta_tailProd
import Mathlib
import Definitions.Def_ChapterEulerNState
open BookProof.ChapterEulerNState


open scoped BigOperators

theorem BookProof.ChapterEulerNState.exists_theta_tailProd (p : ℕ → ℝ) (hp : ∀ k, 0 ≤ p k) {n : ℕ}
    (hsum : ∑ j ∈ Finset.range n, p j = 1) :
    ∃ θ : ℕ → ℝ, ∀ m ≤ n, tailProd θ m = tailSum p n m := by sorry
