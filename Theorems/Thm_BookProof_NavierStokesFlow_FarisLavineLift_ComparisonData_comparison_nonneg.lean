-- Generated from ChapterNavierStokesFarisLavineLift.lean — theorem BookProof.NavierStokesFlow.FarisLavineLift.ComparisonData.comparison_nonneg
import Mathlib
import Definitions.Def_ChapterNavierStokesFarisLavineLift
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FarisLavineLift




open FullEsa

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {d : ℕ} (c : ComparisonData F d)

theorem BookProof.NavierStokesFlow.FarisLavineLift.ComparisonData.comparison_nonneg (v : c.D) :
    0 ≤ (inner ℂ ((v : F)) ((c.comparison v : c.D) : F) : ℂ).re := by sorry
