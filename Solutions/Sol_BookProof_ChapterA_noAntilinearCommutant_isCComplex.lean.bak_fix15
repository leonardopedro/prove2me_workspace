-- Generated from ChapterA2c.lean — solution of BookProof.ChapterA.noAntilinearCommutant_isCComplex
import Mathlib
import Definitions.Def_ChapterA2c
import Theorems.Thm_BookProof_ChapterA_realCommutes_thetaR
open BookProof.ChapterA



open scoped ComplexConjugate InnerProductSpace Quaternion


variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

set_option maxHeartbeats 1000000 in
theorem solution {M : System ℂ V} [Nontrivial V]
    (h : NoAntilinearCommutant M) : IsCComplex M := by

  rintro ⟨θ, hθc⟩
  have hanti : ∀ x, thetaR θ (Complex.I • x) = -(Complex.I • thetaR θ x) := by
    intro x
    simp only [thetaR_apply]
    rw [θ.map_smulₛₗ]
    simp
  have h0 : thetaR θ = 0 := h (thetaR θ) hanti (realCommutes_thetaR hθc)
  obtain ⟨x, hx⟩ := exists_ne (0 : V)
  apply hx
  apply θ.injective
  have : thetaR θ x = 0 := by rw [h0]; rfl
  simpa using this
