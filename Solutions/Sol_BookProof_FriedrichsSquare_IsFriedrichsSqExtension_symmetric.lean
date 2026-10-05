-- Generated from ChapterFriedrichsSquareFactorization.lean — solution of BookProof.FriedrichsSquare.IsFriedrichsSqExtension.symmetric
import Mathlib
import Definitions.Def_ChapterFriedrichsSquareFactorization
import Theorems.Thm_BookProof_QgOuterFockFL_Comparison_selfAdjoint
open BookProof.FriedrichsSquare




open BookProof.FarisLavine BookProof.EsaClosure BookProof.ClosureUniqueness

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}
variable [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution {A : D →ₗ[ℂ] F} {hstab : ∀ v : D, (A v : F) ∈ D}
    {R : Submodule ℂ (F × F)} (h : IsFriedrichsSqExtension A hstab R) :
    ∀ p ∈ R, ∀ q ∈ R, (inner ℂ p.2 q.1 : ℂ) = inner ℂ p.1 q.2 := by

  intro p hp q hq
  have hq' : q ∈ adjPairs R := by rw [h.selfAdjoint]; exact hq
  exact hq' p hp
