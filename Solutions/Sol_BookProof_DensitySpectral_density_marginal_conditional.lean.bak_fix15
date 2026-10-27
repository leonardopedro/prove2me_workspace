-- Generated from ChapterDensityMarginalConditional.lean — solution of BookProof.DensitySpectral.density_marginal_conditional
import Mathlib
import Definitions.Def_ChapterDensityMarginalConditional
import Theorems.Thm_BookProof_DensitySpectral_bornKernel_nonneg
import Theorems.Thm_BookProof_DensitySpectral_bornKernel_row_sum
import Theorems.Thm_BookProof_DensitySpectral_bornKernel_col_sum
import Theorems.Thm_BookProof_DensitySpectral_density_diag_eq_kernel_apply
import Theorems.Thm_BookProof_DensitySpectral_density_iff_exists_unitary_diagonal
open BookProof.DensitySpectral




open Matrix
open scoped BigOperators ComplexOrder

variable {n : Type*} [Fintype n] [DecidableEq n]

variable {n : Type*} [Fintype n] [DecidableEq n]

set_option maxHeartbeats 1000000 in
theorem solution {ρ : Matrix n n ℂ} (h : IsDensityMatrix ρ) :
    ∃ (U : Matrix.unitaryGroup n ℂ) (d : n → ℝ),
      (∀ i, 0 ≤ d i) ∧ (∑ i, d i = 1) ∧
      (∀ i j, 0 ≤ bornKernel (U : Matrix n n ℂ) i j) ∧
      (∀ i, ∑ j, bornKernel (U : Matrix n n ℂ) i j = 1) ∧
      (∀ j, ∑ i, bornKernel (U : Matrix n n ℂ) i j = 1) ∧
      (∀ i, ρ i i = ((∑ k, bornKernel (U : Matrix n n ℂ) i k * d k : ℝ) : ℂ)) := by

  obtain ⟨U, d, hd, hsum, hrho⟩ := (density_iff_exists_unitary_diagonal ρ).mp h
  refine ⟨U, d, hd, hsum, bornKernel_nonneg _, bornKernel_row_sum U,
    bornKernel_col_sum U, fun i => ?_⟩
  rw [hrho]
  exact density_diag_eq_kernel_apply (U : Matrix n n ℂ) d i
