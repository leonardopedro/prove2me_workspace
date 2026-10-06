-- Generated from ChapterResolventCorrespondence.lean — solution of BookProof.ResolventCorrespondence.relOfCLM_quadForm_nonneg
import Mathlib
import Definitions.Def_ChapterResolventCorrespondence
import Theorems.Thm_BookProof_ResolventCorrespondence_inner_relOfCLM
open BookProof.ResolventCorrespondence




open BookProof.ClosureUniqueness BookProof.UnboundedPolar BookProof.PositiveSquareRoot
open BookProof.NonnegSquareRoot
open scoped ComplexOrder

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {R : F →L[ℂ] F} {T : Submodule ℂ (F × F)}

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {R : F →L[ℂ] F} {T : Submodule ℂ (F × F)}

set_option maxHeartbeats 1000000 in
theorem solution (h0 : 0 ≤ R) (h1 : R ≤ 1) {p : F × F} (hp : p ∈ relOfCLM R) :
    0 ≤ (inner ℂ p.1 p.2 : ℂ).re := by

  rw [inner_relOfCLM h0 h1 hp, Complex.ofReal_re]
  positivity
