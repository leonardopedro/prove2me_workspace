-- Generated from ChapterDiagonalDGammaEsa.lean — solution of BookProof.DiagonalDGamma.not_bounded_diagOp
import Mathlib
import Definitions.Def_ChapterDiagonalDGammaEsa
import Theorems.Thm_BookProof_DiagonalDGamma_diagOp_eig
import Theorems.Thm_BookProof_DiagonalDGamma_diagVec_coe
open BookProof.DiagonalDGamma




open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}
variable (Hs : IPSpace) (D₂ : Submodule ℂ Hs.carrier) (A : D₂ →ₗ[ℂ] Hs.carrier)
  {ι : Type*} (e : ι → D₂) (lam : ι → ℝ)
variable {Hs}
variable {E : ι → Hs.carrier} (hE : Orthonormal ℂ E)

set_option maxHeartbeats 1000000 in
theorem solution (lam : ι → ℝ) (hlam : ∀ C : ℝ, ∃ i, C < |lam i|) :
    ¬ ∃ C : ℝ, ∀ x : diagDomain E, ‖diagOp hE lam x‖ ≤ C * ‖(x : Hs.carrier)‖ := by

  rintro ⟨C, hC⟩
  obtain ⟨i, hi⟩ := hlam C
  have hnorm : ‖E i‖ = 1 := hE.1 i
  have h1 : ‖diagOp hE lam (diagVec hE i)‖ = |lam i| := by
    rw [diagOp_eig, norm_smul, diagVec_coe, hnorm, mul_one, Complex.norm_real, Real.norm_eq_abs]
  have h2 := hC (diagVec hE i)
  rw [h1, diagVec_coe, hnorm, mul_one] at h2
  linarith
