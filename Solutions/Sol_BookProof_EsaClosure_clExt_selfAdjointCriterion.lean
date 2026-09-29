-- Generated from ChapterEsaClosureCore.lean — solution of BookProof.EsaClosure.clExt_selfAdjointCriterion
import Mathlib
import Definitions.Def_ChapterEsaClosureCore
import Theorems.Thm_BookProof_EsaClosure_coe_mem_clDom
import Theorems.Thm_BookProof_EsaClosure_clExt_extends
import Theorems.Thm_BookProof_EsaClosure_clExt_symmetricOn
import Theorems.Thm_BookProof_EsaClosure_clShift_surjective
open BookProof.EsaClosure











open Filter Topology


open BookProof.FarisLavine BookProof.HashimotoShiftInvert

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}



























variable [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution (T : D →ₗ[ℂ] F) (hdense : Dense (D : Set F))
    (hsym : SymmetricOn D T) (hesa : EssentiallySelfAdjointOn D T) (w u : F)
    (hw : ∀ v : clDom T, (inner ℂ (clExt T hdense hsym v) w : ℂ) = inner ℂ (v : F) u) :
    ∃ h : w ∈ clDom T, clExt T hdense hsym ⟨w, h⟩ = u := by

  set A := clExt T hdense hsym with hAdef
  obtain ⟨x, hx⟩ := clShift_surjective T hdense hsym hesa (Complex.I • w - u)
  have hxval : Complex.I • ((x : F)) - A x = Complex.I • w - u := by
    simpa [cshiftMap_apply] using hx
  -- `g = w - x` is a deficiency vector of `T` at `i`
  have hg : ∀ v : D, (inner ℂ (T v) (w - (x : F)) : ℂ)
      = Complex.I * inner ℂ (v : F) (w - (x : F)) := by
    intro v
    have hmemD : (v : F) ∈ clDom T := coe_mem_clDom T v
    have hTv : A ⟨(v : F), hmemD⟩ = T v := clExt_extends T hdense hsym v
    have h1 : (inner ℂ (A ⟨(v : F), hmemD⟩) w : ℂ) = inner ℂ (v : F) u := hw ⟨(v : F), hmemD⟩
    have h2 : (inner ℂ (A ⟨(v : F), hmemD⟩) ((x : F)) : ℂ) = inner ℂ (v : F) (A x) :=
      clExt_symmetricOn T hdense hsym ⟨(v : F), hmemD⟩ x
    have h3 : u - A x = Complex.I • (w - (x : F)) := by
      have : A x = Complex.I • ((x : F)) - (Complex.I • w - u) := by
        rw [← hxval]; abel
      rw [this, smul_sub]
      abel
    calc (inner ℂ (T v) (w - (x : F)) : ℂ)
        = (inner ℂ (A ⟨(v : F), hmemD⟩) w : ℂ) - inner ℂ (A ⟨(v : F), hmemD⟩) ((x : F)) := by
          rw [← hTv, inner_sub_right]
      _ = (inner ℂ (v : F) u : ℂ) - inner ℂ (v : F) (A x) := by rw [h1, h2]
      _ = (inner ℂ (v : F) (u - A x) : ℂ) := by rw [inner_sub_right]
      _ = (inner ℂ (v : F) (Complex.I • (w - (x : F))) : ℂ) := by rw [h3]
      _ = Complex.I * inner ℂ (v : F) (w - (x : F)) := by rw [inner_smul_right]
  have hzero : w - (x : F) = 0 := hesa.1 _ hg
  have hwx : w = (x : F) := by
    have := sub_eq_zero.mp hzero
    exact this
  have hwmem : w ∈ clDom T := hwx ▸ x.2
  refine ⟨hwmem, ?_⟩
  have hxx : (⟨w, hwmem⟩ : clDom T) = x := Subtype.ext hwx
  rw [hxx]
  have : A x = Complex.I • ((x : F)) - (Complex.I • w - u) := by rw [← hxval]; abel
  rw [this, hwx]
  abel
