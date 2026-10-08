-- Generated from ChapterClosureUniqueness.lean — theorem BookProof.ClosureUniqueness.adjGraph_eq_adjPairs_clGraph
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterClosureUniqueness
import Definitions.Def_ChapterEsaClosureCore
open BookProof.EsaClosure
open BookProof.ClosureUniqueness



open BookProof.FarisLavine BookProof.EsaClosure

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D D₁ D₂ Dom Dom₁ Dom₂ : Submodule ℂ F}


theorem BookProof.ClosureUniqueness.adjGraph_eq_adjPairs_clGraph (T : D →ₗ[ℂ] F) : adjGraph T = adjPairs (clGraph T) := by sorry
