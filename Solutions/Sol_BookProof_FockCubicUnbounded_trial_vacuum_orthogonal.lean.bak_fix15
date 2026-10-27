-- Generated from ChapterFockCubicUnbounded.lean — solution of BookProof.FockCubicUnbounded.trial_vacuum_orthogonal
import Mathlib
import Definitions.Def_ChapterFockCubicUnbounded
import Theorems.Thm_BookProof_FockCubicUnbounded_trial_at_other
open BookProof.FockCubicUnbounded



noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FockFieldPerturbation

set_option maxHeartbeats 1000000 in
theorem solution {k n : ℕ} (hn : n ≠ 0) (c : ℝ) : trial k n c 0 = 0 := by

  have h0 : (0 : Conf) = confAt k 0 := by simp [confAt]
  rw [h0]
  exact trial_at_other (by omega) (by omega)
