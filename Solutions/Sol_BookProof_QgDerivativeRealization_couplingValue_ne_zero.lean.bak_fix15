-- Generated from ChapterQgDerivativeRealization.lean — solution of BookProof.QgDerivativeRealization.couplingValue_ne_zero
import Mathlib
import Definitions.Def_ChapterQgDerivativeRealization
open BookProof.QgDerivativeRealization




open MvPolynomial
open BookProof.GaugeFixing
open BookProof.QuantumGravity3DGauge
open BookProof.QgPhysicalSectorIdentity

set_option maxHeartbeats 1000000 in
theorem solution :
    ∃ (T : TetradConfig) (x : Fin 4 → ℝ), couplingValue T x ≠ 0 := by

  classical
  refine ⟨⟨fun nu _ => if nu = 0 then X 1 else 0⟩, fun i => if i = 1 then 1 else 0, ?_⟩
  simp only [couplingValue, Fin.sum_univ_four]
  norm_num [pderiv_X, Pi.single_apply, Fin.ext_iff]
