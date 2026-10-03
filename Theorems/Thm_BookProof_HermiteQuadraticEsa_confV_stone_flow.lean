-- Generated from ChapterHermiteQuadraticEsa.lean — theorem BookProof.HermiteQuadraticEsa.confV_stone_flow
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterQgHermiteOscillatorEsa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterStarobinskyPotential
import Definitions.Def_ChapterSirkTrotterKato
import Mathlib
import Definitions.Def_ChapterHermiteQuadraticEsa
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterQgHermiteFriedrichs
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterStoneResolvent
import Theorems.Thm_BookProof_HermiteQuadraticEsa_continuous_confW
import Theorems.Thm_BookProof_HermiteQuadraticEsa_expBounded_confW
open BookProof.EsaClosure
open BookProof.HermiteProductCore
open BookProof.QgHermiteFriedrichs
open BookProof.StoneBridge
open BookProof.HermiteQuadraticEsa

variable {d : ℕ}



open MeasureTheory Complex MvPolynomial
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgHermiteOscillator BookProof.FarisLavine BookProof.Starobinsky
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section


theorem BookProof.HermiteQuadraticEsa.confV_stone_flow (M alpha : ℝ) (h0 : 0 < alpha) (h2 : alpha < 1 / 2) :
    ∃ (T : UnboundedSelfAdjoint (L2d 1)) (U : ℝ → (L2d 1 →L[ℂ] L2d 1)),
      IsSelfAdjointExtension
        (hamCore (confW M alpha) (continuous_confW M alpha) (expBounded_confW M alpha)) T.op
        ∧ IsStoneFlow T U := by sorry
