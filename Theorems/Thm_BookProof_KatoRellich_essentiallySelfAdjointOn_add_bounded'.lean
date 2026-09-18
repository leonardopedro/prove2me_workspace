-- Generated from ChapterKatoRellichRelative.lean — theorem BookProof.KatoRellich.essentiallySelfAdjointOn_add_bounded'
import Mathlib
import Definitions.Def_ChapterKatoRellichRelative
import Definitions.Def_ChapterHashimotoShiftInvert
import Definitions.Def_ChapterShiftedHermiteCore
import Definitions.Def_ChapterNavierStokesHashimoto
open BookProof.ChapterKatoRellichRelative



open BookProof.FarisLavine

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}

theorem BookProof.KatoRellich.essentiallySelfAdjointOn_add_bounded' [CompleteSpace F] (H : D →ₗ[ℂ] F)
    (hH : SymmetricOn D H) (hesa : EssentiallySelfAdjointOn D H) (B : F →L[ℂ] F)
    (hB : ∀ x y : F, (inner ℂ (B x) y : ℂ) = inner ℂ x (B y)) :
    EssentiallySelfAdjointOn D (H + (B.toLinearMap ∘ₗ D.subtype)) := by sorry
