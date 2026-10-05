-- Generated from ChapterQgDerivativeRealization.lean — solution of BookProof.QgDerivativeRealization.jetPoint_idxE
import Mathlib
import Definitions.Def_ChapterQgDerivativeRealization
open BookProof.QgDerivativeRealization




open MvPolynomial
open BookProof.GaugeFixing
open BookProof.QuantumGravity3DGauge
open BookProof.QgPhysicalSectorIdentity

set_option maxHeartbeats 1000000 in
theorem solution (T : TetradConfig) (x : Fin 4 → ℝ) (mu a : Fin 4) :
    jetPoint T x (idxE mu a) = ((MvPolynomial.eval x (T.comp mu a) : ℝ) : ℂ) := configPoint_idxE T (jetDeriv T) x mu a
