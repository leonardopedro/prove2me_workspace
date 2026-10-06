-- Generated from ChapterNavierStokesCarleman.lean — solution of BookProof.NavierStokesFlow.Carleman.linearFull_not_bounded
import Mathlib
import Definitions.Def_ChapterNavierStokesCarleman
import Theorems.Thm_BookProof_NavierStokesFlow_Carleman_halfLineFullData_hamiltonian
import Theorems.Thm_BookProof_NavierStokesFlow_Carleman_linearFullData_symbol
import Theorems.Thm_BookProof_NavierStokesFlow_Carleman_norm_nsCoupling_linear
import Theorems.Thm_BookProof_NavierStokesFlow_Carleman_tridiagOp_not_bounded
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.Carleman



open scoped ENNReal



open LpNat DiagonalEsa FullEsa

set_option maxHeartbeats 1000000 in
theorem solution :
    ¬ ∃ C : ℝ, ∀ f : linearFullData.D, ‖linearFullData.hamiltonian f‖ ≤ C * ‖f‖ := by

  have hham : (halfLineFullData linearMode 1).hamiltonian
      = tridiagOp (nsCoupling (fun m : ℕ => (m : ℝ) + 1)) := by
    rw [halfLineFullData_hamiltonian, linearFullData_symbol]
  have hnb : ¬ ∃ C : ℝ, ∀ f : lpFiniteModes ℕ,
      ‖tridiagOp (nsCoupling (fun m : ℕ => (m : ℝ) + 1)) f‖ ≤ C * ‖f‖ := by
    refine tridiagOp_not_bounded _ fun C => ?_
    refine ⟨⌈|C|⌉₊, ?_⟩
    rw [norm_nsCoupling_linear]
    have hc : C ≤ |C| := le_abs_self C
    have hn : |C| ≤ (⌈|C|⌉₊ : ℝ) := Nat.le_ceil _
    linarith
  rintro ⟨C, hC⟩
  exact hnb ⟨C, fun f => by rw [← hham]; exact hC f⟩
