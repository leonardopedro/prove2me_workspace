-- Generated from ChapterVonNeumannCore.lean — theorem BookProof.VonNeumannCore.eq_zero_of_inner_frDom_eq_zero
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterFriedrichsSquareFactorization
import Mathlib
import Definitions.Def_ChapterVonNeumannCore
import Definitions.Def_ChapterClosureUniqueness
import Definitions.Def_ChapterEsaClosureCore
open BookProof.ClosureUniqueness
open BookProof.EsaClosure
open BookProof.VonNeumannCore



open BookProof.FarisLavine BookProof.EsaClosure BookProof.ClosureUniqueness
open BookProof.FriedrichsSquare

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}

variable [CompleteSpace F]

theorem BookProof.VonNeumannCore.eq_zero_of_inner_frDom_eq_zero (A : D →ₗ[ℂ] F) (hdense : Dense (D : Set F)) {x : F}
    (hx : ∀ u ∈ frDom A, (inner ℂ u x : ℂ) = 0) : x = 0 := by sorry
