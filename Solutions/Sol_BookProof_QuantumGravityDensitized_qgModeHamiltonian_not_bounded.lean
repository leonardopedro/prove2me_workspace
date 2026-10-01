-- Generated from ChapterQuantumGravityDensitized.lean — solution of BookProof.QuantumGravityDensitized.qgModeHamiltonian_not_bounded
import Mathlib
import Definitions.Def_ChapterQuantumGravityDensitized
import Theorems.Thm_BookProof_FarisLavine_mulHamiltonian_not_bounded
open BookProof.QuantumGravityDensitized




open Filter Topology BookProof.FarisLavine

set_option maxHeartbeats 1000000 in
theorem solution :
    ¬ ∃ C : ℝ, ∀ f : mulSymbolDomain (qgModeSymbol (fun k => (k : ℝ)) 0 0),
      ‖qgModeHamiltonian (fun k => (k : ℝ)) 0 0 f‖ ≤ C * ‖(f : L2Nat)‖ := by

  refine mulHamiltonian_not_bounded _ fun C => ?_
  obtain ⟨k, hk⟩ := exists_nat_gt (|C| * 16 + 16)
  refine ⟨k, ?_⟩
  have hk0 : (0 : ℝ) ≤ (k : ℝ) := Nat.cast_nonneg k
  have hC : C ≤ |C| := le_abs_self C
  have habs : |qgModeSymbol (fun k => (k : ℝ)) 0 0 k| = 1 / 16 * (k : ℝ) ^ 2 := by
    have : qgModeSymbol (fun k => (k : ℝ)) 0 0 k = 1 / 16 * (k : ℝ) ^ 2 := by
      simp [qgModeSymbol]
    rw [this, abs_of_nonneg (by positivity)]
  rw [habs]
  nlinarith [abs_nonneg C]
