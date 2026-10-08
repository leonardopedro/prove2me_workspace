-- Generated from ChapterNonnegSquareRoot.lean — theorem BookProof.NonnegSquareRoot.eq_sqrtRel_of_isNonnegSelfAdjoint
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterClosureUniqueness
import Definitions.Def_ChapterFriedrichsSquareFactorization
import Definitions.Def_ChapterVonNeumannCore
import Definitions.Def_ChapterA4
import Definitions.Def_ChapterPositiveSquareRootUnique
import Mathlib
import Definitions.Def_ChapterNonnegSquareRoot
open BookProof.NonnegSquareRoot



open BookProof.FarisLavine BookProof.EsaClosure BookProof.ClosureUniqueness
open BookProof.FriedrichsSquare BookProof.VonNeumannCore BookProof.UnboundedPolar
open BookProof.PositiveSquareRoot
open scoped ComplexOrder

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T S : Submodule ℂ (F × F)}


theorem BookProof.NonnegSquareRoot.eq_sqrtRel_of_isNonnegSelfAdjoint (hT : IsNonnegSelfAdjoint T)
    (hS : IsNonnegSelfAdjoint S)
    (hsq : ∀ p : F × F, (∃ w, (p.1, w) ∈ S ∧ (w, p.2) ∈ S) → p ∈ T) :
    S = sqrtRel hT := by sorry
