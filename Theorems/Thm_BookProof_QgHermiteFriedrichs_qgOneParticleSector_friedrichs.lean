-- Generated from ChapterQgHermiteFriedrichs.lean — theorem BookProof.QgHermiteFriedrichs.qgOneParticleSector_friedrichs
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterYangMillsFriedrichs
import Mathlib
import Definitions.Def_ChapterQgHermiteFriedrichs
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterStarobinskyPotential
open BookProof.FriedrichsExtension
open BookProof.FriedrichsExtension.FormDom
open BookProof.HermiteProductCore
open BookProof.QgHermiteCore
open BookProof.Starobinsky
open BookProof.QgHermiteFriedrichs

variable {d : ℕ}
variable (W : Vd d → ℝ)



open MeasureTheory Complex MvPolynomial
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.Starobinsky
open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.FriedrichsExtension

noncomputable section

variable {d : ℕ}

theorem BookProof.QgHermiteFriedrichs.qgOneParticleSector_friedrichs (M alpha : ℝ) (hM : 0 < M) (halpha : 0 < alpha)
    (V3 : Polynomial ℝ) (c : ℝ) (hV3 : ∀ t : ℝ, -c ≤ V3.eval t) :
    ∃ (Dom : Submodule ℂ (L2d 2)) (A : Dom →ₗ[ℂ] L2d 2),
      IsSemiboundedSelfAdjointExtension c
        (hamCore (scalaronSectorPotential M alpha V3)
          (continuous_scalaronSectorPotential M alpha V3)
          (expBounded_scalaronSectorPotential M alpha hM V3)) A := by sorry
