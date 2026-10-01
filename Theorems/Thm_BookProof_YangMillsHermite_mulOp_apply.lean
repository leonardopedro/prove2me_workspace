-- Generated from ChapterYangMillsHermite.lean — theorem BookProof.YangMillsHermite.mulOp_apply
import Mathlib
import Definitions.Def_ChapterYangMillsHermite
open BookProof.YangMillsHermite

variable {d : ℕ}
variable {D : Submodule ℂ (L2d d)}
variable {D : Submodule ℂ (L2d 99)}



open MeasureTheory Complex MvPolynomial
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.FriedrichsExtension BookProof.HashimotoShiftInvert

noncomputable section

variable {d : ℕ}

theorem BookProof.YangMillsHermite.mulOp_apply (f p : MvPolynomial (Fin d) ℂ) : mulOp f p = f * p := by sorry
