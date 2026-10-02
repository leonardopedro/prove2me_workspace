-- Generated from ChapterQuantumGravity3DGauge.lean — solution of BookProof.QuantumGravity3DGauge.signedOp_quadForm
import Mathlib
import Definitions.Def_ChapterQuantumGravity3DGauge
import Theorems.Thm_BookProof_QuantumGravity3DGauge_signedOp_apply
import Theorems.Thm_BookProof_YangMillsFriedrichs_inner_sq_eq_normSq
open BookProof.QuantumGravity3DGauge




open MeasureTheory Complex MvPolynomial Filter Topology
open BookProof.HermiteProductCore BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.HermiteGalerkin
open BookProof.HashimotoShiftInvert BookProof.QuantumGravityDensitized

noncomputable section

variable {d : ℕ}
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}

set_option maxHeartbeats 1000000 in
r_add_left,
    inner_add_right, sum_inner, sum_inner, inner_sum, inner_sum]
  have hpisum : ∀ i : Fin n,
      (inner ℂ (((kappa i : ℝ) : ℂ) • ((pi i (pi i x) : D) : F)) ((y : D) : F) : ℂ)
        = inner ℂ ((x : D) : F) (((kappa i : ℝ) : ℂ) • ((pi i (pi i y) : D) : F)) := by
    intro i
    rw [inner_smul_left, inner_smul_right, hsq (pi i) (hpi i), Complex.conj_ofReal]
  have hBsum : ∀ a : Fin m, (inner ℂ ((Bf a (Bf a x) : D) : F) ((y : D) : F) : ℂ)
      = inner ℂ ((x : D) : F) ((Bf a (Bf a y) : D) : F) := fun a => hsq :=
   (Bf a) (hB a)
    rw [Finset.sum_congr rfl fun i _ => hpisum i, Finset.sum_congr rfl fun a _ => hBsum a,
      Complex.conj_ofReal]
  
  /-- **The quadratic form of the two-signed Hamiltonian is the signed sum of squares**:
  `q(x) = ½ Σ κ_j ‖π_j x‖² + ½ Σ ‖V_A x‖²`. -/
  theorem signedOp_quadForm {n m : ℕ} {kappa : Fin n → ℝ} {pi : Fin n → D →ₗ[ℂ] D}
      {Bf : Fin m → D →ₗ[ℂ] D} (hpi : ∀ i, SymmetricOn D (D.subtype.comp (pi i)))
      (hB : ∀ a, SymmetricOn D (D.subtype.comp (Bf a))) (x : D) :
      quadForm (signedOp kappa pi Bf) x
        = 1 / 2 * (∑ i, kappa i * ‖((pi i x : D) : F)‖ ^ 2)
          + 1 / 2 * ∑ a, ‖((Bf a x : D) : F)‖ ^ 2 := by
    have hinner : (inner ℂ ((x : D) : F) (signedOp kappa pi Bf x) : ℂ)
        = (((1 / 2
