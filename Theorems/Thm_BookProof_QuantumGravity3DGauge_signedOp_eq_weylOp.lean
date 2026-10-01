-- Generated from ChapterQuantumGravity3DGauge.lean — theorem BookProof.QuantumGravity3DGauge.signedOp_eq_weylOp
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

ve h1 : 0 ≤ ∑ i, kappa i * ‖((pi i x : D) : F)‖ ^ 2 :=
    Finset.sum_nonneg fun i _ => mul_nonneg (hk i) (by positivity)
  have h2 : 0 ≤ ∑ a, ‖((Bf a x : D) : F)‖ ^ 2 := Finset.sum_nonneg fun a _ => by positivity
  linarith

theorem BookProof.QuantumGravity3DGauge.signedOp_eq_weylOp {T : D →ₗ[ℂ] D} (r : ℝ)
    (hT : SymmetricOn D (D.subtype.comp T)) :
    SymmetricOn D (D.subtype.comp (((r : ℝ) : ℂ) • := by sorry
