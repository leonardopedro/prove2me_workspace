-- Generated from ChapterH1.lean — theorem BookProof.ChapterH1.psi_resolvent
import Mathlib
import Definitions.Def_ChapterH1
open BookProof.ChapterH1

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
variable {A : Type*} [Ring A] [Algebra ℂ A]


open scoped BigOperators
open intervalIntegral


noncomputable section

ty `φ_k(A) =
ψ_{k,γ}(X)`.
-/
theorem BookProof.ChapterH1.psi_resolvent (k : ℕ) (γ z : ℂ) (_hz : γ - z ≠ 0) :
    psi k γ (γ - z)⁻¹ = phi k z := by
  unfold psi; aesop;

/-
**H1.5** (resolvent eigenvector, the spectral bridge): if `A v = z v` and
`γ − z` is invertible, then `v` is an eigenvector of the resolvent
`X = (γI − A)⁻¹` := by sorry
