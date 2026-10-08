-- Generated from ChapterNonnegSquareRoot.lean — theorem BookProof.NonnegSquareRoot.sqrtRel_unique_nonneg_sqrt
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


theorem BookProof.NonnegSquareRoot.sqrtRel_unique_nonneg_sqrt (hT : IsNonnegSelfAdjoint T) :
    IsNonnegSelfAdjoint (sqrtRel hT) ∧
      {p : F × F | ∃ w, (p.1, w) ∈ sqrtRel hT ∧ (w, p.2) ∈ sqrtRel hT} = (T : Set (F × F)) ∧
      ∀ S : Submodule ℂ (F × F), IsNonnegSelfAdjoint S →
        {p : F × F | ∃ w, (p.1, w) ∈ S ∧ (w, p.2) ∈ S} = (T : Set (F × F)) →
        S = sqrtRel hT := by sorry
