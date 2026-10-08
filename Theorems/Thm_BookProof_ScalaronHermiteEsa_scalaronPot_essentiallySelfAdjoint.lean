-- Generated from ChapterScalaronHermiteEsa.lean — theorem BookProof.ScalaronHermiteEsa.scalaronPot_essentiallySelfAdjoint
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterQgHermiteFriedrichs
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterStarobinskyPotential
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterSirkTrotterKato
import Mathlib
import Definitions.Def_ChapterScalaronHermiteEsa
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterQgHermiteOscillatorEsa
import Theorems.Thm_BookProof_ScalaronHermiteEsa_continuous_scalaronPot
open BookProof.HermiteProductCore
open BookProof.QgHermiteOscillator
open BookProof.ScalaronHermiteEsa



open MeasureTheory Complex MvPolynomial FourierTransform
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgHermiteOscillator BookProof.FarisLavine BookProof.Starobinsky
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

variable {d : ℕ}


theorem BookProof.ScalaronHermiteEsa.scalaronPot_essentiallySelfAdjoint (M alpha : ℝ) (hM : 0 < M) :
    EssentiallySelfAdjointOn (polyGaussCore (d := 1))
      (potCore (scalaronPot M alpha) (continuous_scalaronPot M alpha)
        (expBounded_scalaronPot M alpha hM)) := by sorry
