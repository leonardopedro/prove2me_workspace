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

variable {d : ℕ}
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}

set_option maxHeartbeats 1000000 in
ve h1 : 0 ≤ ∑ i, kappa i * ‖((pi i x : D) : F)‖ ^ 2 :=
    Finset.sum_nonneg fun i _ => mul_nonneg (hk i) (by positivity)
  have h2 : 0 ≤ ∑ a, ‖((Bf a x : D) : F)‖ ^ 2 := Finset.sum_nonneg fun a _ => by positivity
  linarith

theorem solution {T : D →ₗ[ℂ] D} (r : ℝ)
    (hT : SymmetricOn D (D.subtype.comp T)) :
    SymmetricOn D (D.subtype.comp (((r : ℝ) : ℂ) • :=
   T)) := by
    intro x y
    have h := hT x y
    simp only [LinearMap.comp_apply, Submodule.subtype_apply, LinearMap.smul_apply,
      Submodule.coe_smul] at h ⊢
    rw [inner_smul_left, inner_smul_right, h, Complex.conj_ofReal]
  
  /-- In the elliptic sector the two-signed operator **is** the positive sum of squares of
  the
