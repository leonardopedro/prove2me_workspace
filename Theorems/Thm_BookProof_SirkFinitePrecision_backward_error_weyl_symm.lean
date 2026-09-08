-- Generated from ChapterSirkFinitePrecision.lean — theorem BookProof.SirkFinitePrecision.backward_error_weyl_symm
import Mathlib
import Definitions.Def_ChapterSirkFinitePrecision
open BookProof.SirkFinitePrecision






noncomputable section


open scoped InnerProductSpace
open Finset

variable {n : ℕ} {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
  [FiniteDimensional ℂ E]

theorem BookProof.SirkFinitePrecision.backward_error_weyl_symm {T S : E →ₗ[ℂ] E} (hS : S.IsSymmetric)
    (hn : Module.finrank ℂ E = n) {ε : ℝ} (hε : ∀ x : E, ‖T x - S x‖ ≤ ε * ‖x‖)
    {lam : ℝ} (hlam : HasRealEigenvalue T lam) :
    ∃ mu : ℝ, HasRealEigenvalue S mu ∧ |mu - lam| ≤ ε := by sorry
