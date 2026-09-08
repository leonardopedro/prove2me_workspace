-- Generated from ChapterHermiteQuadraticEsa.lean — theorem BookProof.HermiteQuadraticEsa.hamCore_congr
import Mathlib
import Definitions.Def_ChapterHermiteQuadraticEsa
open BookProof.HermiteQuadraticEsa














open MeasureTheory Complex MvPolynomial
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgHermiteOscillator BookProof.FarisLavine BookProof.Starobinsky
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

variable {d : ℕ}

theorem BookProof.HermiteQuadraticEsa.hamCore_congr {U U' : Vd d → ℝ} (h : U = U') (hUc : Continuous U) (hUb : ExpBounded U)
    (hU'c : Continuous U') (hU'b : ExpBounded U') :
    hamCore U hUc hUb = hamCore U' hU'c hU'b := by sorry
