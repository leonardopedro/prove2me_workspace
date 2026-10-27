-- Generated from ChapterEsaOneParticleDGamma.lean — solution of BookProof.EsaOneParticle.exists_pow_of_mem_corePow
import Mathlib
import Definitions.Def_ChapterEsaOneParticleDGamma
open BookProof.EsaOneParticle




open scoped TensorProduct ENNReal
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable (Hs : IPSpace) (D₂ : Submodule ℂ Hs.carrier) (A₂ : D₂ →ₗ[ℂ] Hs.carrier)
  (D : Submodule ℂ Hs.carrier) (A : D →ₗ[ℂ] Hs.carrier) (hle : D ≤ D₂)
  (hext : ∀ v : D, A₂ ⟨(v : Hs.carrier), hle v.2⟩ = A v)

set_option maxHeartbeats 1000000 in
theorem solution :
    ∀ (n : ℕ) (y : ((domSpace Hs D₂).pow n)), y ∈ corePow Hs D₂ D n →
      ∃ y' : ((domSpace Hs D).pow n),
        inclPow Hs D n y' = inclPow Hs D₂ n y ∧
          derPow Hs D A n y' = derPow Hs D₂ A₂ n y := by

  intro n
  induction n with
  | zero => exact fun y _ => ⟨y, rfl, rfl⟩
  | succ n ih =>
      intro y hy
      induction hy using Submodule.span_induction with
      | mem t ht =>
          obtain ⟨a, haD, b, hb, rfl⟩ := ht
          obtain ⟨b', hb1, hb2⟩ := ih b hb
          refine ⟨(⟨(a : Hs.carrier), haD⟩ : D) ⊗ₜ[ℂ] b', ?_, ?_⟩
          · rw [inclPow_tmul, inclPow_tmul, hb1]
          · have ha : A₂ a = A ⟨(a : Hs.carrier), haD⟩ := by
              simpa using hext ⟨(a : Hs.carrier), haD⟩
            rw [derPow_tmul, derPow_tmul, hb1, hb2, ha]
      | zero => exact ⟨0, by simp, by simp⟩
      | add x y hx hy hx' hy' =>
          obtain ⟨x', hx1, hx2⟩ := hx'
          obtain ⟨y', hy1, hy2⟩ := hy'
          exact ⟨x' + y', by rw [map_add, map_add, hx1, hy1], by rw [map_add, map_add, hx2, hy2]⟩
      | smul c x hx hx' =>
          obtain ⟨x', hx1, hx2⟩ := hx'
          exact ⟨c • x', by rw [map_smul, map_smul, hx1], by rw [map_smul, map_smul, hx2]⟩
