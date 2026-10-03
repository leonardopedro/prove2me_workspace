-- Generated from ChapterHermiteQuadraticEsa.lean — theorem BookProof.HermiteQuadraticEsa.esa_of_close_to_harmonic
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

variable {d : ℕ}



open MeasureTheory Complex MvPolynomial
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgHermiteOscillator BookProof.FarisLavine BookProof.Starobinsky
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section


theorem BookProof.HermiteQuadraticEsa.esa_of_close_to_harmonic {U : Vd d → ℝ} (hUc : Continuous U) (hUb : ExpBounded U)
    {a b : ℝ} (ha : 0 ≤ a) (ha1 : a < 1) (hb : 0 ≤ b)
    (hU : ∀ x, |U x - harmW x| ≤ a * harmW x + b) :
    EssentiallySelfAdjointOn (polyGaussCore (d := by sorry
