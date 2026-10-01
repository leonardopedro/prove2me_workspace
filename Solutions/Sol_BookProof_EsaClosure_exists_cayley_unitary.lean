-- Generated from ChapterEsaClosureCore.lean — solution of BookProof.EsaClosure.exists_cayley_unitary
import Mathlib
import Definitions.Def_ChapterEsaClosureCore
import Theorems.Thm_BookProof_EsaClosure_norm_add_I_eq_norm_sub_I
import Theorems.Thm_BookProof_HashimotoShiftInvert_cshiftMap_injective
import Theorems.Thm_BookProof_HashimotoShiftInvert_cshiftMap_surjective
open BookProof.EsaClosure



open Filter Topology


open BookProof.FarisLavine BookProof.HashimotoShiftInvert

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}

set_option maxHeartbeats 1000000 in
eg (A x - Complex.I • (x : F))]

theorem solution {A : Dom →ₗ[ℂ] F} (hsym : SymmetricOn Dom A)
    (hsa : ∀ w u : F, (∀ v : Dom, (inner ℂ (A v) w : ℂ) = inner ℂ (v : F) u) →
      ∃ h : w ∈ Dom, A ⟨w, h⟩ = u) :
    ∃ U : F ≃ₗᵢ[ℂ] F, ∀ x : Dom, U (A x + Complex.I • (x : :=
   F)) = A x - Complex.I • (x : F) := by
    classical
    set p : Dom →ₗ[ℂ] F := -cshiftMap A (-Complex.I) with hp
    set m : Dom →ₗ[ℂ] F := -cshiftMap A Complex.I with hm
    have hpx : ∀ x : Dom, p x = A x + Complex.I • (x : F) := by
      intro x
      simp only [hp, LinearMap.neg_apply, cshiftMap_apply, neg_sub, neg_smul]
      abel
    have hmx : ∀ x : Dom, m x = A x - Complex.I • (x : F) := by
      intro x
      simp only [hm, LinearMap.neg_apply, cshiftMap_apply, neg_sub]
    have hpinj : Function.Injective p := by
      intro x y hxy
      have h : -(cshiftMap A (-Complex.I) x) = -(cshiftMap A (-Complex.I) y) := by
        simpa [hp] using hxy
      exact cshiftMap_injective hsym (by simp) (neg_injective h)
    have hpsurj : Function.Surjective p := by
      intro u
      obtain ⟨x, hx⟩ := cshiftMap_surjective hsym hsa (γ := -Complex.I) (by simp) (-u)
      exact ⟨x, by simp [hp, hx]⟩
    have hminj : Function.Injective m := by
      intro x y hxy
      have h : -(cshiftMap A Complex.I x) = -(cshiftMap A Complex.I y) := by simpa [hm] using hxy
      exact cshiftMap_injective hsym (by simp) (neg_injective h)
    have hmsurj : Function.Surjective m := by
      intro u
      obtain ⟨x, hx⟩ := cshiftMap_surjective hsym hsa (γ := Complex.I) (by simp) (-u)
      exact ⟨x, by simp [hm, hx]⟩
    let ep : Dom ≃ₗ[ℂ] F := LinearEquiv.ofBijective p ⟨hpinj, hpsurj⟩
    let em : Dom ≃ₗ[ℂ] F := LinearEquiv.ofBijective m ⟨hminj, hmsurj⟩
    have hnorm : ∀ u : F, ‖(ep.symm.trans em) u‖ = ‖u‖ := by
      intro u
      have hu : u = p (ep.symm u) := (ep.apply_symm_apply u).symm
      calc ‖(ep.symm.trans em) u‖ = ‖m (ep.symm u)‖ := rfl
        _ = ‖A (ep.symm u) - Complex.I • ((ep.symm u : Dom) : F)‖ := by rw [hmx]
        _ = ‖A (ep.symm u) + Complex.I • ((ep.symm u : Dom) : F)‖ :=
              (norm_add_I_eq_norm_sub_I hsym _).symm
        _ = ‖p (ep.symm u)‖ := by rw [hpx]
        _ = ‖u‖ := by rw [← hu]
    refine ⟨{ toLinearEquiv := ep.symm.trans em, norm_map' := hnorm }, fun x => ?_⟩
    have hx : ep.symm (A x + Complex.I • (x : F)) = x := by
      have hpe : ep x = A x + Complex.I • (x : F) := hpx x
      rw [← hpe, ep.symm_apply_apply]
    change em (ep.symm (A x + Complex.I • (x
