-- Generated from ChapterQgDerivativeRealization.lean — solution of BookProof.QgDerivativeRealization.exists_not_fixed
import Mathlib
import Definitions.Def_ChapterQgDerivativeRealization
import Theorems.Thm_BookProof_QgDerivativeRealization_fixed_iff
open BookProof.QgDerivativeRealization




open MvPolynomial
open BookProof.GaugeFixing
open BookProof.QuantumGravity3DGauge
open BookProof.QgPhysicalSectorIdentity

set_option maxHeartbeats 1000000 in
theorem solution : ∃ (T : TetradConfig) (E : DerivFields), ¬ Fixed T E := by

  refine ⟨⟨fun _ _ => 0⟩, fun _ _ _ => 1, ?_⟩
  intro h
  have h0 := (fixed_iff _ _).1 h 0 0 0
  simp only [map_zero] at h0
  exact one_ne_zero h0
