-- Generated from ChapterStrichartzHermiteQG.lean — solution of BookProof.HermiteStrichartzQG.qg3D_not_bounded
import Mathlib
import Definitions.Def_ChapterStrichartzHermiteQG
import Theorems.Thm_BookProof_HermiteStrichartzQG_hermiteCoreOp_not_bounded
open BookProof.HermiteStrichartzQG




open MeasureTheory BookProof.HermiteCore BookProof.FarisLavine
open BookProof.QuantumGravityDensitized

set_option maxHeartbeats 1000000 in
theorem solution :
    ¬ ∃ C : ℝ, ∀ f : hermiteCore,
      ‖qg3DHermiteHamiltonian (fun k _ => (k : ℝ)) 0 0 f‖ ≤ C * ‖(f : L2R)‖ := by

  refine hermiteCoreOp_not_bounded _ fun C => ?_
  obtain ⟨k, hk⟩ := exists_nat_gt (|C| * 16 / 3 + 16)
  refine ⟨k, ?_⟩
  have hval : qg3DModeSymbol (fun k _ => (k : ℝ)) 0 0 k = 3 / 16 * (k : ℝ) ^ 2 := by
    simp [qg3DModeSymbol, qgSymbol]
    ring
  have hk0 : (0 : ℝ) ≤ (k : ℝ) := Nat.cast_nonneg k
  rw [hval, abs_of_nonneg (by positivity)]
  nlinarith [abs_nonneg C, le_abs_self C]
