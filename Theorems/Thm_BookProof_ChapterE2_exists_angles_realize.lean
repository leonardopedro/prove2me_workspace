-- Generated from ChapterE2.lean — theorem BookProof.ChapterE2.exists_angles_realize
import Mathlib
import Definitions.Def_ChapterE2
import Definitions.Def_ChapterDoubleSlit
open BookProof.ChapterDoubleSlit
open BookProof.ChapterE2


open scoped BigOperators
open Finset

theorem BookProof.ChapterE2.exists_angles_realize (n : ℕ) (p : Fin n → ℝ)
    (hp : ∀ i, 0 ≤ p i) (hsum : ∑ i, p i = 1) :
    ∃ θ : ℕ → ℝ, ∀ i : Fin n, bornProb θ n i = p i := by sorry
