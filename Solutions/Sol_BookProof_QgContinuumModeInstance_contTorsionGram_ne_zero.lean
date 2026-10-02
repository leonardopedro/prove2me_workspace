-- Generated from ChapterQgContinuumModeInstance.lean — solution of BookProof.QgContinuumModeInstance.contTorsionGram_ne_zero
import Mathlib
import Definitions.Def_ChapterQgContinuumModeInstance




open BookProof.FarisLavine BookProof.QgOuterFockCoreFL

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution :
    contTorsionGram ((unitMom, 1, 0) : CMode) (unitMom, 1, 0) ≠ 0 := by

  simp only [contTorsionGram, torsionCoef, Fin.sum_univ_three, unitMom]
  norm_num [Fin.ext_iff]
