-- Generated from ChapterUnitaryTransport.lean — solution of BookProof.ChapterUnitaryTransport.tendsto_slope_transportUnitary
import Mathlib
import Definitions.Def_ChapterUnitaryTransport
import Theorems.Thm_BookProof_ChapterUnitaryTransport_map_real_smul
import Theorems.Thm_BookProof_ChapterUnitaryTransport_transportEquiv_coe
import Theorems.Thm_BookProof_ChapterUnitaryTransport_transportOp_apply
import Theorems.Thm_BookProof_ChapterUnitaryTransport_transportUnitary_apply
open BookProof.ChapterUnitaryTransport



open scoped InnerProductSpace


variable {H K : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
  [NormedAddCommGroup K] [InnerProductSpace ℂ K]

set_option maxHeartbeats 1000000 in
ymm_apply] at h1
  exact h1

theorem solution (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H) (A : D →ₗ[ℂ] H)
    (U : ℝ → H ≃ₗᵢ[ℂ] H)
    (h : ∀ x : D, Filter.Tendsto (fun t : ℝ => (t⁻¹ : ℝ) • (U t (x : H) - (x : H)))
      (nhdsWithin 0 {0}ᶜ) (nhds (Complex.I • A x)))
    (y : transportDomain W D) :
    Filter.Tendsto (fun t : ℝ => (t⁻¹ : ℝ) • (transportUnitary W (U t) (y : K) - (y : K)))
      (nhdsWithin 0 {0}ᶜ) (nhds (Complex :=
  .I • transportOp W D A y)) := by
    obtain ⟨a, rfl⟩ := (transportEquiv W D).surjective y
    rw [transportOp_apply]
    have hW := (W.continuous.tendsto (Complex.I • A a)).comp (h a)
    have hlim : Filter.Tendsto
        (fun t : ℝ => W ((t⁻¹ : ℝ) • (U t (a : H) - (a : H))))
        (nhdsWithin 0 {0}ᶜ) (nhds (W (Complex.I • A a))) := by
      exact hW
    rw [map_smul] at hlim
    refine hlim.congr fun t => ?_
    rw [map_real_smul, map_sub, transportUnitary_apply, transportEquiv_coe,
      LinearIsometryEquiv.symm_apply
