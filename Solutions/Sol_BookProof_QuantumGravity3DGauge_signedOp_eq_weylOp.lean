-- Generated from ChapterQuantumGravity3DGauge.lean — solution of BookProof.QuantumGravity3DGauge.signedOp_eq_weylOp
import Mathlib
import Definitions.Def_ChapterQuantumGravity3DGauge
import Theorems.Thm_BookProof_QuantumGravity3DGauge_signedOp_apply
import Theorems.Thm_BookProof_YangMillsFriedrichs_weylOp_apply
open BookProof.QuantumGravity3DGauge




open MeasureTheory Complex MvPolynomial Filter Topology
open BookProof.HermiteProductCore BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.HermiteGalerkin
open BookProof.HashimotoShiftInvert BookProof.QuantumGravityDensitized

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {n m : ℕ} {kappa : Fin n → ℝ} (hk : ∀ i, 0 ≤ kappa i)
    (pi : Fin n → D →ₗ[ℂ] D) (Bf : Fin m → D →ₗ[ℂ] D) :
    signedOp kappa pi Bf
      = weylOp (fun i => ((Real.sqrt (kappa i) : ℝ) : ℂ) • pi i) Bf := by

  ext x
  rw [signedOp_apply, weylOp_apply]
  congr 2
  refine Finset.sum_congr rfl fun i _ => ?_
  have hsq : (Real.sqrt (kappa i)) * (Real.sqrt (kappa i)) = kappa i :=
    Real.mul_self_sqrt (hk i)
  simp only [LinearMap.smul_apply, map_smul, Submodule.coe_smul, smul_smul]
  rw [← Complex.ofReal_mul, hsq]
