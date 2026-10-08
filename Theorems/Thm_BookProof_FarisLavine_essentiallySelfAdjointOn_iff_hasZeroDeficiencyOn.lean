-- Generated from ChapterFarisLavine.lean — theorem BookProof.FarisLavine.essentiallySelfAdjointOn_iff_hasZeroDeficiencyOn
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesDeficiency
import Mathlib
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterNavierStokesFlow
open BookProof.FarisLavine



variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}



open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.LpNat



open scoped ENNReal


theorem BookProof.FarisLavine.essentiallySelfAdjointOn_iff_hasZeroDeficiencyOn
    (D : Submodule ℂ F) (H : D →ₗ[ℂ] D) :
    EssentiallySelfAdjointOn D (D.subtype.comp H) ↔ HasZeroDeficiencyOn D H := by sorry
