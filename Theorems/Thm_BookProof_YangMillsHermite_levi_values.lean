-- Generated from ChapterYangMillsHermite.lean — theorem BookProof.YangMillsHermite.levi_values
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterComplexShiftCore
import Mathlib
import Definitions.Def_ChapterYangMillsHermite
open BookProof.YangMillsHermite

variable {d : ℕ}
variable {D : Submodule ℂ (L2d d)}
variable {D : Submodule ℂ (L2d 99)}



open MeasureTheory Complex MvPolynomial
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.FriedrichsExtension BookProof.HashimotoShiftInvert

noncomputable section


theorem BookProof.YangMillsHermite.levi_values :
    levi 0 1 2 = 1 ∧ levi 1 2 0 = 1 ∧ levi 2 0 1 = 1 ∧
      levi 0 2 1 = -1 ∧ levi 2 1 0 = -1 ∧ levi 1 0 2 = -1 ∧
      levi 0 0 1 = 0 ∧ levi 1 1 1 = 0 := by sorry
