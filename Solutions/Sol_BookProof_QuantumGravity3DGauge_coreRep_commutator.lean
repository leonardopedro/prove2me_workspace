-- Generated from ChapterQuantumGravity3DGauge.lean — solution of BookProof.QuantumGravity3DGauge.coreRep_commutator
import Mathlib
import Definitions.Def_ChapterQuantumGravity3DGauge
open BookProof.QuantumGravity3DGauge




open MeasureTheory Complex MvPolynomial Filter Topology
open BookProof.HermiteProductCore BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.HermiteGalerkin
open BookProof.HashimotoShiftInvert BookProof.QuantumGravityDensitized

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {D : Submodule ℂ (L2d d)} (Φ : CoreRep d D)
    (S T : Module.End ℂ (MvPolynomial (Fin d) ℂ)) (c : ℂ)
    (h : ∀ p, S (T p) - T (S p) = c • p) (x : D) :
    Φ.op S (Φ.op T x) - Φ.op T (Φ.op S x) = c • x := by

  have e1 : Φ.op S (Φ.op T x) = Φ.equiv (S (T (Φ.equiv.symm x))) := by
    simp only [CoreRep.op_apply, LinearEquiv.symm_apply_apply]
  have e2 : Φ.op T (Φ.op S x) = Φ.equiv (T (S (Φ.equiv.symm x))) := by
    simp only [CoreRep.op_apply, LinearEquiv.symm_apply_apply]
  rw [e1, e2, ← map_sub, h, map_smul, LinearEquiv.apply_symm_apply]
