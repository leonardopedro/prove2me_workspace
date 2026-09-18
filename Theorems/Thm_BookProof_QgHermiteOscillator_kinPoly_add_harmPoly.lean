-- Generated from ChapterQgHermiteOscillatorEsa.lean — theorem BookProof.QgHermiteOscillator.kinPoly_add_harmPoly
import Mathlib
import Definitions.Def_ChapterQgHermiteOscillatorEsa
open BookProof.QgHermiteOscillator



open MeasureTheory Complex MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs BookProof.FarisLavine
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

theorem BookProof.QgHermiteOscillator.kinPoly_add_harmPoly (p : MvPolynomial (Fin d) ℂ) :
    kinPoly p + harmPoly * p
      = (∑ j : Fin d, crePoly j (annPoly j p)) + C ((d : ℂ) / 2) * p := by sorry
