-- Generated from ChapterYangMillsHermite.lean — solution of BookProof.YangMillsHermite.ym_hermite_friedrichs_extension
import Mathlib
import Definitions.Def_ChapterYangMillsHermite
import Theorems.Thm_BookProof_YangMillsHermite_ymHamiltonian_symmetricOn
import Theorems.Thm_BookProof_YangMillsHermite_ymHamiltonian_quadForm_nonneg
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterComplexShiftCore
open BookProof.YangMillsHermite








open MeasureTheory Complex MvPolynomial
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.FriedrichsExtension BookProof.HashimotoShiftInvert

noncomputable section

variable {d : ℕ}

















































variable {D : Submodule ℂ (L2d d)}












variable {D : Submodule ℂ (L2d 99)}

set_option maxHeartbeats 1000000 in
theorem solution (fabc : Fin 8 → Fin 8 → Fin 8 → ℝ) :
    ∃ (Dom : Submodule ℂ (L2d 99)) (A : Dom →ₗ[ℂ] L2d 99),
      IsPositiveSelfAdjointExtension (ymHamiltonian (coreRepPoly 99) fabc) A :=
  friedrichs_extension_exists
      ⟨polyGaussCore, ymHamiltonian (coreRepPoly 99) fabc,
        ymHamiltonian_symmetricOn _ fabc, ymHamiltonian_quadForm_nonneg _ fabc⟩
      polyGaussCore_dense
