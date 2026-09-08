-- Generated from ChapterYangMillsHermite.lean — solution of BookProof.YangMillsHermite.RealCoeff.mul
import Mathlib
import Definitions.Def_ChapterYangMillsHermite
import Theorems.Thm_BookProof_YangMillsHermite_starP_mul
open BookProof.YangMillsHermite
open BookProof.YangMillsHermite.RealCoeff








open MeasureTheory Complex MvPolynomial
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.FriedrichsExtension BookProof.HashimotoShiftInvert

noncomputable section

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {p q : MvPolynomial (Fin d) ℂ} (hp : RealCoeff p) (hq : RealCoeff q) :
    RealCoeff (p * q) := by

  change starP (p * q) = p * q
  rw [starP_mul, show starP p = p from hp, show starP q = q from hq]
