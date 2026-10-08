-- Generated from ChapterVonNeumannCore.lean — theorem BookProof.VonNeumannCore.resCLM_mem_frDom
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterClosureUniqueness
import Definitions.Def_ChapterFriedrichsSquareFactorization
import Mathlib
import Definitions.Def_ChapterVonNeumannCore
import Definitions.Def_ChapterStoneResolvent
open BookProof.VonNeumannCore



open BookProof.FarisLavine BookProof.EsaClosure BookProof.ClosureUniqueness
open BookProof.FriedrichsSquare

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}

variable [CompleteSpace F]

theorem BookProof.VonNeumannCore.resCLM_mem_frDom (A : D →ₗ[ℂ] F) (h : F) : resCLM A h ∈ frDom A := by sorry
