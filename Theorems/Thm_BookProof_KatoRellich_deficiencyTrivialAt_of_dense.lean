-- Generated from ChapterKatoRellichDeficiency.lean — theorem BookProof.KatoRellich.deficiencyTrivialAt_of_dense
import Mathlib
import Definitions.Def_ChapterKatoRellichDeficiency
open BookProof.KatoRellich

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}



open BookProof.FarisLavine

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}

theorem BookProof.KatoRellich.deficiencyTrivialAt_of_dense (T : D →ₗ[ℂ] F) (z : ℂ)
    (hd : Dense (Set.range fun x : D => T x - ((starRingEnd ℂ) z) • (x : F))) :
    DeficiencyTrivialAt D T z := by sorry
