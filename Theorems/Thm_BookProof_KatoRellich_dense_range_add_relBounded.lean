-- Generated from ChapterKatoRellichRelative.lean — theorem BookProof.KatoRellich.dense_range_add_relBounded
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterKatoRellichRelative
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterKatoRellichDeficiency
open BookProof.KatoRellich



open BookProof.FarisLavine

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}


theorem BookProof.KatoRellich.dense_range_add_relBounded (H B : D →ₗ[ℂ] F) (hH : SymmetricOn D H) {a b e : ℝ}
    (ha : 0 ≤ a) (hb : 0 ≤ b) (he : e ≠ 0)
    (hrel : ∀ x : D, ‖B x‖ ≤ a * ‖H x‖ + b * ‖(x : F)‖) (hq1 : a + b / |e| < 1)
    (hdense : Dense (Set.range fun x : D => H x - ((e : ℂ) * Complex.I) • (x : F))) :
    Dense (Set.range fun x : D => (H x + B x) - ((e : ℂ) * Complex.I) • (x : F)) := by sorry
