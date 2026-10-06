-- Generated from ChapterScalaronHermiteEsa.lean — solution of BookProof.ScalaronHermiteEsa.scalaronPot_stone_flow
import Mathlib
import Definitions.Def_ChapterScalaronHermiteEsa
import Theorems.Thm_BookProof_ScalaronHermiteEsa_continuous_scalaronPot
import Theorems.Thm_BookProof_ScalaronHermiteEsa_expBounded_scalaronPot
import Theorems.Thm_BookProof_ScalaronHermiteEsa_potCore_stone_flow
open BookProof.ScalaronHermiteEsa




open MeasureTheory Complex MvPolynomial FourierTransform
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgHermiteOscillator BookProof.FarisLavine BookProof.Starobinsky
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (M alpha : ℝ) (hM : 0 < M) :
    ∃ (T : UnboundedSelfAdjoint (L2d 1)) (U : ℝ → (L2d 1 →L[ℂ] L2d 1)),
      IsSelfAdjointExtension
        (potCore (scalaronPot M alpha) (continuous_scalaronPot M alpha)
          (expBounded_scalaronPot M alpha hM)) T.op ∧ IsStoneFlow T U := potCore_stone_flow _ _
