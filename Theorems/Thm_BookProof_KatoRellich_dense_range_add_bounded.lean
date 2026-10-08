-- Generated from ChapterKatoRellichDeficiency.lean — theorem BookProof.KatoRellich.dense_range_add_bounded
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterKatoRellichDeficiency
import Definitions.Def_ChapterFarisLavineCore
open BookProof.KatoRellich



open BookProof.FarisLavine

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}


theorem BookProof.KatoRellich.dense_range_add_bounded (H : D →ₗ[ℂ] F) (hH : SymmetricOn D H)
    (B : F →L[ℂ] F) (e : ℝ) (he : ‖B‖ < |e|)
    (hdense : Dense (Set.range fun x : D => H x - ((e : ℂ) * Complex.I) • (x : F))) :
    Dense (Set.range fun x : D => (H x + B (x : F)) - ((e : ℂ) * Complex.I) • (x : F)) := by sorry
