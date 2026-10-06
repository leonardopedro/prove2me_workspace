-- Generated from ChapterScalaronHermiteEsa.lean — solution of BookProof.ScalaronHermiteEsa.scalaronPot_essentiallySelfAdjoint
import Mathlib
import Definitions.Def_ChapterScalaronHermiteEsa
import Theorems.Thm_BookProof_ScalaronHermiteEsa_potCore_essentiallySelfAdjoint
import Theorems.Thm_BookProof_ScalaronHermiteEsa_continuous_scalaronPot
import Theorems.Thm_BookProof_ScalaronHermiteEsa_expBounded_scalaronPot
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
    EssentiallySelfAdjointOn (polyGaussCore (d := 1))
      (potCore (scalaronPot M alpha) (continuous_scalaronPot M alpha)
        (expBounded_scalaronPot M alpha hM)) := potCore_essentiallySelfAdjoint _ _
