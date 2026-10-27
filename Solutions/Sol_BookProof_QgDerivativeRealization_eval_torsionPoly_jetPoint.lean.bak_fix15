-- Generated from ChapterQgDerivativeRealization.lean — solution of BookProof.QgDerivativeRealization.eval_torsionPoly_jetPoint
import Mathlib
import Definitions.Def_ChapterQgDerivativeRealization
import Theorems.Thm_BookProof_QgDerivativeRealization_jetPoint_idxDE
open BookProof.QgDerivativeRealization




open MvPolynomial
open BookProof.GaugeFixing
open BookProof.QuantumGravity3DGauge
open BookProof.QgPhysicalSectorIdentity

set_option maxHeartbeats 1000000 in
theorem solution (T : TetradConfig) (x : Fin 4 → ℝ) (mu nu a : Fin 4) :
    MvPolynomial.eval (jetPoint T x) (torsionPoly mu nu a)
      = ((MvPolynomial.eval x (pderiv mu (T.comp nu a)) : ℝ) : ℂ)
        - ((MvPolynomial.eval x (pderiv nu (T.comp mu a)) : ℝ) : ℂ) := by

  simp [torsionPoly, jetPoint_idxDE]
