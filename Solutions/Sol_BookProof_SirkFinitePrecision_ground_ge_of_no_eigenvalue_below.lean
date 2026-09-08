-- Generated from ChapterSirkFinitePrecision.lean — solution of BookProof.SirkFinitePrecision.ground_ge_of_no_eigenvalue_below
import Mathlib
import Definitions.Def_ChapterSirkFinitePrecision
open BookProof.SirkFinitePrecision







noncomputable section


open scoped InnerProductSpace
open Finset

variable {n : ℕ} {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
  [FiniteDimensional ℂ E]

set_option maxHeartbeats 1000000 in
theorem solution {T : E →ₗ[ℂ] E} {lam0 θ r : ℝ}
    (hlam0 : HasRealEigenvalue T lam0)
    (hnone : ∀ lam : ℝ, HasRealEigenvalue T lam → θ - r ≤ lam) :
    θ - r ≤ lam0 := hnone lam0 hlam0
