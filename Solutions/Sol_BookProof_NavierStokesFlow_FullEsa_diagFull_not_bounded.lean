-- Generated from ChapterNavierStokesFullEsa.lean — solution of BookProof.NavierStokesFlow.FullEsa.diagFull_not_bounded
import Mathlib
import Definitions.Def_ChapterNavierStokesFullEsa
import Theorems.Thm_BookProof_NavierStokesFlow_FullEsa_diagUnboundedData_hamiltonian
import Theorems.Thm_BookProof_NavierStokesFlow_DiagonalEsa_diagOp_not_bounded
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FullEsa



open scoped ENNReal

set_option maxHeartbeats 1000000 in
theorem solution :
    ¬ ∃ C : ℝ, ∀ f : diagUnboundedData.D, ‖diagUnboundedData.hamiltonian f‖ ≤ C * ‖f‖ := by

  rw [diagUnboundedData_hamiltonian]
  refine diagOp_not_bounded _ fun C => ?_
  refine ⟨⌈|C|⌉₊ + 1, ?_⟩
  have hc : C ≤ |C| := le_abs_self C
  have hn : |C| ≤ (⌈|C|⌉₊ : ℝ) := Nat.le_ceil _
  have h0 : (0 : ℝ) ≤ (⌈|C|⌉₊ : ℝ) := Nat.cast_nonneg _
  have habs : |-(2 * ((⌈|C|⌉₊ + 1 : ℕ) : ℝ))| = 2 * ((⌈|C|⌉₊ : ℝ) + 1) := by
    push_cast
    rw [abs_neg, abs_of_nonneg (by linarith)]
  rw [habs]
  linarith
