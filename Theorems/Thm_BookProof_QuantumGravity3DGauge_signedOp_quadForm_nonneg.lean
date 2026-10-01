-- Generated from ChapterQuantumGravity3DGauge.lean — theorem BookProof.QuantumGravity3DGauge.signedOp_quadForm_nonneg
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

(∑ i, kappa i * ‖((pi i x : D) : F)‖ ^ 2)
          + 1 / 2 * ∑ a, ‖((Bf a x : D) : F)‖ ^ 2 : ℝ)) : ℂ) := by
    have hpi' : ∀ i : Fin n,
        (inner ℂ ((x : D) : F) (((kappa i : ℝ) : ℂ) • ((pi i (pi i x) : D) : F)) : ℂ)
          = ((kappa i * ‖((pi i x : D) : F)‖ ^ 2 : ℝ) : ℂ) := by
      intro i
      rw [inner_smul_right, inner_sq_eq_normSq (hpi i) x]
      push_cast
      ring
    rw [signedOp_apply, inner_smul_right, inner_add_right, inner_sum, inner_sum,
      Finset.sum_congr rfl fun i _ => hpi' i, := by sorry
