-- Generated from ChapterNonnegSquareRoot.lean — theorem BookProof.NonnegSquareRoot.norm_sq_eq_inner_of_mem
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

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T S : Submodule ℂ (F × F)}



open BookProof.FarisLavine BookProof.EsaClosure BookProof.ClosureUniqueness
open BookProof.FriedrichsSquare BookProof.VonNeumannCore BookProof.UnboundedPolar
open BookProof.PositiveSquareRoot
open scoped ComplexOrder


theorem BookProof.NonnegSquareRoot.norm_sq_eq_inner_of_mem (hT : IsNonnegSelfAdjoint T)
    (hsv : ∀ v : F, ((0 : F), v) ∈ T → v = 0) {x z w : F} (hz : (x, z) ∈ T)
    (hw : (x, w) ∈ sqrtRel hT) : ‖w‖ ^ 2 = (inner ℂ x z : ℂ).re := by sorry
