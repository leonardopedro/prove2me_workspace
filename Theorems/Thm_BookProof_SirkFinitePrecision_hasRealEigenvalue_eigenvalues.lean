-- Generated from ChapterSirkFinitePrecision.lean — theorem BookProof.SirkFinitePrecision.hasRealEigenvalue_eigenvalues
import Mathlib
import Definitions.Def_ChapterSirkFinitePrecision
open BookProof.SirkFinitePrecision






noncomputable section


open scoped InnerProductSpace
open Finset

variable {n : ℕ} {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
  [FiniteDimensional ℂ E]

theorem BookProof.SirkFinitePrecision.hasRealEigenvalue_eigenvalues {T : E →ₗ[ℂ] E} (hT : T.IsSymmetric)
    (hn : Module.finrank ℂ E = n) (i : Fin n) :
    HasRealEigenvalue T (hT.eigenvalues hn i) := by sorry
