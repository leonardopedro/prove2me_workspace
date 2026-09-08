-- Generated from ChapterSirkFinitePrecision.lean — solution of BookProof.SirkFinitePrecision.hasRealEigenvalue_eigenvalues
import Mathlib
import Definitions.Def_ChapterSirkFinitePrecision
open BookProof.SirkFinitePrecision







noncomputable section


open scoped InnerProductSpace
open Finset

variable {n : ℕ} {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
  [FiniteDimensional ℂ E]

set_option maxHeartbeats 1000000 in
theorem solution {T : E →ₗ[ℂ] E} (hT : T.IsSymmetric)
    (hn : Module.finrank ℂ E = n) (i : Fin n) :
    HasRealEigenvalue T (hT.eigenvalues hn i) := by

  refine ⟨hT.eigenvectorBasis hn i, ?_, hT.apply_eigenvectorBasis hn i⟩
  have hnorm := (hT.eigenvectorBasis hn).orthonormal.1 i
  intro h
  rw [h] at hnorm
  simp at hnorm
