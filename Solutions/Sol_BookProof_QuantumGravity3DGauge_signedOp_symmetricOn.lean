-- Generated from ChapterQuantumGravity3DGauge.lean — solution of BookProof.QuantumGravity3DGauge.signedOp_symmetricOn
import Mathlib
import Definitions.Def_ChapterQuantumGravity3DGauge
import Theorems.Thm_BookProof_QuantumGravity3DGauge_signedOp_apply
open BookProof.QuantumGravity3DGauge




open MeasureTheory Complex MvPolynomial Filter Topology
open BookProof.HermiteProductCore BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.HermiteGalerkin
open BookProof.HashimotoShiftInvert BookProof.QuantumGravityDensitized

noncomputable section

variable {d : ℕ}
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}

set_option maxHeartbeats 1000000 in
theorem solution {n m : ℕ} {kappa : Fin n → ℝ} {pi : Fin n → D →ₗ[ℂ] D}
    {Bf : Fin m → D →ₗ[ℂ] D} (hpi : ∀ i, SymmetricOn D (D.subtype.comp (pi i)))
    (hB : ∀ a, SymmetricOn D (D.subtype.comp (Bf a))) :
    SymmetricOn D (signedOp kappa pi Bf) :=
  → ℝ) (pi : Fin n → D →ₗ[ℂ] D)
      (Bf : Fin m → D →ₗ[ℂ] D) (x : D) :
      signedOp kappa pi Bf x
        = ((1 / 2 : ℝ) : ℂ)
          • ((∑ i, ((kappa i : ℝ) : ℂ) • ((pi i (pi i x) : D) : F))
              + ∑ a, ((Bf a (Bf a x) : D) : F)) := by
    simp [signedOp, signedOpDom]
  
  /-- **The two-signed Hamiltonian is symmetric on its domain**, for every real signature. -/
  theorem signedOp_symmetricOn {n m : ℕ} {kappa : Fin n → ℝ} {pi : Fin n → D →ₗ[ℂ] D}
      {Bf : Fin m → D →ₗ[ℂ] D} (hpi : ∀ i, SymmetricOn D (D.subtype.comp (pi i)))
      (hB : ∀ a, SymmetricOn D (D.subtype.comp (Bf a))) :
      SymmetricOn D (signedOp kappa pi Bf) := by
    intro x y
    have hsq : ∀ (T : D →ₗ[ℂ] D), SymmetricOn D (D.subtype.comp T) →
        (inner ℂ ((T (T x) : D) : F) ((y : D) : F) : ℂ)
          = inner ℂ ((x : D) : F) ((T (T y) : D) : F) := by
      intro T hT
      have h1 := hT (T x) y
      have h2 := hT x (T y)
      simp only [LinearMap.comp_apply, Submodule.subtype_apply] at h1 h2
      rw [h1, h2]
    rw [signedOp_apply, signedOp_apply, inner_smul_left, inner_smul_right, in
