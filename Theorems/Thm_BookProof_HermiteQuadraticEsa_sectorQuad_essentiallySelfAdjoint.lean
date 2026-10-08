-- Generated from ChapterHermiteQuadraticEsa.lean — theorem BookProof.HermiteQuadraticEsa.sectorQuad_essentiallySelfAdjoint
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterQgHermiteOscillatorEsa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterStarobinskyPotential
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterSirkTrotterKato
import Mathlib
import Definitions.Def_ChapterHermiteQuadraticEsa
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterQgHermiteFriedrichs
open BookProof.HermiteProductCore
open BookProof.QgHermiteFriedrichs
open BookProof.HermiteQuadraticEsa



open MeasureTheory Complex MvPolynomial
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgHermiteOscillator BookProof.FarisLavine BookProof.Starobinsky
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

variable {d : ℕ}


theorem BookProof.HermiteQuadraticEsa.sectorQuad_essentiallySelfAdjoint (M alpha mu : ℝ) (ha0 : 0 < alpha)
    (ha2 : alpha < 1 / 2) (hm0 : 0 < mu) (hm2 : mu < 1 / 2) :
    EssentiallySelfAdjointOn (polyGaussCore (d := 2))
      (hamCore (sectorQuadW M alpha mu) (continuous_sectorQuadW M alpha mu)
        (expBounded_sectorQuadW M alpha mu)) := by sorry
