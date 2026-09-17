-- Generated from ChapterKatoRellichRelative.lean — theorem BookProof.KatoRellich.essentiallySelfAdjointOn_add_relBounded
import Mathlib
import Definitions.Def_ChapterKatoRellichRelative
open BookProof.KatoRellich



open BookProof.FarisLavine

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}

theorem BookProof.KatoRellich.essentiallySelfAdjointOn_add_relBounded [CompleteSpace F] (H B : D →ₗ[ℂ] F)
    (hH : SymmetricOn D H) (hesa : EssentiallySelfAdjointOn D H) (hB : SymmetricOn D B)
    {a b : ℝ} (ha : 0 ≤ a) (ha1 : a < 1) (hb : 0 ≤ b)
    (hrel : ∀ x : D, ‖B x‖ ≤ a * ‖H x‖ + b * ‖(x : F)‖) :
    EssentiallySelfAdjointOn D (H + B) := by sorry
