-- Generated from ChapterDiagonalDGammaEsa.lean — solution of BookProof.DiagonalDGamma.symmetricOn_diagOp
import Mathlib
import Definitions.Def_ChapterDiagonalDGammaEsa
import Theorems.Thm_BookProof_DiagonalDGamma_diagBasis_apply
import Theorems.Thm_BookProof_DiagonalDGamma_diagOp_apply_basis
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
theorem solution (lam : ι → ℝ) : SymmetricOn (diagDomain E) (diagOp hE lam) := by

  classical
  intro x y
  have hx := (diagBasis hE).linearCombination_repr x
  have hy := (diagBasis hE).linearCombination_repr y
  rw [← hx, ← hy]
  simp only [Finsupp.linearCombination_apply, Finsupp.sum, map_sum, map_smul,
    inner_sum, sum_inner, inner_smul_left, inner_smul_right, Submodule.coe_sum,
    Submodule.coe_smul, diagOp_apply_basis, diagBasis_apply, Finset.mul_sum,
    Complex.conj_ofReal]
  refine Finset.sum_congr rfl fun i _ => ?_
  refine Finset.sum_congr rfl fun j _ => ?_
  rcases eq_or_ne j i with rfl | hji
  · ring
  · rw [hE.2 hji]; ring
