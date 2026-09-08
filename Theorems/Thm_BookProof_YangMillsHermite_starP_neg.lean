-- Generated from ChapterYangMillsHermite.lean — theorem BookProof.YangMillsHermite.starP_neg
import Mathlib
import Definitions.Def_ChapterYangMillsHermite
open BookProof.YangMillsHermite







open MeasureTheory Complex MvPolynomial
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.FriedrichsExtension BookProof.HashimotoShiftInvert

noncomputable section

variable {d : ℕ}

theorem BookProof.YangMillsHermite.starP_neg (p : MvPolynomial (Fin d) ℂ) : starP (-p) = -starP p := by sorry
