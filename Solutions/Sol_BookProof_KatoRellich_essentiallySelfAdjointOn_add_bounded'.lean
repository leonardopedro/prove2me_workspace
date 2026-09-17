-- Generated from ChapterKatoRellichRelative.lean — solution of BookProof.KatoRellich.essentiallySelfAdjointOn_add_bounded'
import Mathlib
import Definitions.Def_ChapterKatoRellichRelative
import Theorems.Thm_BookProof_KatoRellich_essentiallySelfAdjointOn_add_relBounded
open BookProof.KatoRellich




open BookProof.FarisLavine

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}

set_option maxHeartbeats 1000000 in
theorem solution [CompleteSpace F] (H : D →ₗ[ℂ] F)
    (hH : SymmetricOn D H) (hesa : EssentiallySelfAdjointOn D H) (B : F →L[ℂ] F)
    (hB : ∀ x y : F, (inner ℂ (B x) y : ℂ) = inner ℂ x (B y)) :
    EssentiallySelfAdjointOn D (H + (B.toLinearMap ∘ₗ D.subtype)) :=
  essentiallySelfAdjointOn_add_relBounded H _ hH hesa
      (fun x y => hB (x : F) (y : F)) le_rfl one_pos (norm_nonneg B)
      (fun x => by simpa using B.le_opNorm (x : F))
