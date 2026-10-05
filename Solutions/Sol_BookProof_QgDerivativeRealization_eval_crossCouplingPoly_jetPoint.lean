-- Generated from ChapterQgDerivativeRealization.lean — solution of BookProof.QgDerivativeRealization.eval_crossCouplingPoly_jetPoint
import Mathlib
import Definitions.Def_ChapterQgDerivativeRealization
import Theorems.Thm_BookProof_QgDerivativeRealization_jetPoint_idxE
import Theorems.Thm_BookProof_QgDerivativeRealization_eval_torsionPoly_jetPoint
open BookProof.QgDerivativeRealization




open MvPolynomial
open BookProof.GaugeFixing
open BookProof.QuantumGravity3DGauge
open BookProof.QgPhysicalSectorIdentity

set_option maxHeartbeats 1000000 in
theorem solution (T : TetradConfig) (x : Fin 4 → ℝ) :
    MvPolynomial.eval (jetPoint T x) crossCouplingPoly = couplingValue T x := by

  simp only [crossCouplingPoly, couplingValue, map_sum, map_mul, eval_C, eval_X,
    eval_torsionPoly_jetPoint, jetPoint_idxE]
