-- Generated from ChapterH1.lean — solution of BookProof.ChapterH1.psi_resolvent
import Mathlib
import Definitions.Def_ChapterH1
open BookProof.ChapterH1



open scoped BigOperators
open intervalIntegral


noncomputable section

set_option maxHeartbeats 1000000 in
ty `φ_k(A) =
ψ_{k,γ}(X)`.
-/
theorem solution (k : ℕ) (γ z : ℂ) (_hz : γ - z ≠ 0) :
    psi k γ (γ - z)⁻¹ = phi k z := by
  unfold psi; aesop;

/-
**H1.5** (resolvent eigenvector, the spectral bridge): if `A v = z v` and
`γ − z` is invertible, then `v` is an eigenvector of the resolvent
`X = (γI − A)⁻¹` :=
  with eigenvalue `(γ − z)⁻¹`, i.e. `X v = (γ − z)⁻¹ • v`.
  This is the per-component reduction underlying the CFC identity of H1.5.
  -/
  theorem resolvent_eigenvector {F : Type*} [NormedAddCommGroup F] [Norme
