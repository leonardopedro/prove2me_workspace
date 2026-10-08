-- Generated from ChapterQgHermiteFriedrichs.lean — theorem BookProof.QgHermiteFriedrichs.hermiteCore_friedrichs_extension_of_nonneg
import Definitions.Def_ChapterStarobinskyPotential
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterFriedrichsExtension
import Mathlib
import Definitions.Def_ChapterQgHermiteFriedrichs
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterYangMillsFriedrichs
open BookProof.HermiteProductCore
open BookProof.QgHermiteCore
open BookProof.YangMillsFriedrichs
open BookProof.QgHermiteFriedrichs



open MeasureTheory Complex MvPolynomial
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.Starobinsky
open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.FriedrichsExtension

noncomputable section

variable {d : ℕ}

variable (W : Vd d → ℝ)

theorem BookProof.QgHermiteFriedrichs.hermiteCore_friedrichs_extension_of_nonneg (hWc : Continuous W) (hWb : ExpBounded W)
    (hW0 : ∀ x, 0 ≤ W x) :
    ∃ (Dom : Submodule ℂ (L2d d)) (A : Dom →ₗ[ℂ] L2d d),
      IsPositiveSelfAdjointExtension (hamCore W hWc hWb) A := by sorry
