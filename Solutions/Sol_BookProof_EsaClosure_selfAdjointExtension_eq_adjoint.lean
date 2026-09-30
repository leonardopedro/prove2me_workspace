-- Generated from ChapterEsaClosureCore.lean — solution of BookProof.EsaClosure.selfAdjointExtension_eq_adjoint
import Mathlib
import Definitions.Def_ChapterEsaClosureCore
open BookProof.EsaClosure











open Filter Topology


open BookProof.FarisLavine BookProof.HashimotoShiftInvert

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}



























variable [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution {Dom : Submodule ℂ F} {T : D →ₗ[ℂ] F} {A : Dom →ₗ[ℂ] F}
    (hesa : EssentiallySelfAdjointOn D T) (hA : IsSelfAdjointExtension T A) (w u : F) :
    ((∀ v : D, (inner ℂ (T v) w : ℂ) = inner ℂ (v : F) u) ↔
      ∃ h : w ∈ Dom, A ⟨w, h⟩ = u) := by

  obtain ⟨hext, hsymA, hsa⟩ := hA
  constructor
  · intro hw
    obtain ⟨x, hx⟩ := cshiftMap_surjective hsymA hsa (γ := Complex.I) (by simp)
      (Complex.I • w - u)
    have hxval : Complex.I • ((x : F)) - A x = Complex.I • w - u := by
      simpa [cshiftMap_apply] using hx
    have hg : ∀ v : D, (inner ℂ (T v) (w - (x : F)) : ℂ)
        = Complex.I * inner ℂ (v : F) (w - (x : F)) := by
      intro v
      obtain ⟨hmemD, hTv⟩ := hext v
      have h1 : (inner ℂ (T v) w : ℂ) = inner ℂ (v : F) u := hw v
      have h2 : (inner ℂ (T v) ((x : F)) : ℂ) = inner ℂ (v : F) (A x) := by
        rw [← hTv]
        exact hsymA ⟨(v : F), hmemD⟩ x
      have h3 : u - A x = Complex.I • (w - (x : F)) := by
        have hAx : A x = Complex.I • ((x : F)) - (Complex.I • w - u) := by rw [← hxval]; abel
        rw [hAx, smul_sub]; abel
      calc (inner ℂ (T v) (w - (x : F)) : ℂ)
          = (inner ℂ (T v) w : ℂ) - inner ℂ (T v) ((x : F)) := by rw [inner_sub_right]
        _ = (inner ℂ (v : F) u : ℂ) - inner ℂ (v : F) (A x) := by rw [h1, h2]
        _ = (inner ℂ (v : F) (u - A x) : ℂ) := by rw [inner_sub_right]
        _ = (inner ℂ (v : F) (Complex.I • (w - (x : F))) : ℂ) := by rw [h3]
        _ = Complex.I * inner ℂ (v : F) (w - (x : F)) := by rw [inner_smul_right]
    have hwx : w = (x : F) := sub_eq_zero.mp (hesa.1 _ hg)
    have hwmem : w ∈ Dom := hwx ▸ x.2
    refine ⟨hwmem, ?_⟩
    have hxx : (⟨w, hwmem⟩ : Dom) = x := Subtype.ext hwx
    rw [hxx]
    have hAx : A x = Complex.I • ((x : F)) - (Complex.I • w - u) := by rw [← hxval]; abel
    rw [hAx, hwx]; abel
  · rintro ⟨hwmem, hAw⟩ v
    obtain ⟨hmemD, hTv⟩ := hext v
    rw [← hTv, ← hAw]
    exact hsymA ⟨(v : F), hmemD⟩ ⟨w, hwmem⟩
