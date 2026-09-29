-- Generated from ChapterYangMillsFriedrichsLimit.lean — solution of BookProof.YangMillsFriedrichsLimit.friedrichs_of_bounded
import Mathlib
import Definitions.Def_ChapterYangMillsFriedrichsLimit
import Theorems.Thm_BookProof_YangMillsFriedrichsLimit_symmetricOn_top_of_dense
import Theorems.Thm_BookProof_YangMillsFriedrichsLimit_quadForm_top_nonneg_of_dense
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterFarisLavine
open BookProof.YangMillsFriedrichsLimit









open BookProof.FarisLavine BookProof.YangMillsFriedrichs



variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

set_option maxHeartbeats 1000000 in
theorem solution [CompleteSpace F] {D : Submodule ℂ F} (H : D →ₗ[ℂ] F)
    (hdense : Dense (D : Set F)) (hsym : SymmetricOn D H)
    (hpos : ∀ x : D, 0 ≤ quadForm H x) (C : ℝ) (hbd : ∀ x : D, ‖H x‖ ≤ C * ‖(x : F)‖) :
    ∃ A : F →L[ℂ] F, (∀ x : D, A (x : F) = H x) ∧
      IsPositiveSelfAdjointExtension H (topRestrict A) := by

  -- the continuous extension
  have hb : ∀ x : D, ‖H x‖ ≤ C * ‖x‖ := fun x => by simpa using hbd x
  set Hc : D →L[ℂ] F := H.mkContinuous C hb with hHc
  have hdr : DenseRange (D.subtypeL) := by
    simpa [DenseRange, Submodule.subtypeL, Set.range_comp] using hdense
  have hui : IsUniformInducing (D.subtypeL) :=
    (isometry_subtype_coe (s := (D : Set F))).isUniformInducing
  set A : F →L[ℂ] F := Hc.extend D.subtypeL with hA
  have hagree : ∀ x : D, A (x : F) = H x := by
    intro x
    have := Hc.extend_eq hdr hui x
    simpa [hA, hHc] using this
  refine ⟨A, hagree, ?_, ?_, ?_, ?_⟩
  · intro x
    exact ⟨trivial, by simpa using hagree x⟩
  · refine symmetricOn_top_of_dense A hdense ?_
    intro x y
    rw [hagree x, hagree y]
    exact hsym x y
  · refine quadForm_top_nonneg_of_dense A hdense ?_
    intro x
    have := hpos x
    rwa [quadForm, ← hagree x] at this
  · -- the adjoint condition on the full space
    intro w u hw
    refine ⟨trivial, ?_⟩
    have hsymtop : SymmetricOn (⊤ : Submodule ℂ F) (topRestrict A) := by
      refine symmetricOn_top_of_dense A hdense ?_
      intro x y
      rw [hagree x, hagree y]
      exact hsym x y
    have hzero : ∀ v : (⊤ : Submodule ℂ F),
        (inner ℂ (v : F) (topRestrict A ⟨w, trivial⟩ - u) : ℂ) = 0 := by
      intro v
      rw [inner_sub_right, ← hw v, ← hsymtop v ⟨w, trivial⟩]
      ring
    have hd : (inner ℂ (topRestrict A ⟨w, trivial⟩ - u) (topRestrict A ⟨w, trivial⟩ - u) : ℂ) = 0 :=
      hzero ⟨topRestrict A ⟨w, trivial⟩ - u, trivial⟩
    exact sub_eq_zero.mp (inner_self_eq_zero.mp hd)
