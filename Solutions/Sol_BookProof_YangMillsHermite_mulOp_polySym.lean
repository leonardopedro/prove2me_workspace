-- Generated from ChapterYangMillsHermite.lean — solution of BookProof.YangMillsHermite.mulOp_polySym
import Mathlib
import Theorems.Thm_BookProof_YangMillsHermite_mulOp_apply
import Definitions.Def_ChapterYangMillsHermite
import Theorems.Thm_BookProof_YangMillsHermite_starP_mul
open BookProof.YangMillsHermite








open MeasureTheory Complex MvPolynomial
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.FriedrichsExtension BookProof.HashimotoShiftInvert

noncomputable section

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {f : MvPolynomial (Fin d) ℂ} (hf : RealCoeff f) : PolySym (mulOp f) := by

  intro p q
  simp only [mulOp_apply, starP_mul, show starP f = f from hf]
  congr 1
  ring
