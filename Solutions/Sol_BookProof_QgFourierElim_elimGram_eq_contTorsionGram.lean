-- Generated from ChapterQgFourierElimination.lean — solution of BookProof.QgFourierElim.elimGram_eq_contTorsionGram
import Mathlib
import Definitions.Def_ChapterQgFourierElimination
import Theorems.Thm_BookProof_QgFourierElim_elimTorsion_eq_torsionCoef
open BookProof.QgFourierElim




open BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.QgVielbeinModeInstance BookProof.QgContinuumModeInstance
open BookProof.QgBrstDerivativeGauge
open BookProof.FarisLavine BookProof.QgOuterFockCoreFL

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (x y : CMode) : elimGram x y = contTorsionGram x y := by

  by_cases h : x.1 = y.1
  · have hy : y.1 = x.1 := h.symm
    simp only [elimGram, contTorsionGram, if_pos h]
    refine Finset.sum_congr rfl fun mu _ => Finset.sum_congr rfl fun nu _ =>
      Finset.sum_congr rfl fun i _ => ?_
    rw [elimTorsion_eq_torsionCoef, elimTorsion_eq_torsionCoef, if_pos rfl, if_pos hy]
  · have hy : ¬ y.1 = x.1 := fun hh => h hh.symm
    simp only [elimGram, contTorsionGram, if_neg h]
    refine Finset.sum_eq_zero fun mu _ => Finset.sum_eq_zero fun nu _ =>
      Finset.sum_eq_zero fun i _ => ?_
    have hzero : elimTorsion x.1 mu nu i y = 0 := by
      rw [elimTorsion_eq_torsionCoef, if_neg hy]
    rw [hzero, mul_zero]
