-- Generated from ChapterQuantumGravity3DGauge.lean — solution of BookProof.QuantumGravity3DGauge.coreRep_commutator
import Mathlib
import Definitions.Def_ChapterQuantumGravity3DGauge
open BookProof.QuantumGravity3DGauge




open MeasureTheory Complex MvPolynomial Filter Topology
open BookProof.HermiteProductCore BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.HermiteGalerkin
open BookProof.HashimotoShiftInvert BookProof.QuantumGravityDensitized

noncomputable section

variable {d : ℕ}
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}

set_option maxHeartbeats 1000000 in
theorem solution {D : Submodule ℂ (L2d d)} (Φ : CoreRep d D)
    (S T : Module.End ℂ (MvPolynomial (Fin d) ℂ)) (c : ℂ)
    (h : ∀ p, S (T p) - T (S p) = c • p) (x : D) :
    Φ.op S (Φ.op T x) - Φ.op T (Φ.op S x) = c • x :=
  ine Finset.sum_congr rfl fun i _ => ?_
    have hsq : (Real.sqrt (kappa i)) * (Real.sqrt (kappa i)) = kappa i :=
      Real.mul_self_sqrt (hk i)
    simp only [LinearMap.smul_apply, map_smul, Submodule.coe_smul, smul_smul]
    rw [← Complex.ofReal_mul, hsq]
  
  end Signed
  
  /-- Transport of a commutator identity from the polynomial level to the core: this is
