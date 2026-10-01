-- Generated from ChapterNavierStokesEsa.lean — theorem BookProof.NavierStokesFlow.eq_zero_of_inner_left_eq_zero_on_dense
import Mathlib
import Definitions.Def_ChapterNavierStokesEsa
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]


open scoped Matrix




theorem BookProof.NavierStokesFlow.eq_zero_of_inner_left_eq_zero_on_dense {D : Submodule ℂ F} (hdense : Dense (D : Set F))
    (w : F) (hw : ∀ v : D, (inner ℂ (v : F) w : ℂ) = 0) : w = 0 := by sorry
