-- Generated from ChapterEsaOneParticleDGamma.lean — solution of BookProof.EsaOneParticle.deficiencyTrivialAt_of_selfAdjoint
import Mathlib
import Definitions.Def_ChapterEsaOneParticleDGamma
import Theorems.Thm_BookProof_FriedrichsSquare_IsFriedrichsSqExtension_symmetric
open BookProof.EsaOneParticle




open scoped TensorProduct ENNReal
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable (Hs : IPSpace) (D₂ : Submodule ℂ Hs.carrier) (A₂ : D₂ →ₗ[ℂ] Hs.carrier)
  (D : Submodule ℂ Hs.carrier) (A : D →ₗ[ℂ] Hs.carrier) (hle : D ≤ D₂)
  (hext : ∀ v : D, A₂ ⟨(v : Hs.carrier), hle v.2⟩ = A v)
variable {Hs : IPSpace} {D : Submodule ℂ Hs.carrier}
variable [CompleteSpace Hs.carrier]
variable {Hs : IPSpace} [CompleteSpace Hs.carrier] {D : Submodule ℂ Hs.carrier}
  (A : D →ₗ[ℂ] Hs.carrier) (hdense : Dense (D : Set Hs.carrier)) (hsym : SymmetricOn D A)
  (hesa : EssentiallySelfAdjointOn D A)
variable {Hs : IPSpace}

set_option maxHeartbeats 1000000 in
theorem solution (T : UnboundedSelfAdjoint Hs.carrier) {z : ℂ}
    (hz : (starRingEnd ℂ) z ≠ z) : DeficiencyTrivialAt T.domain T.op z := by

  intro w hw
  have hrep : ∀ v : T.domain, (inner ℂ (T.op v) w : ℂ) = inner ℂ (v : Hs.carrier) (z • w) := by
    intro v
    rw [inner_smul_right]
    exact hw v
  have hmem : w ∈ T.domain := T.mem_domain_of_inner hrep
  have hval : T.op ⟨w, hmem⟩ = z • w := T.op_eq_of_inner hmem hrep
  have h1 := T.symmetric ⟨w, hmem⟩ ⟨w, hmem⟩
  rw [hval] at h1
  simp only [inner_smul_left, inner_smul_right] at h1
  have h2 : ((starRingEnd ℂ) z - z) * (inner ℂ w w : ℂ) = 0 := by
    rw [sub_mul, sub_eq_zero]
    exact h1
  have h3 : (inner ℂ w w : ℂ) = 0 :=
    (mul_eq_zero.mp h2).resolve_left (sub_ne_zero.mpr hz)
  exact inner_self_eq_zero.mp h3
