-- Generated from ChapterSirkGramWhitening.lean — solution of BookProof.ChapterSirkGramWhitening.exists_isWhitening
import Mathlib
import Definitions.Def_ChapterSirkGramWhitening
import Theorems.Thm_BookProof_ChapterSirkGramWhitening_synthesis_mem_span
import Theorems.Thm_BookProof_ChapterSirkGramWhitening_synthesis_injective_of_linearIndependent
import Theorems.Thm_BookProof_ChapterSirkGramWhitening_exists_isometry_fin_range_eq_span
open BookProof.ChapterSirkGramWhitening









noncomputable section


open scoped InnerProductSpace
open Matrix
open BookProof.ChapterH4 BookProof.ChapterSirkWhitening

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

set_option maxHeartbeats 1000000 in
theorem solution {m : ℕ} {w : Fin m → E} (hw : LinearIndependent ℂ w) :
    ∃ T : EuclideanSpace ℂ (Fin m) →L[ℂ] EuclideanSpace ℂ (Fin m),
      Function.Bijective T ∧ IsWhitening w T := by

  obtain ⟨V, hV, hrange⟩ := exists_isometry_fin_range_eq_span hw
  have hinj : Function.Injective (synthesis w) := synthesis_injective_of_linearIndependent hw
  set A : EuclideanSpace ℂ (Fin m) →L[ℂ] EuclideanSpace ℂ (Fin m) :=
    (ContinuousLinearMap.adjoint V).comp (synthesis w) with hA
  have hVadj : ∀ z, ContinuousLinearMap.adjoint V (V z) = z := fun z =>
    congrArg (fun f : EuclideanSpace ℂ (Fin m) →L[ℂ] EuclideanSpace ℂ (Fin m) => f z) hV
  have hproj : ∀ c, V (ContinuousLinearMap.adjoint V (synthesis w c)) = synthesis w c := by
    intro c
    have hmem : synthesis w c ∈ LinearMap.range (V : EuclideanSpace ℂ (Fin m) →ₗ[ℂ] E) := by
      rw [hrange]; exact synthesis_mem_span w c
    obtain ⟨z, hz⟩ := hmem
    simp only [ContinuousLinearMap.coe_coe] at hz
    rw [← hz, hVadj z]
  have hAA : (ContinuousLinearMap.adjoint A).comp A = gramOp w := by
    ext c
    simp only [hA, ContinuousLinearMap.adjoint_comp, ContinuousLinearMap.adjoint_adjoint,
      ContinuousLinearMap.comp_apply, gramOp]
    rw [hproj c]
  have hAinj : Function.Injective A := by
    intro x y hxy
    have hx : ContinuousLinearMap.adjoint V (synthesis w x)
        = ContinuousLinearMap.adjoint V (synthesis w y) := hxy
    exact hinj (by rw [← hproj x, ← hproj y, hx])
  have hAbij : Function.Bijective
      (A : EuclideanSpace ℂ (Fin m) →ₗ[ℂ] EuclideanSpace ℂ (Fin m)) :=
    ⟨hAinj, (LinearMap.injective_iff_surjective (K := ℂ)).mp hAinj⟩
  let e := LinearEquiv.ofBijective
    (A : EuclideanSpace ℂ (Fin m) →ₗ[ℂ] EuclideanSpace ℂ (Fin m)) hAbij
  let T : EuclideanSpace ℂ (Fin m) →L[ℂ] EuclideanSpace ℂ (Fin m) :=
    LinearMap.toContinuousLinearMap
      (e.symm : EuclideanSpace ℂ (Fin m) →ₗ[ℂ] EuclideanSpace ℂ (Fin m))
  have hAT : ∀ c, A (T c) = c := fun c => e.apply_symm_apply c
  have hATcomp : A.comp T = ContinuousLinearMap.id ℂ (EuclideanSpace ℂ (Fin m)) :=
    ContinuousLinearMap.ext fun c => hAT c
  refine ⟨T, ⟨?_, ?_⟩, ?_⟩
  · intro x y hxy
    have hx := congrArg (fun z => A z) hxy
    simpa [hAT] using hx
  · exact fun y => ⟨A y, e.symm_apply_apply y⟩
  · have hid : (ContinuousLinearMap.adjoint (A.comp T)).comp (A.comp T)
        = ContinuousLinearMap.id ℂ (EuclideanSpace ℂ (Fin m)) := by
      rw [hATcomp]; ext c; simp
    rw [IsWhitening, ← hAA]
    rw [ContinuousLinearMap.adjoint_comp] at hid
    rw [← hid]
    ext c
    simp
