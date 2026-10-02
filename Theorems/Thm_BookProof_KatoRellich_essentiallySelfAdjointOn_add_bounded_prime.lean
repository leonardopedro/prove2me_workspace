-- Generated from ChapterKatoRellichRelative.lean — theorem BookProof.KatoRellich.essentiallySelfAdjointOn_add_bounded'
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterKatoRellichRelative
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterA4

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}



open BookProof.FarisLavine


theorem BookProof.KatoRellich.essentiallySelfAdjointOn_add_bounded_prime [CompleteSpace F] (H : D →ₗ[ℂ] F)
    (hH : SymmetricOn D H) (hesa : EssentiallySelfAdjointOn D H) (B : F →L[ℂ] F)
    (hB : ∀ x y : F, (inner ℂ (B x) y : ℂ) = inner ℂ x (B y)) :
    EssentiallySelfAdjointOn D (H + (B.toLinearMap ∘ₗ D.subtype)) := by sorry
