-- Generated from ChapterScalaronHermiteEsa.lean — solution of BookProof.ScalaronHermiteEsa.scalaronSector_stone_flow
import Mathlib
import Definitions.Def_ChapterScalaronHermiteEsa
import Theorems.Thm_BookProof_ScalaronHermiteEsa_potCore_stone_flow
import Theorems.Thm_BookProof_QgHermiteCore_continuous_scalaronSectorPotential
import Theorems.Thm_BookProof_QgHermiteCore_expBounded_scalaronSectorPotential
open BookProof.ScalaronHermiteEsa




open MeasureTheory Complex MvPolynomial FourierTransform
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgHermiteOscillator BookProof.FarisLavine BookProof.Starobinsky
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (M alpha : ℝ) (hM : 0 < M) (V3 : Polynomial ℝ) :
    ∃ (T : UnboundedSelfAdjoint (L2d 2)) (U : ℝ → (L2d 2 →L[ℂ] L2d 2)),
      IsSelfAdjointExtension
        (potCore (scalaronSectorPotential M alpha V3)
          (continuous_scalaronSectorPotential M alpha V3)
          (expBounded_scalaronSectorPotential M alpha hM V3)) T.op ∧ IsStoneFlow T U := potCore_stone_flow _ _
