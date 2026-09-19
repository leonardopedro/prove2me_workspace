-- Generated from ChapterQuantumGravity3DGauge.lean — solution of BookProof.QuantumGravity3DGauge.signedOp_apply
import Mathlib
import Definitions.Def_ChapterQuantumGravity3DGauge
open BookProof.QuantumGravity3DGauge




open MeasureTheory Complex MvPolynomial Filter Topology
open BookProof.HermiteProductCore BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.HermiteGalerkin
open BookProof.HashimotoShiftInvert BookProof.QuantumGravityDensitized

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {n m : ℕ} (kappa : Fin n → ℝ) (pi : Fin n → D →ₗ[ℂ] D)
    (Bf : Fin m → D →ₗ[ℂ] D) (x : D) :
    signedOp kappa pi Bf x
      = ((1 / 2 : ℝ) : ℂ)
        • ((∑ i, ((kappa i : ℝ) : ℂ) • ((pi i (pi i x) : D) : F))
            + ∑ a, ((Bf a (Bf a x) : D) : F)) := by

  simp [signedOp, signedOpDom]
