-- Generated from ChapterHermiteQuadraticEsa.lean — theorem BookProof.HermiteQuadraticEsa.sectorHarmonicApprox_essentiallySelfAdjoint
import Mathlib
import Definitions.Def_ChapterHermiteQuadraticEsa
open BookProof.HermiteQuadraticEsa














open MeasureTheory Complex MvPolynomial
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgHermiteOscillator BookProof.FarisLavine BookProof.Starobinsky
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

variable {d : ℕ}

theorem BookProof.HermiteQuadraticEsa.sectorHarmonicApprox_essentiallySelfAdjoint (M alpha : ℝ) (hM : M ≠ 0)
    (ha0 : 0 < alpha) (ha2 : alpha < 1 / 2) (hMa : M ^ 2 < 12 * alpha) :
    EssentiallySelfAdjointOn (polyGaussCore (d := 2))
      (hamCore (sectorQuadW M alpha (M ^ 2 / (24 * alpha)))
        (continuous_sectorQuadW M alpha (M ^ 2 / (24 * alpha)))
        (expBounded_sectorQuadW M alpha (M ^ 2 / (24 * alpha)))) := by sorry
