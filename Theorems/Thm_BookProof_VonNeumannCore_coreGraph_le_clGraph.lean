-- Generated from ChapterVonNeumannCore.lean — theorem BookProof.VonNeumannCore.coreGraph_le_clGraph
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterClosureUniqueness
import Mathlib
import Definitions.Def_ChapterVonNeumannCore
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterA4
open BookProof.EsaClosure
open BookProof.VonNeumannCore

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}
variable [CompleteSpace F]



open BookProof.FarisLavine BookProof.EsaClosure BookProof.ClosureUniqueness
open BookProof.FriedrichsSquare


theorem BookProof.VonNeumannCore.coreGraph_le_clGraph (A : D →ₗ[ℂ] F) : coreGraph A ≤ clGraph A := by sorry
