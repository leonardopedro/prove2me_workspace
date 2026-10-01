-- Generated from ChapterQuantumGravity3DGauge.lean — theorem BookProof.QuantumGravity3DGauge.signedOp_quadForm
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

r_add_left,
    inner_add_right, sum_inner, sum_inner, inner_sum, inner_sum]
  have hpisum : ∀ i : Fin n,
      (inner ℂ (((kappa i : ℝ) : ℂ) • ((pi i (pi i x) : D) : F)) ((y : D) : F) : ℂ)
        = inner ℂ ((x : D) : F) (((kappa i : ℝ) : ℂ) • ((pi i (pi i y) : D) : F)) := by
    intro i
    rw [inner_smul_left, inner_smul_right, hsq (pi i) (hpi i), Complex.conj_ofReal]
  have hBsum : ∀ a : Fin m, (inner ℂ ((Bf a (Bf a x) : D) : F) ((y : D) : F) : ℂ)
      = inner ℂ ((x : D) : F) ((Bf a (Bf a y) : D) : F) := fun a => hsq := by sorry
