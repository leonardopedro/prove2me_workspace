-- Generated from ChapterNavierStokesEsa.lean — theorem BookProof.NavierStokesFlow.eq_zero_of_hasDerivAt_smul_of_bounded
import Mathlib
import Definitions.Def_ChapterNavierStokesEsa
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]


open scoped Matrix




theorem BookProof.NavierStokesFlow.eq_zero_of_hasDerivAt_smul_of_bounded (g : ℝ → ℂ) (s C : ℝ) (hs : s * s = 1)
    (hgd : ∀ t : ℝ, HasDerivAt g ((s : ℂ) * g t) t) (hb : ∀ t : ℝ, ‖g t‖ ≤ C) : g 0 = 0 := by sorry
