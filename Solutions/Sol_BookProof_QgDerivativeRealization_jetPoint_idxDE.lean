-- Generated from ChapterQgDerivativeRealization.lean — solution of BookProof.QgDerivativeRealization.jetPoint_idxDE
import Mathlib
import Definitions.Def_ChapterQgDerivativeRealization
open BookProof.QgDerivativeRealization




open MvPolynomial
open BookProof.GaugeFixing
open BookProof.QuantumGravity3DGauge
open BookProof.QgPhysicalSectorIdentity

set_option maxHeartbeats 1000000 in
theorem solution (T : TetradConfig) (x : Fin 4 → ℝ) (mu nu a : Fin 4) :
    jetPoint T x (idxDE mu nu a)
      = ((MvPolynomial.eval x (pderiv mu (T.comp nu a)) : ℝ) : ℂ) := configPoint_idxDE T (jetDeriv T) x mu nu a
