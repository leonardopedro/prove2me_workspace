-- Generated from ChapterQuantumGravity3DGauge.lean — theorem BookProof.QuantumGravity3DGauge.coreRep_commutator
import Mathlib
import Definitions.Def_ChapterQuantumGravity3DGauge
open BookProof.QuantumGravity3DGauge

variable {d : ℕ}
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}
variable {D : Submodule ℂ (L2d 84)}



open MeasureTheory Complex MvPolynomial Filter Topology
open BookProof.HermiteProductCore BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.HermiteGalerkin
open BookProof.HashimotoShiftInvert BookProof.QuantumGravityDensitized

noncomputable section

ta `√κ_j π_j`, so the Yang–Mills-style Friedrichs machinery applies to
it verbatim. -/
theorem BookProof.QuantumGravity3DGauge.coreRep_commutator {n m : ℕ} {kappa : Fin n → ℝ} (hk : ∀ i, 0 ≤ kappa i)
    (pi : Fin n → D →ₗ[ℂ] D) (Bf : Fin m → D →ₗ[ℂ] D) :
    signedOp kappa pi Bf
      = weylOp (fun i => ((Real.sqrt (kappa i) : ℝ) : ℂ) • pi i) Bf := by
  ext x
  rw [signedOp_apply, weylOp_apply]
  congr 2
  ref := by sorry
