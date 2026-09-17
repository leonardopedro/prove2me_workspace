-- Generated from ChapterKatoRellichRelative.lean — theorem BookProof.KatoRellich.norm_le_of_relBound
import Mathlib
import Definitions.Def_ChapterKatoRellichRelative
open BookProof.KatoRellich



open BookProof.FarisLavine

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}

theorem BookProof.KatoRellich.norm_le_of_relBound (H B : D →ₗ[ℂ] F) (hH : SymmetricOn D H) {a b e : ℝ}
    (ha : 0 ≤ a) (hb : 0 ≤ b) (he : e ≠ 0)
    (hrel : ∀ x : D, ‖B x‖ ≤ a * ‖H x‖ + b * ‖(x : F)‖) (x : D) :
    ‖B x‖ ≤ (a + b / |e|) * ‖H x - ((e : ℂ) * Complex.I) • (x : F)‖ := by sorry
