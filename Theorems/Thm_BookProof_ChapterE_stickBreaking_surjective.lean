-- Generated from ChapterE.lean — theorem BookProof.ChapterE.stickBreaking_surjective
import Mathlib
import Definitions.Def_ChapterE
open BookProof.ChapterE


open scoped Matrix BigOperators
open Filter
open scoped Topology

theorem BookProof.ChapterE.stickBreaking_surjective {N : ℕ} (P : Fin N → ℝ)
    (hP0 : ∀ n, 0 ≤ P n) (hPsum : ∑ n, P n = 1) :
    ∃ θ : Fin N → ℝ, ∀ n, stickBreaking θ n = P n := by sorry
