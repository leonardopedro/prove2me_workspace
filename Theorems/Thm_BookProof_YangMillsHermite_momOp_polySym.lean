-- Generated from ChapterYangMillsHermite.lean — theorem BookProof.YangMillsHermite.momOp_polySym
import Mathlib
import Definitions.Def_ChapterYangMillsHermite
open BookProof.YangMillsHermite







open MeasureTheory Complex MvPolynomial
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.FriedrichsExtension BookProof.HashimotoShiftInvert

noncomputable section

variable {d : ℕ}

theorem BookProof.YangMillsHermite.momOp_polySym (j : Fin d) : PolySym (momOp (d := d) j) := by sorry
