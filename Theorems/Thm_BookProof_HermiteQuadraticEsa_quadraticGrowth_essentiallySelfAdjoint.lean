-- Generated from ChapterHermiteQuadraticEsa.lean — theorem BookProof.HermiteQuadraticEsa.quadraticGrowth_essentiallySelfAdjoint
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterStarobinskyPotential
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterSirkTrotterKato
import Mathlib
import Definitions.Def_ChapterHermiteQuadraticEsa
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterQgHermiteFriedrichs
import Definitions.Def_ChapterQgHermiteOscillatorEsa
open BookProof.HermiteProductCore
open BookProof.QgHermiteCore
open BookProof.QgHermiteFriedrichs
open BookProof.QgHermiteOscillator
open BookProof.HermiteQuadraticEsa



open MeasureTheory Complex MvPolynomial
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgHermiteOscillator BookProof.FarisLavine BookProof.Starobinsky
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

variable {d : ℕ}


theorem BookProof.HermiteQuadraticEsa.quadraticGrowth_essentiallySelfAdjoint {U : Vd d → ℝ} (hUc : Continuous U)
    (hUb : ExpBounded U) {A Ccoef B : ℝ} (hA : 0 ≤ A) (hA1 : 4 * A < 1)
    (hB : 0 ≤ B) (hU : ∀ x, |U x - harmW x| ≤ A * ‖x‖ ^ 2 + Ccoef * ‖x‖ + B) :
    EssentiallySelfAdjointOn (polyGaussCore (d := d)) (hamCore U hUc hUb) := by sorry
