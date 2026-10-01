-- Generated from ChapterYangMillsHermite.lean — theorem BookProof.YangMillsHermite.RealCoeff.mul
import Mathlib
import Definitions.Def_ChapterYangMillsHermite
open BookProof.YangMillsHermite
open BookProof.YangMillsHermite.RealCoeff

variable {d : ℕ}
variable {D : Submodule ℂ (L2d d)}
variable {D : Submodule ℂ (L2d 99)}



open MeasureTheory Complex MvPolynomial
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.FriedrichsExtension BookProof.HashimotoShiftInvert

noncomputable section

variable {d : ℕ}

theorem BookProof.YangMillsHermite.RealCoeff.mul {p q : MvPolynomial (Fin d) ℂ} (hp : RealCoeff p) (hq : RealCoeff q) :
    RealCoeff (p * q) := by sorry
