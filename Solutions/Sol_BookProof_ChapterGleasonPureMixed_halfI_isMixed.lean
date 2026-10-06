-- Generated from ChapterGleasonPureMixed.lean — solution of BookProof.ChapterGleasonPureMixed.halfI_isMixed
import Mathlib
import Definitions.Def_ChapterGleasonPureMixed
open BookProof.ChapterGleasonPureMixed



open scoped BigOperators
open Matrix

set_option maxHeartbeats 1000000 in
theorem solution :
    IsMixedState ((1/2 : ℝ) • (1 : Matrix (Fin 2) (Fin 2) ℝ)) := by

  refine ⟨?_, ?_⟩
  · exact Matrix.PosSemidef.one.smul (by norm_num)
  · simp [Matrix.trace]
