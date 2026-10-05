-- Generated from ChapterResolventCorrespondence.lean — theorem BookProof.ResolventCorrespondence.inner_relOfCLM
import Definitions.Def_ChapterClosureUniqueness
import Definitions.Def_ChapterA4
import Definitions.Def_ChapterPositiveSquareRootUnique
import Definitions.Def_ChapterNonnegSquareRoot
import Mathlib
import Definitions.Def_ChapterResolventCorrespondence
open BookProof.ResolventCorrespondence

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {R : F →L[ℂ] F} {T : Submodule ℂ (F × F)}



open BookProof.ClosureUniqueness BookProof.PositiveSquareRoot
open BookProof.NonnegSquareRoot
open scoped ComplexOrder


theorem BookProof.ResolventCorrespondence.inner_relOfCLM (h0 : 0 ≤ R) (h1 : R ≤ 1) {p : F × F} (hp : p ∈ relOfCLM R) :
    (inner ℂ p.1 p.2 : ℂ) = ((‖midOp R (p.1 + p.2)‖ ^ 2 : ℝ) : ℂ) := by sorry
