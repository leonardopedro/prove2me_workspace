-- Generated from ChapterYangMillsHermite.lean — solution of BookProof.YangMillsHermite.levi_values
import Mathlib
import Definitions.Def_ChapterYangMillsHermite
open BookProof.YangMillsHermite








open MeasureTheory Complex MvPolynomial
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.FriedrichsExtension BookProof.HashimotoShiftInvert

noncomputable section

variable {d : ℕ}

















































variable {D : Submodule ℂ (L2d d)}












variable {D : Submodule ℂ (L2d 99)}

set_option maxHeartbeats 1000000 in
theorem solution :
    levi 0 1 2 = 1 ∧ levi 1 2 0 = 1 ∧ levi 2 0 1 = 1 ∧
      levi 0 2 1 = -1 ∧ levi 2 1 0 = -1 ∧ levi 1 0 2 = -1 ∧
      levi 0 0 1 = 0 ∧ levi 1 1 1 = 0 := by

  refine ⟨?_, ?_, ?_, ?_, ?_, ?_, ?_, ?_⟩ <;> norm_num [levi]
